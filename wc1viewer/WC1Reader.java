import java.awt.*;
import java.awt.image.*;
import java.io.*;
import java.util.*;

public class WC1Reader implements Iterator
{
    public static final int SHIP_FILE = 0x9C;       //Capital Ships
    public static final int PC_SHIP_FILE = 0x2C;    //Cockpits
    public static final int SHIP_TYPE_FILE = 0x10;  //Fighters
    
    private static final int MAX_X = 320;
    private static final int MAX_Y = 200;
    private static final int PALETTE_SIZE = 256;
    
    private RandomAccessFile file;
    
    private int imageCount;
    private int current;
    
    private int minx;
    private int miny;
    private int maxx;
    private int maxy;
    
    private int type;
    
    private boolean flag;
        
    private long start;
    private long offset;
    
    private int[] buff = {0,0,0,0};
    
    private int[] palette_red = new int[PALETTE_SIZE];
    private int[] palette_green = new int[PALETTE_SIZE];
    private int[] palette_blue = new int[PALETTE_SIZE];
    private int[] palette_rgb = new int[PALETTE_SIZE];
    
    
    public WC1Reader(String filename) throws IOException
    {
        this(new File(filename));
    }
    
    public WC1Reader(File file) throws IOException
    {
        this(new RandomAccessFile(file, "r"));
    }
    
    public WC1Reader(RandomAccessFile file) throws IOException
    {
        this.file = file;
        
        palette("wc1.pal");
        
        file.seek(4);
        
        buff[0] = file.read();
        
        if (buff[0] != 0x10)
        {
            file.seek(4);
            flag = false;
        }
        else
        {
            file.seek(20);
            flag = true;
        }
        
        type = buff[0];
        
        if(buff[0] == SHIP_FILE) imageCount = 37;
        else if(buff[0] == PC_SHIP_FILE) imageCount = 4;
        else if(buff[0] == SHIP_TYPE_FILE) imageCount = 37;
        else System.out.println("Warning! Unknwon file type 0x"+Integer.toHexString(buff[0]).toUpperCase());
    }
    
    private void putPixel(BufferedImage image, int x, int y, int color)
    {
        //It's the oddest thing. The images appear to be 1 base!
        x--;
        y--;
        
        if(x < 0 || y < 0 || x >= image.getWidth() || y >= image.getHeight())
        {
            System.out.println("Warning! Coordinates "+x+", "+y+" out of range!");
            return;
        }
        
        if(x < minx) minx = x;
        if(x > maxx) maxx = x;
        if(y < miny) miny = y;
        if(y > maxy) maxy = y;
        
        image.setRGB(x, y, palette_rgb[color]);
    }
    
    /**
     * Loads a signed short.
     */
    private short readShort() throws IOException
    {
        short value = (short)file.read();
        
        value |= (file.read() << 8);
        
        return value;
    }
    
    /**
     * Converts a list of 3 bytes into a little endian long.
     */
    private long convert(int[] bytes)
    {
        long value = 0;
        value <<= 8;
        value |= bytes[2];
        value <<= 8;
        value |= bytes[1];
        value <<= 8;
        value |= bytes[0];
        
        return value;
    }
    
    /**
     * Scales the 6 bit VGA value to an 8 bit color value.
     */
    private int scaleVGAValue(int value)
    {
        return (value * 256 / 64);
    }
    
    /**
     * Loads the paleltte from the classpath.
     */
    private void palette(String palette) throws IOException
    {
        InputStream in = getClass().getResourceAsStream("/"+palette);
        
        for(int i=0; i<PALETTE_SIZE; i++)
        {
            palette_red[i] = scaleVGAValue(in.read());
            palette_green[i] = scaleVGAValue(in.read());
            palette_blue[i] = scaleVGAValue(in.read());
            palette_rgb[i] = 0xFF000000 | (palette_red[i] << 16) | (palette_green[i] << 8) | palette_blue[i];
        }
        
        in.close();
    }
    
    /**
     * Decodes an image.
     */
    private BufferedImage decode(long header) throws IOException
    {
        int x;
        int y;
        
        int x1;
        int x2;
        int y1;
        int y2;
        
        int vx;
        int vy;
        
        int b;
        int key;
        int carry;
        int color = 0;
        int buffer;
        
        BufferedImage image = new BufferedImage(MAX_X, MAX_Y, BufferedImage.TYPE_INT_ARGB);
        
        // Let's get the dimensions of the image...
        file.seek(header);
        x2 = readShort();
        x1 = readShort();
        y1 = readShort();
        y2 = readShort();

        //Cycle will put image on screen...
        while(true) 
        {
            key = readShort();
            carry = key%2;

            //Warning! These two MUST be loaded as signed shorts, 
            //or you will get incorrect results!
            vx = readShort();
            vy = readShort();

            // If we reached the end of image, lets end the routine
            if(key == 0) return image;   
            
            // Let's not forget that 0 is also a position
            x = x1 + 1;     
            y = y1 + 1;
            x += vx;
            y += vy;
            
            if(carry == 0)
            {
                for(int a=0; a<key/2; a++)
                {
                    color = file.read();
                    
                    putPixel(image, x, y, color);
                    
                    x++;
                }
            }
            else
            {
                b = 0;
                
                while(b < key/2)
                {
                    buffer = file.read();
                    
                    if(buffer%2 != 0) color = file.read();
                    
                    for(int i=0; i<buffer/2; i++)
                    {
                        if(buffer%2 == 0) color = file.read();

                        putPixel(image, x, y, color);
                        
                        b++;
                        x++;
                    }
                }
            }
        }
    }
    
    public boolean hasNext()
    {
        return (current < imageCount);
    }
    
    public BufferedImage nextImage()
    {
        return (BufferedImage)next();
    }
    
    public Object next()
    {
        BufferedImage image;
        
        if(!hasNext()) return null;
        
        minx = MAX_X;
        miny = MAX_Y;
        maxx = 0;
        maxy = 0;
        
        try
        {
            for (int i=0; i<3; i++) buff[i] = file.read();
                    
            offset = file.getFilePointer() + 1;
            
            if(!flag) start = convert(buff)+8;
            else start = convert(buff)+16;

            image = decode(start);
            current++;
        
            file.seek(offset);
        }
        catch(IOException e)
        {
            e.printStackTrace();
            return null;
        }

        return image.getSubimage(minx, miny, maxx-minx, maxy-miny);
    }
    
    public void remove()
    {
        //ignored
    }
    
    public int getCount()
    {
        return imageCount;
    }
    
    public int getType()
    {
        return type;
    }
    
    public void close() throws IOException
    {
        file.close();
    }
    
    void override(int count)
    {
        this.imageCount = count;
    }
}