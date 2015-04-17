import java.awt.image.*;
import java.io.*;

import javax.imageio.*;

public class WC1ImageExtractor
{
    public static void main(String[] args) throws Exception
    {
        WC1Reader reader;
        BufferedImage image;
        
        File folder;
        File file;
        
        int index = 1;
        
        if(args.length < 2)
        {
            System.out.println("Usage: java WC1ImageExtractor <filename> <output folder>");
            return;
        }
        
        reader = new WC1Reader(args[0]);
        folder = new File(args[1]);
        
        folder.mkdirs();
        
        if(args.length > 2) reader.override(Integer.parseInt(args[2]));
        
        while(reader.hasNext())
        {
            image = reader.nextImage();
            
            if(index < 10) file = new File(folder, "image00"+index+".png");
            else if(index < 100) file = new File(folder, "image0"+index+".png");
            else file = new File(folder, "image"+index+".png");
            
            if(!ImageIO.write(image, "PNG", file)) System.out.println("Could not write "+file+" due to unsupported format error.");
            
            index++;
        }
    }
}