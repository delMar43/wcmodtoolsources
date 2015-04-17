import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;

import javax.imageio.*;
import javax.swing.*;

public class WC1FileHandler
{
    private static String filename;
    private static String export;
    private static boolean fullscreen;
    
    private static void usage()
    {
        System.out.println("Usage: java -jar wc1viewer.jar [options...] <filename>");
        System.out.println("3D Viewer for Wing Commander 1 files.");
        System.out.println();
        System.out.println("  -e <folder>   Extract images to specified folder. Does not activate");
        System.out.println("                the viewer.");
        System.out.println("  -f            Run the viewer in full screen mode. (Experimental!)");
        System.out.println("  -?            Prints this message.");
    }
    
    private static boolean parseOptions(String[] args)
    {
        for(int i=0; i<args.length; i++)
        {
            if(args[i].equals("-e"))
            {
                if(args.length > i+1)
                {
                    export = args[i+1];
                    i++;
                }
                else
                {
                    usage();
                    return false;
                }
            }
            else if(args[i].equals("-?"))
            {
                usage();
                return false;
            }
            else if(args[i].equals("-f"))
            {
                fullscreen = true;
            }
            else
            {
                filename = args[i];
            }
        }
        
        if(filename == null)
        {
            usage();
            return false;
        }
        
        return true;
    }
    
    public static void main(String[] args) throws Exception
    {
        GraphicsDevice device = GraphicsEnvironment.getLocalGraphicsEnvironment().getDefaultScreenDevice();
        JFrame frame;
        
        Viewer viewer = null;
        WC1Reader reader;
        int override = 0;
        
        if(!parseOptions(args)) return;
        
        reader = new WC1Reader(filename);
        reader.close();
        
        if(filename.toLowerCase().endsWith("pcship.v04")) override = 1;
        else if(filename.toLowerCase().endsWith("shiptype.v29")) override = 22;
        else if(filename.toLowerCase().endsWith("ship.v21")) override = 17;
        
        if(export != null)
        {
            if(override > 0) WC1ImageExtractor.main(new String[]{filename, export, Integer.toString(override)});
            else WC1ImageExtractor.main(new String[]{filename, export});
        }
        else
        {
            if(override > 0)
            {
                viewer = new WC1ImageViewer(filename);
                viewer.override(override);
            }
            else if(reader.getType() == WC1Reader.SHIP_FILE || reader.getType() == WC1Reader.SHIP_TYPE_FILE)
            {
                viewer = new WC1ShipViewer(filename);
            }
            else if(reader.getType() == WC1Reader.PC_SHIP_FILE)
            {
                viewer = new WC1CockpitViewer(filename);
            }
            else
            {
                viewer = new WC1ImageViewer(filename);
            }
            
            frame = viewer.getFrame();
            
            if(fullscreen)
            {
                frame.dispose();
                frame.setUndecorated(true);
                device.setFullScreenWindow(frame);
                device.setDisplayMode(new DisplayMode(640, 480, 32, 0));
            }
            
            frame.setVisible(true);
        }
    }
}