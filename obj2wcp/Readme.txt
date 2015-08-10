--- OBJ2WCP v1.2 by Kevin Caccamo - Readme file ---

-| License |-

OBJ2WCP is licensed under the following license agreement:
- You may use this program for non-commercial or commercial purposes.
- You may redistribute this program, as long as it is redistributed free of charge.
- You may modify the source code and redistribute your modified versions, as long as they are redistributed free of charge.
- If you are redistributing the program, please provide a link on your website to http://www.ciinet.org/kevin/java/index.html.  If for any reason this is not possible, (e.g. uploading to Mediafire) provide a link to http://www.ciinet.org/kevin/java/index.html on the site where you are linking to your uploaded file on mediafire.

-| Version history |-

OBJ2WCP 1.2 - unknown1 value is now calculated correctly.  Thanks, gr1mre4per!
OBJ2WCP 1.1 - Trying a bunch of different algorithms to calculate unknown1.  Let's see if this one doesn't eliminate the disappearing faces problem altogether.
OBJ2WCP 1.0 - Now uses Java3D API, face normals are now recalculated.

-| How to use |-

OBJ2WCP is a model converter which reads OBJ models and outputs PAS files, which can be compiled into WCP/SO format IFF meshes with WCP Pascal.  To start the model converter, open the command line for your OS, go to the directory of the model converter, and type in:

java ModelConverter3

In Windows, the converter can be started automatically with run.bat.

You will be asked for the name of the OBJ file without it's extension and the MAT number to start at.  For example, you might have an OBJ named Wingnut.obj.  You would type in "Wingnut" when it asks for the name of the OBJ and 22000 or whatever when it asks you for the starting MAT.

You would then use WCP Pascal or the IFF command line compiler to compile the PAS file into an IFF.  Of course, you can still edit the PAS file before you compile it if you wanted to add hardpoints or children to the model.  When you are done editing and compiling, place the IFF into the "mesh" folder in your Secret Ops directory.

If there is anything wrong with the model (too many UVs/faces/verts/normals/materials) then the converter will quit and tell you what the problem is.

-| Requirements |-

- The OBJ mesh must be fully triangulated
- Model and material must be in the same folder
- Starting MAT number can be no longer than 8 digits
- All materials must have textures
- OBJ/MTL filename cannot have spaces
- All vertices must have UV coordinates
- All faces must have a vt reference (All faces must be textured)

The program supports a maximum of 4096 vertices, UVs, normals, and faces, and a maximum of 100 materials.

This experimental version of obj2wcp uses the Point2d, Point3d, and Vector3d classes, which are part of the Java3D API.  If you get an error message about missing classes, then you might not have Java3D installed.  The Java3D API can be downloaded and installed from here: http://java.sun.com/javase/technologies/desktop/java3d/

-| If you encounter problems |-

Describe the problem, then provide screenshots of the problem if necessary.  I will try and seek out the problem in my code.

-| Features |-

- Reads info from v, vt, vn, and f
- Support for multiple materials
- Support for full lighting on materials with "illum 0"
- Apparently it supports smoothing too.
- Gives statistics about the model
- Tells the user what bitmap goes with what MAT number
- Gives understandable error information
- Attempts to calculate face normals (experimental)

-| What it does not do |-

- Negative v/vt/vn references in f lines
- Parameter space vertices/mathematically defined vertices
- Other advanced features of the OBJ format

-| Possible goals for future versions |-

- Use OBJ groups as LODs, components, etc.
- Make poly limit dynamic
- Detect whether two materials are using the same bitmap
- Hardpoints
- Write binary IFF files
- Create a GUI with a 3D preview window