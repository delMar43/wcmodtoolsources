// Wing Commander bitmap object navigator (32bit) v4 23-AUG-1999
// Written by Maciek Korzeniowski <matrix3d@polbox.com>
// Attempts to detect and view most WC1/WC2/PRIV1 and some Armada graphics
// Based on WC1VIEW, WC2VIEW & WC1B.TXT by Mario "HCl" Brito
// Compiles without modification under DJGPP 2.01
// Tab Size = 3

#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <dos.h>
#include <mem.h>
#include <io.h>
#include <fcntl.h>

#include <pc.h>					// required for outportb()
#include <dpmi.h>					// required for __dpmi_segment_to_descriptor()
#include <sys/segments.h>		// required for _my_ds()
#include <sys/farptr.h>			// required for _farpoke?()
#include <sys/movedata.h>		// required for movedata?()

#include "palwc1.h"
#include "palwc2.h"
#include "palwc3.h"
#include "palwc4.h"

#include "palwcarm.h"

#include "palpr1.h"

//#define DEBUG

#ifdef __DJGPP__
char **__crt0_glob_function(char *arg)
	{
	return 0;
	}

void __crt0_load_environment_file(char *progname)
	{
   // Do nothing
   }
#endif

#define point(x,y) videobuffer[((x)+((y)<<6)+((y)<<8))&0xFFFF]
#define putpixel(x,y,color) videobuffer[((x)+((y)<<6)+((y)<<8))&0xFFFF]=color
#define plot(x,y) videobuffer[((x)+((y)<<6)+((y)<<8))&0xFFFF]=currentcolor

//#define point(x,y) _farpeekb(video,(x+(y<<6)+(y<<8))&0xFFFF)
//#define putpixel(x,y,color) _farpokeb(video,(x+(y<<6)+(y<<8))&0xFFFF,color)
//#define plot(x,y) _farpokeb(video,(x+(y<<6)+(y<<8))&0xFFFF,currentcolor)

#define clearscreen() memset(videobuffer,0,64000)
unsigned char videobuffer[65536];
short video;	// Protected Mode selector
int currentcolor=15;

#define READBYTE (index<length ? filebuffer[index++] : 0)
#define READWORD(var) var=READBYTE; var+=READBYTE<<8

enum {UNKNOWN, WC1, WC2, WC3, WC4, PRIV, PAK, SHP} wcflag=UNKNOWN;	// Which Wing Commander indicator (for palette)
int frame=0;
int SHPfile=0;
char *palette;
unsigned char *filebuffer;
long length, skip, offset=0;
int xcentre=0, ycentre=0;

#define MAXOFFSET 1600
long offsets[MAXOFFSET];
int numoffsets=0;

////////////////////////////////////////////////////////////////////////////
// Write BMP ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
int saveBMP(char *filename)
{
FILE *BMPfile;
unsigned long writelong;
unsigned short writeshort;
unsigned long filesize=0;
#define HEADERSIZE 40

unsigned long xsize=320, ysize=200;
int count,x,y,color;

filesize=xsize*ysize+HEADERSIZE;
BMPfile=fopen(filename,"wb");
if(BMPfile==NULL)
	{
	printf("Unable to open %s for writing.\n",filename);
	return -1;
	}
fputc('B',BMPfile); 	fputc('M',BMPfile);	// Identifier
writelong=filesize; 	fwrite(&writelong,4,1,BMPfile);	// File size (header+data)
writelong=0; 			fwrite(&writelong,4,1,BMPfile);	// Reserved
writelong=54+4*256;	fwrite(&writelong,4,1,BMPfile);	// Offset to data
writelong=0x28; 		fwrite(&writelong,4,1,BMPfile);	// Header size
writelong=xsize; 		fwrite(&writelong,4,1,BMPfile); // Width
writelong=ysize; 		fwrite(&writelong,4,1,BMPfile);	// Height
writeshort=1; 			fwrite(&writeshort,2,1,BMPfile);	// Planes
writeshort=8; 			fwrite(&writeshort,2,1,BMPfile);	// Bit per pixel
writelong=0; 			fwrite(&writelong,4,1,BMPfile);	// Compression - 0 (none)
writelong=xsize*ysize+3&0xFFFFFFFC;
							fwrite(&writelong,4,1,BMPfile);	// Data size !rounded!
writelong=0; 			fwrite(&writelong,4,1,BMPfile);	// HRes
writelong=0; 			fwrite(&writelong,4,1,BMPfile);	// VRes
writelong=256; 		fwrite(&writelong,4,1,BMPfile);	// Number of colors
writelong=256;			fwrite(&writelong,4,1,BMPfile);	// Important colors (all)
//0x36
for(count=0; count<256; count++)
	{
	fputc(palette[count*3+2]*4,BMPfile);	// Blue
	fputc(palette[count*3+1]*4,BMPfile);	// Green
	fputc(palette[count*3+0]*4,BMPfile);	// Red
	fputc(0,BMPfile);	// Padding
	}
//0x436
for (y=0; y<200; y++)
	{
	for(x=0; x<320; x++)
		{
		color=(int)point(x,(199-y));
		fputc(color,BMPfile);
		}
	}
fclose(BMPfile);
return 0;
}

////////////////////////////////////////////////////////////////////////////
// Graphics routines ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
void setvideomode(void)
{
union REGS regs;

regs.h.ah=0x00;
regs.h.al=0x13;
int86(0x10,&regs,&regs);

video = __dpmi_segment_to_descriptor(0xA000);
}

void settextmode(void)
{
union REGS regs;

regs.h.ah=0x00;
regs.h.al=0x03;
int86(0x10,&regs,&regs);
}

void vwait(void)
{
while((inp(0x3DA)&8));  //Wait for retrace end
while(!(inp(0x3DA)&8));   //Wait for retrace begin
}

/*
void clearscreen(void)
{
asm {
	mov ax,0xA000
	mov es,ax
	mov di,0
	mov cx,0x7D00
	mov ax,0
	rep stosw
	}
}
*/

void setpalette (char *newpalette)
{
int count,x,y;

palette=newpalette;
outportb(0x3C8,0);         //begin with colour 0
for(count=0; count<768; count++)
	outportb(0x3C9,palette[count]);;    //send the palette-data to port 3c9h
}

void nprint(unsigned int x, unsigned int y, long value)
{
unsigned char digit;

do
	{
	digit=value%10;	value/=10;
	switch (digit)
		{
		case 0 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x,y+1); plot(x+2,y+1);
						 plot(x,y+2); plot(x+2,y+2);
						 plot(x,y+3); plot(x+2,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 1 : plot(x+2,y);
						 plot(x+2,y+1);
						 plot(x+2,y+2);
						 plot(x+2,y+3);
						 plot(x+2,y+4);
						 break;
		case 2 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x+2,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 3 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x+2,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x+2,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 4 : plot(x,y); plot(x+2,y);
						 plot(x,y+1); plot(x+2,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x+2,y+3);
						 plot(x+2,y+4);
						 break;
		case 5 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x+2,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 6 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x,y+3); plot(x+2,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 7 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x+2,y+1);
						 plot(x+2,y+2);
						 plot(x+1,y+3);
						 plot(x+1,y+4);
						 break;
		case 8 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x,y+1); plot(x+2,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x,y+3); plot(x+2,y+3);
						 plot(x,y+4); plot(x+1,y+4); plot(x+2,y+4);
						 break;
		case 9 : plot(x,y); plot(x+1,y); plot(x+2,y);
						 plot(x,y+1); plot(x+2,y+1);
						 plot(x,y+2); plot(x+1,y+2); plot(x+2,y+2);
						 plot(x+2,y+3);
						 plot(x+2,y+4);
						 break;
		}
	x-=4;
	}
while(value>0);
}

////////////////////////////////////////////////////////////////////////////
// RLE decoder (based on routine by Mario "HCl" Brito) /////////////////////
////////////////////////////////////////////////////////////////////////////
void displayframe(void)
{
int x1, x2, y1, y2, key, deltax, deltay, x, y, a, b, carry;
unsigned char buffer, color;
long index;


index=offset;
// Read dimensions of the image.
READWORD(x2);
READWORD(x1);
READWORD(y1);
READWORD(y2);

//if(((x1==0)&&(x2==0))||((y1==0)&&(y2==0)))	// If image is flat...
//	return;	// ...then don't even bother

if((frame!=0)&&((abs(x1)+abs(x2))<320)&&((abs(y1)+abs(y2))<200))
	{
	// Dark grey background for bitmap
	for(y=ycentre-y1; y<ycentre+y2+1; y++)
		for(x=xcentre-x1; x<xcentre+x2+1; x++)
			putpixel(x,y,8);
	// White border around bitmap
	for(x=xcentre-x1-1; x<xcentre+x2+2; x++)
		{
		putpixel(x,ycentre-y1-1,7);
		putpixel(x,ycentre+y2+1,7);
		}
	for(y=ycentre-y1; y<=ycentre+y2; y++)
		{
		putpixel(xcentre-x1-1,y,7);
		putpixel(xcentre+x2+1,y,7);
		}
	}

//return;
//This loop puts the image on screen
while (1)
	{
	READWORD(key);
	if((key==0)||(index>length))
		break;  // End of image, exit loop
	READWORD(deltax);
	READWORD(deltay);
	x=xcentre+deltax;
	y=ycentre+deltay;
	carry=key&1; 					// RLE string indicator

	if (carry==0)	// not an RLE string...
		{
		for (a=0; a<(key>>1); a++, x++)	//...read key>>1 pixels
			{
			color=READBYTE; if(index>=length) return;
			putpixel(x,y,color);
			}
		}
	else	// process RLE string
		{
		b=0;

		while(b<(key>>1))
			{
			buffer=READBYTE; if(index>=length) return;

			if ((buffer&1)==0)	// not an RLE string...
				{
				for (a=0; a<(buffer>>1); a++, b++, x++)	//...read buffer>>1 pixels
					{
					color=READBYTE; if(index>=length) return;
					putpixel (x,y,color);
					}
				}
			else	// process secondary RLE sring
				{
				color=READBYTE; if(index>=length) return;
				for (a=0; a<(buffer>>1); a++, b++, x++)
					{
					putpixel(x,y,color);
					}
				}
			}
		}
	}
	skip=index;
}

////////////////////////////////////////////////////////////////////////////
// Read entire file into memory ////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
int loadfile(char *filename)
{
FILE *gfxfile;
long lenread=0;

gfxfile=fopen(filename,"rb");
if (gfxfile==NULL)
	{
	printf("Unable to open file %s\n",filename);
	return -1;
	}
printf("Opened file %s...",filename);

// Jump to end to see how long the file is
// NB: Can't think of a better way - filelength() is non-ANSI
fseek(gfxfile,0,SEEK_END);
length=ftell(gfxfile);
rewind(gfxfile);

printf("%li bytes...",length);

filebuffer=(unsigned char *)malloc(length);	// Allocate RAM for whole file
if(filebuffer==NULL)
	{
	printf("Unable to allocate memory\n");
	return -1;
	}
printf("allocated...",length);

// Read entire file into memory, from start, in 64000 byte blocks
lenread=0;
do
	{
	lenread+=(long)fread((void *)(filebuffer+lenread),1,64000,gfxfile);
	#ifdef DEBUG
	printf("...%li",lenread);
	#endif
	}
while(lenread<length);
printf("and loaded.\n\n");
fclose(gfxfile);
return 0;
}

////////////////////////////////////////////////////////////////////////////
// Free loaded file ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
void unloadfile()
{
free((void *)filebuffer);	// free file
settextmode(); // back to text mode...
}

////////////////////////////////////////////////////////////////////////////
// Attempt type detection //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
void detect(char *filename)
{
int i;
struct ftime ftimep;

printf("Attempt auto-detect...");

// Check if it is an IFF file
if((filebuffer[0]=='F')&&
	(filebuffer[1]=='O')&&
	(filebuffer[2]=='R')&&
	(filebuffer[3]=='M')&&
	(strstr(filename,".IFF")!=NULL))
	{
	wcflag=PRIV;
	printf("Privateer/Armada IFF");
	xcentre=160; ycentre=100;
	}
else if(strstr(filename,".PAK")!=NULL)
	{
	wcflag=PAK;
	printf("Privateer PAK");
	}
else if(strstr(filename,".SHP")!=NULL)
	{
	wcflag=SHP;
	//SHPfile=1;
	printf("Privateer/Armada SHP");
	xcentre=160; ycentre=100;
	}
// Check if first four bytes are size
else if(((((unsigned long )filebuffer[0]&255))|
		  (((unsigned long )filebuffer[1]&255)<<8)|
		  (((unsigned long )filebuffer[2]&255)<<16)|
		  (((unsigned long )filebuffer[3]&255)<<24))==length)
	{
	switch(filebuffer[4])		// Check header size for any hints on type
		{
		case 0x10 : wcflag=WC1; printf("WC1 fighter"); xcentre=160, ycentre=100; break;
		case 0x18 : wcflag=WC2; printf("WC2 fighter"); xcentre=160, ycentre=100; break;
		case 0x9C : wcflag=WC1; printf("WC1 capship"); xcentre=160, ycentre=100; break;
		case 0xA8 : wcflag=WC2; printf("WC2 capship"); xcentre=160, ycentre=100; break;
		case 0x2C : wcflag=WC1; printf("WC1 cockpit"); break;
		case 0x44 : wcflag=WC2; printf("WC2 cockpit"); break;
		default :   printf("<shrug>");
							//Use file date to determine wcflag
							i=open(filename,O_RDONLY||O_BINARY); getftime(i,&ftimep); close(i);
							// If year = 1991 then WC1
							if(ftimep.ft_year==11) wcflag=1;
							break;
		}
	}
else
	{
	printf("You sure this is a WC1/2/Priv graphics file?");
	}
printf("...");
}

////////////////////////////////////////////////////////////////////////////
// Offset extraction ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
void getoffsetsFORM(unsigned long *lastcount)
{
unsigned long count;
unsigned long other;
int lastnumoffsets=0;
unsigned long TOOptr, TOOend;	// Table-Of-Offsets - current position and end
unsigned long TOIptr, TOIend;	// Table-Of-Images  - current position and end

count=*lastcount;	// Read current offset
// Read FORM size - comes in handy later
TOOend =((unsigned long)filebuffer[count++]&255)<<24;
TOOend|=((unsigned long)filebuffer[count++]&255)<<16;
TOOend|=((unsigned long)filebuffer[count++]&255)<<8;
TOOend|=((unsigned long)filebuffer[count++]&255);
TOOend+=count;	// Add base to make TOOend indicate form end

// Store offsets, adding them until form end reached
while(count<TOOend)
	{
	#ifdef DEBUG
	printf("Base %lX\n",count);
	#endif

	// Determine where table ends
	TOIend =((unsigned long)filebuffer[count+4]&255);
	TOIend|=((unsigned long)filebuffer[count+5]&255)<<8;
	TOIend|=((unsigned long)filebuffer[count+6]&255)<<16;
	TOIend+=count;
	// Check table end is not out of file bounds
	if(TOIend>length)
		{
		#ifdef DEBUG
		printf("Suspiciously large FORM - skipping\n");
		#endif
		}
	else
		{
		lastnumoffsets=numoffsets;
		for(other=count+4; other<TOIend; other++)
			{
			TOIptr =((unsigned long)filebuffer[other++]&255);
			TOIptr|=((unsigned long)filebuffer[other++]&255)<<8;
			TOIptr|=((unsigned long)filebuffer[other++]&255)<<16;
			offsets[numoffsets]=count+TOIptr;
			// Is offset is out of FORM bounds - more accurate than file bounds
			if(offsets[numoffsets]>TOOend)
				{
				#ifdef DEBUG
				printf("Offset beyond FORM end - undoing suspect table\n");
				#endif
				numoffsets=lastnumoffsets;	// rollback
				break;	// continue with next
				}
			#ifdef DEBUG
			printf("   + %lX\n",offsets[numoffsets]);
			#endif
			numoffsets++;
			}
		}
	// Read relative offset
	TOOptr =((unsigned long)filebuffer[count+0]&255);
	TOOptr|=((unsigned long)filebuffer[count+1]&255)<<8;
	TOOptr|=((unsigned long)filebuffer[count+2]&255)<<16;
	//TOOcode=       filebuffer[count+3];
	if(TOOptr==0)	// Safety check to prevent endless loop in some files
		{
		#ifdef DEBUG
		printf("Zero offset found - breaking out.\n");
		#endif
		break;
		}
	//Jump to next image within form
	count+=TOOptr;
	#ifdef DEBUG
	getch();
	#endif
	}
	//*lastcount=count;	// Set forward
}

void seekform(const char *tag)
{
unsigned long count;
int taglen, tagcount;

taglen=strlen(tag);	// The length of the tag we are seeking
tagcount=0;					// Countdown = length when found

for(count=0; count<length; )
	{
	if(filebuffer[count++]==tag[tagcount])
   	{
      tagcount++;
		if(tagcount==taglen)
			{
			#ifdef DEBUG
   		printf("Found %s after %lX\n",tag,count);
   		#endif
   		getoffsetsFORM(&count);
   		}
      }
   else
   	tagcount=0;
   }
}

int getoffsets()
{
unsigned long count;
int lastnumoffsets=0;
unsigned long TOOptr, TOOend;	// Table-Of-Offsets - current position and end
unsigned long TOIptr, TOIend;	// Table-Of-Images  - current position and end
unsigned char TOOcode, TOIcode;
unsigned long TOIlen;
unsigned long base;

//Clear them all
for(count=0; count<MAXOFFSET; count++)
	{
	offsets[count]=0;
	}
numoffsets=0;

// Detect type of extraction
if(wcflag==PRIV)
	{
	// Find recognised forms to decode
   seekform("SHAP");

   seekform("VSHP");       // Privateer ships

   // Armada cockpits
   seekform("CFRO");
   seekform("CBAK");
   seekform("CLEF");
   seekform("CRIG");


   seekform("GRID"); 		// Priv NavMap
   seekform("GUNS");			// Priv weapon icons
   seekform("MFDSTARG");	// Priv target display
   seekform("TARGSEEK");	// Armada target display
	}
else	// all non-IFFs (VGA, Vnn, PAK, SHP and unknowns)
	{
	// Level 1
	TOOptr=0;

	// Determine where table ends
	TOOend =((long)filebuffer[TOOptr+4]&255);
	TOOend|=((long)filebuffer[TOOptr+5]&255)<<8;
	TOOend|=((long)filebuffer[TOOptr+6]&255)<<16;
	//NOT!!! TOOend=((long *)filebuffer)[TOOptr]&0xFFFFFF;
	//because (long *) causes indexes to be every four bytes

	TOOptr+=4;	// Skip (file) length (4 bytes)
	#ifdef DEBUG
	printf("End at 0x%lX\n",TOOend);
	#endif
	while(TOOptr<TOOend)
		{
		// Level 2
		#ifdef DEBUG
		printf("@ 0x%lX : ",TOOptr);
		#endif
		TOIptr =((long)filebuffer[TOOptr++]&255);
		TOIptr|=((long)filebuffer[TOOptr++]&255)<<8;
		TOIptr|=((long)filebuffer[TOOptr++]&255)<<16;
		//TOIcode=       filebuffer[TOOptr++];
		TOOptr++;

  		TOIlen =((unsigned long)filebuffer[TOIptr+0]&255);
  		TOIlen|=((unsigned long)filebuffer[TOIptr+1]&255)<<8;
  		TOIlen|=((unsigned long)filebuffer[TOIptr+2]&255)<<16;
  		// NB: Remove line below if length takes only 3 bytes
  		TOIlen|=((unsigned long)filebuffer[TOIptr+3]&255)<<24;

      // No (block) length in SHP file - just skip 4 bytes
		if(wcflag==SHP)
			{
			#ifdef DEBUG
			printf("SHP file - no block length\n");
			#endif
			offsets[numoffsets]=TOIptr;
			numoffsets++;
			}
      else
      	{
   		// If expected length is too large warn user and ignore
   		if(TOIlen>(length-TOIptr))
   			{
   			#ifdef DEBUG
   			printf("Suspiciously large block - skipping\n");
   			#endif
   			}
   		else
   			{
   			//if(TOIcode!=0xE0)
   			base=TOIptr;	// Base to add image offsets to - before skipping run length (4 bytes)
   			#ifdef DEBUG
   			printf("0x%lX = %li\n",base,base);
   			#endif
   
   			// Determine where table ends
   			TOIend =((long)filebuffer[TOIptr+4]&255);
   			TOIend|=((long)filebuffer[TOIptr+5]&255)<<8;
   			TOIend|=((long)filebuffer[TOIptr+6]&255)<<16;
   			#ifdef DEBUG
   			printf("+  ^ 0x%lX\n",TOIend);
   			#endif
   			TOIend+=base;
   
   			TOIptr+=4;	// Skip (block) length (4 bytes)
   			#ifdef DEBUG
   			printf("+  # 0x%lX\n",TOIend);
   			#endif
   			lastnumoffsets=numoffsets;
   			while(TOIptr<TOIend)
   				{
   				#ifdef DEBUG
   				printf("+--@ 0x%lX : ",TOIptr);
   				#endif
   				offsets[numoffsets] =((long)filebuffer[TOIptr++]&255);
   				offsets[numoffsets]|=((long)filebuffer[TOIptr++]&255)<<8;
   				offsets[numoffsets]|=((long)filebuffer[TOIptr++]&255)<<16;
   				offsets[numoffsets]+=base;	// Add base offset ie. start of block including length
   				if(offsets[numoffsets]>length)	// Offset is out of file bounds
   					{
   					#ifdef DEBUG
   					printf("Offset out of file bounds - undoing suspect table\n");
   					#endif
   					numoffsets=lastnumoffsets;	// rollback
   					break;	// continue with next
   					}
   				#ifdef DEBUG
   				printf("0x%lX = %li\n",offsets[numoffsets],offsets[numoffsets]);
   				#endif
   				numoffsets++;	// Increase offsets count for next new offset
   				TOIptr++;	// Skip code
   				}
   			}
         }
		#ifdef DEBUG
		getch();
		#endif
		}
	}
printf("%i images recognised.\n",numoffsets);
return 0;
}

////////////////////////////////////////////////////////////////////////////
// MAIN ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
int main (int argc, char *argv[])
{
int key;
int imagebyoffset=0;
int clearing=1;
int texton=1;
int saveIBO=0;
int i;

int filenum=0;
int fnlen;
char basefilename[13]="WCNAV",savefilename[13];
FILE *readtest;

//Check for command line parameters
printf("Welcome to Wing Commander Bitmap Navigator v4 (32bit)               23-Aug-1999\n");
printf("Displays most WC1, WC2, Academy, Armada and Privateer graphics.\n\n");
if (argc<2)
	{
	printf("You must supply a filename with extension as an argument.  The save\n");
	printf("filename base (first 5 chars) is optional.\n");
	printf("Syntax : \n");
	printf("         WCNAV <filename.ext> [save filename base]\n");
	exit(1);
	}
strupr(argv[1]);
if(loadfile(argv[1])==-1)	exit(-1);

if(argc>=3)	// Optional filename base is present
	{
	strupr(argv[2]);
	if(strlen(argv[2])<=5)
		strcpy(basefilename,argv[2]);
	else
		printf("Save filename base too long - ignoring.\n\n");
	}
// Copy base
strcpy(savefilename,basefilename);
fnlen=strlen(savefilename);
// Add extension and EOS marker
savefilename[fnlen+3]='.';
savefilename[fnlen+4]='B';
savefilename[fnlen+5]='M';
savefilename[fnlen+6]='P';
savefilename[fnlen+7]=0;

printf("Keys :          -   [   {   _ - move backward 1/4/8/100 byte(s)\n");
printf("                =   ]   }   + - move forward  1/4/8/100 byte(s)\n");
printf("                        ,   . - move to previous/next detected image\n");
printf("                        Enter - move to end of current graphic\n");
printf("                    Backspace - move to start of buffer\n");
printf("                        Space - toggle screen clearing\n");
printf("                        ?   / - save/recall image position\n");
printf("        1   2   3   4   6   7 - select palette (WC1/WC2/WC3/WC4/ARM/PRIV1)\n");
printf("                            c - cycle image origin (centre)\n");
printf("                            t - toggle file size and position display\n");
printf("                            f - toggle background and frame display\n");
printf("                            s - save BMP file and increase file counter\n");
printf("                       Escape - quit\n");
printf("\nTips :\n");
printf("None really.  I've done all the work so all you have to do is use , and . to\n");
printf("wind though all the available images.  You may occasionally end up with a blank\n");
printf("or scrambled screen.  Saving is 'intelligent' so you can't overwrite existing\n");
printf("file runs even if 'holes' exist.  Direct any comments to me at\n");
printf("<matrix3d@polbox.com>  Have Fun!\n\n");

detect(argv[1]);
if(getoffsets()==-1) exit(-1);
printf("Ready to view...Press any key...");
getch();	// Wait for keypress
printf("Happy hunting!");

// Start graphic mode and set palette
setvideomode();
if(wcflag==WC1)
	palette=wc1palette;
if(wcflag==WC2)
	palette=wc2palette;
if((wcflag==PRIV)||(wcflag==PAK)||(wcflag==SHP))
	palette=pr1palette;
if(wcflag!=UNKNOWN)
 	setpalette(palette);
offset=offsets[imagebyoffset];

do
	{
	if(clearing) clearscreen();
	displayframe(); // Decode graphic to screen
	if(offset<length) currentcolor=15; else currentcolor=0;
	if(texton)
		{
		nprint(317,195,offset);
		nprint(317,0,length);
		}

	vwait();
	movedata(_my_ds(), (unsigned)videobuffer, video, 0, 64000);

	key=0;
	while(!kbhit());
	while(kbhit()) key=getch();  // Wait for key & flush keyboard buffer
	switch(key)
		{
		case 8   : offset=0; break;
		case 13  : offset=skip; break;
		case '1' : setpalette(wc1palette); break;
		case '2' : setpalette(wc2palette); break;
		case '3' : setpalette(wc3palette); break;
		case '4' : setpalette(wc4palette); break;
		case '6' : setpalette(armadapalette); break;
		case '7' : setpalette(pr1palette); break;
		case 'c' : 				if(xcentre==  0&&ycentre==  0) { xcentre=160; ycentre=100;}
							 else if(xcentre==160&&ycentre==100) { xcentre=160; ycentre=  0;}
							 else if(xcentre==160&&ycentre==  0) { xcentre=  0; ycentre=100;}
							 else if(xcentre==0  &&ycentre==100) { xcentre=  0; ycentre=  0;}
							 break;
		case 'f' : frame=1-frame; break;
		case 't' : texton=1-texton; break;
		case 's' :
								do
									{
									// Add file number
									savefilename[fnlen+0]=48+(filenum/100)%10;
									savefilename[fnlen+1]=48+(filenum/10)%10;
									savefilename[fnlen+2]=48+(filenum/1)%10;
									filenum++;
									// Test is file exists
									readtest=fopen(savefilename,"rb");
									if(readtest==NULL)
										break;
									fclose(readtest);
									}
								while(1);
								saveBMP(savefilename); break;
		case ' ' : clearing=1-clearing; break;
		case '=' : offset++; break;
		case '-' : offset--; break;
		case '[' : offset-=4; break;
		case ']' : offset+=4; break;
		case '{' : offset-=8; break;
		case '}' : offset+=8; break;
		case '_' : offset-=100; break;
		case '+' : offset+=100; break;
		case ',' : imagebyoffset--; if(imagebyoffset<0) imagebyoffset=numoffsets-1; offset=offsets[imagebyoffset]; break;
		case '.' : imagebyoffset++; if(imagebyoffset>=numoffsets) imagebyoffset=0; offset=offsets[imagebyoffset]; break;
		case '?' : saveIBO=imagebyoffset; break;
		case '/' : imagebyoffset=saveIBO; offset=offsets[imagebyoffset]; break;
		}
	}
while(key!=27);

unloadfile();
return 0;
}
