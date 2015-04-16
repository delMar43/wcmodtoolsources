// This program should read (in theory, of course) all WC1 ships.


#include <stdio.h>
#include <conio.h>
#include <stdlib.h>

#define palsize 768
#define MAXX 320
#define MAXY 200

char pal[palsize];
FILE *f;


void putpix(int x,int y,int col)

{

asm push ax       //My put pixel routine.
asm push bx       //Takes x,y, and the color
asm push cx
asm push dx
unsigned int temp;
temp=y*320+x;
asm mov ax,0xa000
asm mov es,ax
asm mov di,[temp]
asm mov cx,1
asm mov ax,[col]
asm stosb
asm pop dx
asm pop cx
asm pop bx
asm pop ax
}




void ship (char file[],long header)
{
int x1,x2,y1,y2,key,vx,vy,x,y,a,b,i,carry,bytes=0,color,counter=0;
char buffer,buffer2;
fseek (f, header, SEEK_SET);
fread (&x2,2,1,f);
fread (&x1,2,1,f);
fread (&y1,2,1,f);
fread (&y2,2,1,f); // Let's get the dimensions of the image...

while (1) //Cycle will put image on screen...
 {
 fread (&key,2,1,f);
 carry=key%2;
 fread (&vx,2,1,f);
 fread (&vy,2,1,f);
 if (key==0) break;   // If we reached the end of image, lets end the routine
 x=x1+1;     // Let's not forget that 0 is also a position
 y=y1+1;
 x+=vx;
 y+=vy;
 a=0;
 ++counter;  //Increment our little counter (debugging feature)

 if (carry==0)
  {
  for (a=0;a<key/2;++a)
   {
   buffer=fgetc(f);
   putpix (x,y,buffer);
   ++x;
   }
  }
 else
  {
  b=0;

  while (b<key/2)
  {
  buffer=fgetc(f);

  if (buffer%2==0)
   {

      for (a=0;a<buffer/2;++a)
      {
      buffer2=fgetc(f);
      putpix (x,y,buffer2);
      ++b;
      ++x;
      }


   }
  else
   {
   buffer2=fgetc(f);
   for (i=0;i<buffer/2;++i)
    {
    putpix(x,y,buffer2);
    ++b;
    ++x;
    }
   }


  }


  }

 }

}

void pallete (char *file)
{
FILE *f;
int i;
char pallete[palsize];
f=fopen(file,"rb");
fread (pal,palsize,1,f);
fclose(f);
outp(0x3C8,0);         //begin with colour 0
for(i=0;i<256*3;i++)
 outp(0x3C9,pal[i]);    //send the palette-data to port 3c9h


}

void graph_320_by_200(void)
{
asm mov ax,0x0013
asm int 0x10
}

void text(void)
{
asm mov ax,0x0003
asm int 0x10
}

void main (int argc, char **argv)
{
int i,n,flag;
long start;
long offset;
char buff[4]={0,0,0,0};
if (argc<2)
{
printf ("ERROR: Not enough parameters...\n");
printf ("You must supply a ship file as a parameter...\n\n");
exit(1);

}

graph_320_by_200(); // No need for more...
pallete("wc1.pal"); // Load the wc1 pallete...


if ((f=fopen (argv[1],"rb"))==NULL)
{
 text();
 printf ("ERROR: Couldn't open file\n\n");
 exit(1);

}
fseek (f,4,SEEK_SET);
buff[0]=fgetc(f);
if (buff[0]!=0x10)
{
  fseek (f,4,SEEK_SET);
  flag=0;
}
if (buff[0]==0x10)
{
  fseek (f,20,SEEK_SET);
  flag=1;
}

for (n=0;n<37;++n)
 {
 for (i=0;i<3;++i) buff[i]=fgetc (f);
 offset=(ftell(f))+1;
 if (flag==0)start=(*(long*)buff)+8;
 if (flag==1)start=(*(long*)buff)+16;
 ship(argv[1],start); // Lets put the ship on screen...
 getch();
 graph_320_by_200(); //Let's init the graphic mode again...
 pallete ("wc1.pal"); // ... and the pallete, so we have a quick cls.
 fseek (f,offset,SEEK_SET);
 }


pallete("mcga.pal"); //Restore the original pallete
text(); //back to text mode...
}