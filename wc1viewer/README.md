# WC1 Viewer

published by AKAImBatman on Apr 23, 2005 here http://www.wcnews.com/chatzone/threads/wc1-viewer.16524/

Hi all! I'm messing around with a sprite engine a bit, so I ported HCl's WC1 image decoder to Java. It is now fully cross platform, properly detects the number of images, and has a few things cleaned up in the code. It currently only works with WC1's Vxx images (although I did get one or two WC2 images to work). VGA images are unsupported, as the original codebase didn't seem to support them. HCl's document said that it should, so I'll have to look into that at some point.

You can use the code as you like. Feel free to poke it, prod it, rewrite it, port it again, or whatever else you want to do with it. It should be fairly easy to read, and I've left a few comments on stuff that is pertinent to the Java version over the original C version. It's a bit slow at the moment, but that's only because I was a bit lazy about the drawing routines. If someone was so inclined, they could use MemoryImageSource or BufferedImage to make it blaze. (Although it's a utility, so why bother?)

Hope someone finds this useful! Special thanks to HCl and company for the original file format decoding! :)