/*
 *  OBJ2WCP - Converts OBJ files to WCP Pascal source code which can be compiled into a WCP/SO format mesh
 *  Copyright (C) 2009-2010 by Kevin Caccamo
 *  License terms can be found in readme.txt
 */
import java.util.Scanner;
import java.io.*;
import javax.vecmath.Vector3d;
import javax.vecmath.Vector3f;
import javax.vecmath.Point3d;
import javax.vecmath.Point2d;

public class ModelConverter3 {

	public static float reverseFloatBytes(float myfnum) {
		int fbits = Float.floatToIntBits(myfnum);
		int revrs = Integer.reverseBytes(fbits);
		float revrsdf = Float.intBitsToFloat(revrs);
		return revrsdf;
	}

	public static double reverseDoubleBytes(double mynum) {
		long dbits = Double.doubleToLongBits(mynum);
		long revrs = Long.reverseBytes(dbits);
		double reverseddouble = Double.longBitsToDouble(revrs);
		return reverseddouble;
	}
	
	public static double calcDPlane(Point3d vv, Vector3d fn) {	//unknown1 value is the d-plane of the face.  Thank you, gr1mre4per!
		double dplane = -((fn.x * vv.x) + (fn.y*vv.y) + (fn.z*vv.z));
		return dplane;
	}

	public static void Outiff(String fname, Point3d[] vertices, Vector3d[] vnormals, Vector3d[] fnormals, Point2d[] uvcoordinates, int numverts, int numnorms, int fellen, int[] texref, int[][] fel, boolean[] liteflags) {
		try {
			Vector3f[] tempvec = new Vector3f[fnormals.length];
			System.out.println("Streaming output to " + fname + ".pas.  Please wait...");
			FileOutputStream pasout = new FileOutputStream(fname + ".pas");
			PrintWriter pw = new PrintWriter(pasout, true);
			pw.println("IFF \"" + fname + ".iff\"");
			pw.println("{");
			pw.println("  FORM \"DETA\"");
			pw.println("  {");
			pw.println("    CHUNK \"RANG\"  //LOD Ranges");
			pw.println("    {");
			pw.println("      long 0");
			pw.println("      float 400.0");
			pw.println("      float 800.0");
			pw.println("    }");
			pw.println("    FORM \"MESH\"");
			pw.println("    {");
			pw.println("      FORM \"0000\"  //LOD 0");
			pw.println("      {");
			pw.println("        FORM \"MESH\"");
			pw.println("        {");
			pw.println("          FORM \"0012\"");
			pw.println("          {");
			pw.println("            CHUNK \"NAME\"");
			pw.println("            {");
			pw.println("              cstring \"" + fname + "\"");
			pw.println("            }");
			pw.println("            CHUNK \"VERT\"");
			pw.println("            {");
			for (int i = 0; i < numverts; i++) {		//Writes verts from the OBJ data arrays
				//pw.println("              float " + (float)vertices[i].x);
				pw.format("              float %1$.6f%n", vertices[i].x);
				//pw.println("              float " + (float)vertices[i].y);
				pw.format("              float %1$.6f%n", vertices[i].y);
				//pw.println("              float " + (float)vertices[i].z + "\n");
				pw.format("              float %1$.6f%n%n", vertices[i].z);
			}
			pw.println("            }");
			pw.println("            CHUNK \"VTNM\"");
			pw.println("            {");
			for (int i = 0; i < numnorms; i++) {	//Writes vertex normals from the OBJ data arrays
				//pw.println("              float " + (float)vnormals[i].x);
				pw.format("              float %1$.6f%n", vnormals[i].x);
				//pw.println("              float " + (float)vnormals[i].y);
				pw.format("              float %1$.6f%n", vnormals[i].y);
				//pw.println("              float " + (float)vnormals[i].z + "\n");
				pw.format("              float %1$.6f%n%n", vnormals[i].z);
			}
			for (int i = 0; i < fellen; i++) {	//Writes face normals from the OBJ data arrays
				String strx = String.format("%1$.6f%n", fnormals[i].x);
				String stry = String.format("%1$.6f%n", fnormals[i].y);
				String strz = String.format("%1$.6f%n", fnormals[i].z);
				//pw.println("              float " + (float)fnormals[i].x);
				pw.format("              float %1$.6f%n", fnormals[i].x);
				//pw.println("              float " + (float)fnormals[i].y);
				pw.format("              float %1$.6f%n", fnormals[i].y);
				//pw.println("              float " + (float)fnormals[i].z + "\n");
				pw.format("              float %1$.6f%n%n", fnormals[i].z);
				tempvec[i] = new Vector3f(Float.parseFloat(strx), Float.parseFloat(stry), Float.parseFloat(strz));
			}
			pw.println("            }");
			pw.println("            CHUNK \"FVRT\"");
			pw.println("            {");	//Writes FVRTs from OBJ face info
			for (int i = 0; i < fellen; i++) {
				pw.println("              long " + fel[i][0] + "  //vert");
				pw.println("              long " + fel[i][2] + "  //light_normal");
				//pw.println("              float " + (float)uvcoordinates[fel[i][1]].x + "  //x_texture");		//Array references inside array references! OMG! And a multi-dimensional one at that!
				pw.format("              float %1$.6f  //x_texture%n", uvcoordinates[fel[i][1]].x);
				//pw.println("              float " + (float)uvcoordinates[fel[i][1]].y + "  //y_texture" + "\n");		//Basically this gets the data from the appropriate index of yuveex/y.  fel[i][1] is the index.
				pw.format("              float %1$.6f  //y_texture%n%n", uvcoordinates[fel[i][1]].y);
				pw.println("              long " + fel[i][3] + "  //vert");
				pw.println("              long " + fel[i][5] + "  //light_normal");
				//pw.println("              float " + (float)uvcoordinates[fel[i][4]].x + "  //x_texture");
				pw.format("              float %1$.6f  //x_texture%n", uvcoordinates[fel[i][4]].x);
				//pw.println("              float " + (float)uvcoordinates[fel[i][4]].y + "  //y_texture" + "\n");
				pw.format("              float %1$.6f  //y_texture%n%n", uvcoordinates[fel[i][4]].y);
				pw.println("              long " + fel[i][6] + "  //vert");
				pw.println("              long " + fel[i][8] + "  //light_normal");
				//pw.println("              float " + (float)uvcoordinates[fel[i][7]].x + "  //x_texture");
				pw.format("              float %1$.6f  //x_texture%n", uvcoordinates[fel[i][7]].x);
				//pw.println("              float " + (float)uvcoordinates[fel[i][7]].y + "  //y_texture" + "\n");
				pw.format("              float %1$.6f  //y_texture%n%n", uvcoordinates[fel[i][7]].y);
			}
			pw.println("            }");
			pw.println("            CHUNK \"FACE\"");
			pw.println("            {");
			for (int i = 0; i < fellen; i++) {
				pw.println("              long " + (numnorms+i) + "  //normal_number");
				//pw.format("              float %1$.6f  //length of normal?%n", tempvec[i].length());
				pw.format("              float %1$.6f  //d-plane%n", calcDPlane(vertices[fel[i][0]], fnormals[i]));
				pw.println("              long " + texref[i] + "  //texture");
				pw.println("              long " + (3*i) + "  //fvrt_ref");
				pw.println("              long 3  //sides");
				if (liteflags[i] == true) {
					pw.println("              long 2  //lighting byteflag");
				} else if (liteflags[i] == false) {
					pw.println("              long 0  //lighting byteflag");
				}
				pw.println("              long $7F0096FF  //end" + "\n");
			}
			pw.println("            }");
			pw.println("            CHUNK \"CNTR\"  //Center");
			pw.println("            {");
			pw.println("              long 0");
			pw.println("              long 0");
			pw.println("              long 0");
			pw.println("            }");
			pw.println("            CHUNK \"RADI\"  //Radius");
			pw.println("            {");
			pw.println("              float 10.0");
			pw.println("            }");
			pw.println("          }");
			pw.println("        }");
			pw.println("      }");
			pw.println("    }");
			pw.println("    FORM \"HARD\"  //Hardpoints");		//Hardpoint writing code.  I might modify it to use an external file one day...
			pw.println("    {");
			pw.println("      CHUNK \"HARD\"");
			pw.println("      {");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 4.406   //X left-right");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float -0.715   //Y up-down");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 1.938   //Z back-forth");
			pw.println("        cstring \"gun1\"");
			pw.println("      }");
			pw.println("      CHUNK \"HARD\"");
			pw.println("      {");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float -4.503   //X");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float -0.715   //Y");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 1.938   //Z");
			pw.println("        cstring \"gun2\"");
			pw.println("      }");
			pw.println("      CHUNK \"HARD\"");
			pw.println("      {");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 3.761   //X");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float -0.495   //Y");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 1.992   //Z");
			pw.println("        cstring \"gun3\"");
			pw.println("      }");
			pw.println("      CHUNK \"HARD\"");
			pw.println("      {");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float -3.739   //X");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float -0.495   //Y");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 1.992   //Z");
			pw.println("        cstring \"gun4\"");
			pw.println("      }");
			pw.println("      CHUNK \"HARD\"");
			pw.println("      {");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 0.0   //X");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 0.0");
			pw.println("        float 0.453   //Y");
			pw.println("        float 0.0");
			pw.println("        float 0.0");
			pw.println("        float 1.0");
			pw.println("        float 4.94   //Z");
			pw.println("        cstring \"cockpit\"");
			pw.println("      }");
			pw.println("    }");
			pw.println("    FORM \"COLL\"");
			pw.println("    {");
			pw.println("      CHUNK \"SPHR\"");
			pw.println("      {");
			pw.println("        long 0");
			pw.println("        long 0");
			pw.println("        long 0");
			pw.println("        float 10.0");
			pw.println("      }");
			pw.println("    }");
			pw.println("    CHUNK \"FAR \"");
			pw.println("    {");
			pw.println("      float 0.0");
			pw.println("      float 900000.0");
			pw.println("    }");
			pw.println("  }");
			pw.print("}");
			pw.flush();
			System.out.print("Complete.");
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
		}
	}

	public static void main(String[] args) {		//PRECONDITIONS: The model and material must be in the same folder as the converter, MAT numbers can be no longer than 8 digits, OBJ filename cannot have spaces, All faces must be triangles, All faces must have UV Coordinates.
		
		String modelfilename;		//Filename of the 3D model
		String matlibrary = "nh.mtl";		//Filename of the Material library
		int startingmat;		//22000 because that's the default
		Point3d[] verts = new Point3d[4096];
		Point2d[] uvs = new Point2d[12288];
		Vector3d[] norms = new Vector3d[4096];
		Vector3d[] fnorms = new Vector3d[4096];
		int[] texture = new int[4096];			//Texture numbers (22000, 22001, etc.)
		boolean[] txltflg = new boolean[100];	//Lighting flag for mats.  If false, face is not fully lit.  If true, face is fully lit.
		boolean[] txltflg2 = new boolean[4096];
		boolean txltflg3 = false;				//A sort of "bridge" between the two boolean arrays.
		int[][] faceel = new int[4096][9];		//FVRTs
		String objmat;							//Material names in OBJ
		String[] material = new String[100];		//Material names (Material)
		int[] txrefs = new int[100];
		String[] bitmap = new String[100];		//Bitmap names (texture.bmp)
		boolean modelisok = true;			//Is the model OK?
		Scanner input = new Scanner(System.in);		//Input
		int a = 0;  //Material count
	    int b = 0;	//Vertex count
	    int c = 0;	//UV count
	    int d = 0;	//Normal count
	    int g = 0;  //Face normal count
	    int f = 0;	//Face count
	    int[] fnmnums = new int[4096];				//Face NorMal NUMberS
	    boolean[] fnmsdeleted = new boolean[4096];	//Face NorMalS Deleted
	    
		System.out.println("OBJ2WCP Copyright (C) 2009-2010 by Kevin Caccamo");
		System.out.println("Name of OBJ file to convert? (Without extension)");
		modelfilename = input.next();		//Gets input from user
		while (modelfilename == "") {		//If you're too lazy, the program will force you to enter another filename
			modelfilename = input.next();
		}
		System.out.println("MAT number to start at? e.g. 22000 will make the game read 00022000.mat");
		startingmat = input.nextInt();
		input.close();
	    boolean flg = false; //Flag, exits loop below
	    int matnumber = startingmat;
	    Scanner nscan = new Scanner("Hello");
	    if (modelisok == true) {
		try{
			BufferedReader objbr = new BufferedReader(new FileReader(modelfilename + ".obj"));
	        String objline = "Hello";	//Stores each individual line of the file.  Perhaps to reduce memory footprint I could make it a single String and not an array.
	        while (objline != null && flg == false) {
	        	objline = objbr.readLine();
	        	if (objline.startsWith("mtllib ")) {
	        		System.out.print("Found Material Library: ");
	        		nscan = new Scanner(objline);	//Construct the scanner so it reads objline for tokens.
	        		nscan.next();					//This section of code finds the material library in the file and exits the loop
	        		matlibrary = nscan.next();		//Read the material library filename so we can go through the material library and find all materials
	        		System.out.println(matlibrary);
	        		flg = true;						//Allows the loop to be exited
	        	}
	        }
		} catch (EOFException eof) {
			System.err.println("OBJ file processed successfully.");
		} catch (ArrayIndexOutOfBoundsException aoob) {
			System.err.println("ERROR! Too many vertices/polygons/UVs/normals!!!");
			modelisok = false;
		} catch (FileNotFoundException fnf) {
			System.err.println("OBJ file not found!!!");
			modelisok = false;
		} catch (IOException ioexc) {
			System.err.println("Error: " + ioexc.getMessage());
		}
	} else {
		System.out.println("OBJ2WCP cannot convert this model.");
	}
	if (modelisok == true) {
		try {
	        BufferedReader objbr = new BufferedReader(new FileReader(matlibrary));	//MTL Parsing code.  We do this before going on with the OBJ file to get the materials in the arrays, and to more accurately get the MAT numbers.
	        String mtlline  = "Hello";
	        while (mtlline != null) {
	        	mtlline = objbr.readLine();
	        	if (mtlline.startsWith("newmtl ", mtlline.indexOf('n'))) {
	        		System.out.print("Found material: ");
	        		nscan = new Scanner(mtlline);		//This code reads the material name
	        		nscan.next();
	        		material[a] = nscan.next();
	        		txrefs[a] = startingmat + a;
	        		System.out.println(material[a]);
					a += 1;
	        	}
	        	if (mtlline.startsWith("map_Kd ", mtlline.indexOf('m'))) {		//this code reads bitmaps
	        		System.out.print("Found bitmap: ");
	        		nscan = new Scanner(mtlline);			//Unfortunately, all materials must have a bitmap.  a is not incremented if there is no bitmap
	        		nscan.next();
	        		bitmap[a-1] = nscan.next();
	        		/*if (bitmap[a-1])*/
	        		System.out.println(bitmap[a-1]);		//bitmap array is for output purposes only, to show the user what bitmap goes with what mat number
	        	}
	        	if (mtlline.startsWith("illum 0", mtlline.indexOf('i'))) {
	        		System.out.println("Lighting disabled for this material");
	        		txltflg[a-1] = true;
	        	}
	        }
		} catch (EOFException eof) {
			System.err.println("MTL file processed successfully.");
		} catch (ArrayIndexOutOfBoundsException aoob) {
			System.err.println("ERROR! Too many materials!!!");
			modelisok = false;
		} catch (FileNotFoundException fnf) {
			System.err.println("MTL file not found!!!");
			modelisok = false;
		} catch (IOException ioexc) {
			System.err.println("Error: " + ioexc.getMessage());
		} catch (NullPointerException npe) {
			System.err.println("MTL file processed successfully.");
		}
	} else {
		System.out.println("OBJ2WCP cannot convert this model.");
	}
	if (modelisok == true) {
		try {	//This section of the code reads the rest of the data from the OBJ file
			BufferedReader objbr = new BufferedReader(new FileReader(modelfilename + ".obj"));
			String objline = "Hello";
	        while (objline != null) {
	        	objline = objbr.readLine();
	        	if (objline.startsWith("v ")) {
	        		System.out.print("Found Vertex: ");
	        		System.out.println(objline);
	        		nscan = new Scanner(objline);	//Construct the scanner every time this code finds a vert, uv, normal.
	        		nscan.next();
	        		verts[b] = new Point3d(nscan.nextDouble(), nscan.nextDouble(), nscan.nextDouble());
	        		b += 1;
	        	}
	        	if (objline.startsWith("vt ")) {
	        		System.out.print("Found UV coordinate: ");
	        		System.out.println(objline);
	        		nscan = new Scanner(objline);
	        		nscan.next();
	        		uvs[c] = new Point2d(nscan.nextDouble(), nscan.nextDouble());
	        		c += 1;
	        	}
	        	if (objline.startsWith("vn ")) {
	        		System.out.print("Found Normal: ");
	        		System.out.println(objline);
	        		nscan = new Scanner(objline);
	        		nscan.next();
	        		norms[d] = new Vector3d(nscan.nextDouble(), nscan.nextDouble(), nscan.nextDouble());
	        		d += 1;
	        	}
	        	if (objline.startsWith("usemtl ")) {
	        		System.out.print("Found Material: ");
	        		nscan = new Scanner(objline);
	        		nscan.next();
	        		objmat = nscan.next();
	        		for (int e = 0; e < material.length; e++) {
	        			if (objmat.equals(material[e])) {
	        				matnumber = startingmat + e;
	        				if (txltflg[e] == true) {
	        					txltflg3 = true;
	        				} else if (txltflg[e] == false) {
	        					txltflg3 = false;
	        				}
	        			}
	        		}
	        		System.out.println(objmat);
	        	}
	        	if (objline.startsWith("f ")) {
	        		System.out.print("Found Face: ");
	        		System.out.println(objline);
	        		nscan = new Scanner(objline);
	        		nscan.next();
	        		nscan.useDelimiter("[ /]");
	        		//We have to start from 0 instead of 1
	        		faceel[f][0] = nscan.nextInt() - 1; //v1
	        		faceel[f][1] = nscan.nextInt() - 1; //vt1
	        		faceel[f][2] = nscan.nextInt() - 1; //vn1
	        		faceel[f][3] = nscan.nextInt() - 1; //v2
	        		faceel[f][4] = nscan.nextInt() - 1; //vt2
	        		faceel[f][5] = nscan.nextInt() - 1; //vn2
	        		faceel[f][6] = nscan.nextInt() - 1; //v3
	        		faceel[f][7] = nscan.nextInt() - 1; //vt3
	        		faceel[f][8] = nscan.nextInt() - 1; //vn3
	        		texture[f] = matnumber;
	        		if (txltflg3 == true) {
	        			txltflg2[f] = true;
	        		}
	        		System.out.print("Texture: " + texture[f] + " - ");
	        		if (txltflg2[f] == true) {
	        			System.out.println("Face is fully lit");
	        		} else if (txltflg2[f] == false) {
	        			System.out.println("Face is shaded");
	        		}
	        		f += 1;
	        	}
	        }
		} catch (EOFException eof) {
			System.err.println("OBJ file processed successfully.");
		} catch (ArrayIndexOutOfBoundsException aoob) {
			System.err.println("ERROR! Too many vertices/faces/UVs/normals!!!");
			modelisok = false;
		} catch (FileNotFoundException fnf) {
			System.err.println("OBJ file not found!!!");
			modelisok = false;
		} catch (IOException ioexc) {
			System.err.println("Error: " + ioexc.getMessage());
		} catch (NullPointerException npe) {
			System.err.println("OBJ file processed successfully.");
		} finally {
			nscan.close();
		}
	} else {
		System.out.println("OBJ2WCP cannot convert this model.");
	}
	if(modelisok == true) {
		System.out.println("Recalculating face normals...");
		for (int i = 0; i < f; i++) {	//calculate face normals
			int vert1 = faceel[i][0];
			int vert2 = faceel[i][3];		//the three vertices of the face
			int vert3 = faceel[i][6];
			Vector3d vect1 = new Vector3d((verts[vert2].x - verts[vert1].x), (verts[vert2].y - verts[vert1].y), (verts[vert2].z - verts[vert1].z));	//make vectors out of the relative positions of the other two vertices on the face
			Vector3d vect2 = new Vector3d((verts[vert3].x - verts[vert1].x), (verts[vert3].y - verts[vert1].y), (verts[vert3].z - verts[vert1].z));
			fnorms[i] = new Vector3d(0.0, 0.0, 0.0);
			fnorms[i].cross(vect1, vect2);
			fnorms[i].normalize();
			g += 1;
		}
	} else {
		System.out.println("OBJ2WCP cannot convert this model.");
	}
/*	if(modelisok == true) {
		System.out.println("Cleaning up face normal array...");
		for (int i = 0; i < f; i++) {
			fnmnums[i] = i;
		}
		for (int i = 0; i < f; i++) {	//first number to search
			for (int j = 0; j < f; j++) {	//second number to search
				if (fnorms[i].x == fnorms[j].x && fnorms[i].y == fnorms[j].y && fnorms[i].z == fnorms[j].z) {	//if the second normal is the same as the first normal
					fnmnums[j] = i;		//remove reference to the second one, replace it with a reference to the first one
					fnmsdeleted[j] = true;
					for (int k = 0; k < fnorms.length-j; k++) {	//erase the second normal and move all of the normals back one position
					fnorms[j+k] = fnorms[j+k+1];
						if (fnmsdeleted[k] == false && k >= j) {
							fnmnums[j+k+1] -= 1;
						}
					}
				}
			}
		}
	} else {
		System.out.println("OBJ2WCP cannot convert this model.");
	}*/
		if (modelisok == true) {
			String dgc;
			dgc = "Stats: " + b + " vertices, " + c + " UV coordinates, " + d + " normals, " + g + " face normals, " + a + " materials, " + f + " faces.";
			System.out.println(dgc);
			for (int zi = 0; zi < a; zi++) {
				System.out.println(bitmap[zi] + " -> " + txrefs[zi] + ".mat");
			}
			try {
				PrintWriter fileout = new PrintWriter(modelfilename + "-info.txt");
				fileout.println(dgc);
				for (int zi = 0; zi < a; zi++) {
					String ggggg = bitmap[zi] + " -> " + txrefs[zi] + ".mat";
					fileout.println(ggggg);
				}
				fileout.flush();
			} catch (Exception e) {
				System.err.println("Error: " + e.getMessage());
			}
			System.out.println("Info written to " + modelfilename + "-info.txt");
			Outiff(modelfilename, verts, norms, fnorms, uvs, b, d, f, texture, faceel, txltflg2);
		} else {
			System.out.println("OBJ2WCP cannot convert this model.");
		}
	}
}
