import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;

import javax.imageio.*;
import javax.swing.*;

public class WC1ShipViewer extends JComponent implements Viewer
{
    private BufferedImage[] images;
    private JFrame frame;
    private int image = 15;
    private int rotx;
    private int roty;
    
    private int[] angles = 
            new int[]{90, 60, 30, 0, 330, 300, 270, 240, 210, 180, 150, 120};
    
    private int[][] positions = {
            new int[]{15, 16, 17, 18, 19, 20, 21, -20, -19, -18, -17, -16}, //0
            new int[]{14, 13, 12, 11, 10,  9,  8,  -9, -10, -11, -12, -13}, //1
            new int[]{ 1,  2,  3,  4,  5,  6,  7,  -6,  -5,  -4,  -3,  -2}, //2
            new int[]{ 0,  0,  0,  0,  0,  0,  0,   0,   0,   0,   0,   0}, //3
            new int[]{ 7,  6,  5,  4,  3,  2,  1,  -2,  -3,  -4,  -5,  -6}, //4 --
            new int[]{ 8,  9, 10, 11, 12, 13, 14, -13, -12, -11, -10,  -9}, //5
            new int[]{21, 20, 19, 18, 17, 16, 15, -16, -17, -18, -19, -20}, //6
            new int[]{22, 23, 24, 25, 26, 27, 28, -27, -26, -25, -24, -23}, //7
            new int[]{35, 34, 33, 32, 31, 30, 29, -30, -31, -32, -33, -34}, //8 --
            new int[]{36, 36, 36, 36, 36, 36, 36,  36,  36,  36,  36,  36}, //9
            new int[]{29, 30, 31, 32, 33, 34, 35, -34, -33, -32, -31, -30}, //10
            new int[]{28, 27, 26, 25, 24, 23, 22, -23, -24, -25, -26, -27}, //11
    };
    
    public WC1ShipViewer(String folderName) throws IOException
    {
        this(new File(folderName));
    }
    
    public WC1ShipViewer(File folder) throws IOException
    {
        frame = new JFrame("WC1 3D Ship Viewer");
        
        loadImages(folder);
        
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
                if(evt.getKeyCode() == evt.VK_UP) pitchUp();
                if(evt.getKeyCode() == evt.VK_DOWN) pitchDown();
                
                repaint();
            }
        });
    }
    
    private void loadImages(File file) throws IOException
    {
        WC1Reader reader = new WC1Reader(file);
        
        images = new BufferedImage[37];
        
        for(int i=0; i<37; i++)
        {
            images[i] = reader.nextImage();
        }
    }
    
    public void paint(Graphics g)
    {
        Graphics2D g2d = (Graphics2D)g;
        AffineTransform tx;
        AffineTransformOp op;
        BufferedImage bufferedImage;
        Rectangle2D rect;
        int image = this.image;
        
        if(image < 0 && roty >= 4 && roty <= 8)
        {
            image = -image;
            tx = AffineTransform.getScaleInstance(-1, -1);
            tx.translate(-images[image].getWidth(), -images[image].getHeight());
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            bufferedImage = op.filter(images[image], null);
        }
        else if(roty >= 4 && roty <= 8)
        {
            tx = AffineTransform.getScaleInstance(1, -1);
            tx.translate(0, -images[image].getHeight());
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            bufferedImage = op.filter(images[image], null);
        }
        else if(image < 0)
        {
            image = -image;
            tx = AffineTransform.getScaleInstance(-1, 1);
            tx.translate(-images[image].getWidth(), 0);
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            bufferedImage = op.filter(images[image], null);
        }
        else if(image == 0)
        {
            tx = new AffineTransform();
            tx.rotate(Math.toRadians(angles[rotx]), images[image].getWidth()/2, images[image].getHeight()/2);
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            rect = op.getBounds2D(images[image]);
            tx = new AffineTransform();
            tx.translate(-rect.getX(), -rect.getY());
            tx.rotate(Math.toRadians(angles[rotx]), images[image].getWidth()/2, images[image].getHeight()/2);
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            bufferedImage = op.filter(images[image], null);
        }
        else if(image == 36)
        {
            tx = new AffineTransform();
            tx.rotate(Math.toRadians(360-angles[rotx]), images[image].getWidth()/2, images[image].getHeight()/2);
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_BILINEAR);
            rect = op.getBounds2D(images[image]);
            tx = new AffineTransform();
            tx.translate(-rect.getX(), -rect.getY());
            tx.rotate(Math.toRadians(360-angles[rotx]), images[image].getWidth()/2, images[image].getHeight()/2);
            op = new AffineTransformOp(tx, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
            bufferedImage = op.filter(images[image], null);
        }
        else
        {
            bufferedImage = images[image];
        }
        
        g2d.drawImage(bufferedImage, 320 - bufferedImage.getWidth(), 200 - bufferedImage.getHeight(), bufferedImage.getWidth()*2, bufferedImage.getHeight()*2, null);
    }
    
    public Dimension getPreferredSize()
    {
        return new Dimension(640, 400);
    }
    
    public void turnClockwise()
    {
        rotx = (rotx + 1) % positions[roty].length;
        image = positions[roty][rotx];
    }
    
    public void turnCounterClockwise()
    {
        rotx--;
        if(rotx < 0) rotx += positions[roty].length;
        image = positions[roty][rotx];
    }
    
    public void pitchUp()
    {
        roty--;
        if(roty < 0) roty += positions.length;
        image = positions[roty][rotx];
    }
    
    public void pitchDown()
    {
            roty = (roty + 1) % positions.length;
            image = positions[roty][rotx];
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
            System.out.println("Usage: java WC1ShipViewer <folder>");
            return;
        }
        
        new WC1ShipViewer(args[0]).getFrame().setVisible(true);
    }
}