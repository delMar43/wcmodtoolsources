import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;

import javax.imageio.*;
import javax.swing.*;

public class WC1ImageViewer extends JComponent implements Viewer
{
    private BufferedImage image;
    private JFrame frame;
    private WC1Reader reader;
    
    public WC1ImageViewer(String filename) throws IOException
    {
        this(new File(filename));
    }
    
    public WC1ImageViewer(File file) throws IOException
    {
        frame = new JFrame("WC1 Image Viewer");
        
        loadImage(file);
        
        frame.getContentPane().add(this);
        frame.pack();
        frame.setLocationRelativeTo(null);
        frame.setDefaultCloseOperation(frame.EXIT_ON_CLOSE);
        
        frame.addKeyListener(new KeyAdapter()
        {
            public void keyPressed(KeyEvent evt)
            {
                if(evt.getKeyCode() == evt.VK_ESCAPE) System.exit(0);
                else nextImage();
                
                repaint();
            }
        });
    }
    
    private void loadImage(File file) throws IOException
    {
        reader = new WC1Reader(file);
        image = reader.nextImage();
    }
    
    public void paint(Graphics g)
    {
        Graphics2D g2d = (Graphics2D)g;
        
        g2d.drawImage(image, 320 - image.getWidth(), 200 - image.getHeight(), image.getWidth()*2, image.getHeight()*2, null);
    }
    
    public Dimension getPreferredSize()
    {
        return new Dimension(640, 400);
    }
    
    private void nextImage()
    {
        if(reader.hasNext()) image = reader.nextImage();
    }
    
    public JFrame getFrame()
    {
        return frame;
    }
    
    public void override(int count)
    {
        reader.override(count);
    }
    
    public static void main(String[] args) throws Exception
    {
        if(args.length < 1)
        {
            System.out.println("Usage: java WC1ImageViewer <file>");
            return;
        }
        
        new WC1ImageViewer(args[0]).getFrame().setVisible(true);
    }
}