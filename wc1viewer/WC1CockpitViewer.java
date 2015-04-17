import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;

import javax.imageio.*;
import javax.swing.*;

public class WC1CockpitViewer extends JComponent implements Viewer
{
    private BufferedImage[] images;
    private JFrame frame;
    private int image = 0;
    private int rot = 0;
    private int[] order = {0, 1, 3, 2};
    
    public WC1CockpitViewer(String filename) throws IOException
    {
        this(new File(filename));
    }
    
    public WC1CockpitViewer(File file) throws IOException
    {
        frame = new JFrame("WC1 VR Cockpit Viewer");
        
        loadImages(file);
        
        frame.getContentPane().add(this);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(frame.EXIT_ON_CLOSE);
        
        frame.addKeyListener(new KeyAdapter()
        {
            public void keyPressed(KeyEvent evt)
            {
                if(evt.getKeyCode() == evt.VK_ESCAPE) System.exit(0);
                if(evt.getKeyCode() == evt.VK_LEFT) turnClockwise();
                if(evt.getKeyCode() == evt.VK_RIGHT) turnCounterClockwise();
                
                repaint();
            }
        });
    }
    
    private void loadImages(File file) throws IOException
    {
        WC1Reader reader = new WC1Reader(file);
        
        images = new BufferedImage[4];
        
        for(int i=0; i<4; i++)
        {
            images[i] = reader.nextImage();
        }
    }
    
    public void paint(Graphics g)
    {
        Graphics2D g2d = (Graphics2D)g;
        BufferedImage bufferedImage = images[image];
        
        g2d.drawImage(bufferedImage, 320 - bufferedImage.getWidth(), 200 - bufferedImage.getHeight(), bufferedImage.getWidth()*2, bufferedImage.getHeight()*2, null);
    }
    
    public Dimension getPreferredSize()
    {
        return new Dimension(640, 400);
    }
    
    private void turnCounterClockwise()
    {
        rot = (rot + 1) % order.length;
        
        image = order[rot];
    }
    
    private void turnClockwise()
    {
        rot--;
        
        if(rot < 0) rot += order.length;
        
        image = order[rot];
    }
    
    public JFrame getFrame()
    {
        return frame;
    }
    
    public void override(int count)
    {
        //Currently does nothing
    }
    
    public static void main(String[] args) throws Exception
    {
        if(args.length < 1)
        {
            System.out.println("Usage: java WC1CockpitViewer <pcship file>");
            return;
        }
        
        new WC1CockpitViewer(args[0]).getFrame().setVisible(true);
    }
}