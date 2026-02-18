# 3D Mexican Sign Language Static Alphabet Dataset

The MSL alphabet is composed of 21 static letters and between six to nine dynamic letters depending on the reference.  
The 21 static letters are: A, B, C, D, E, F, G, H, I, L, M, N, O, P, R, S, T, U, V, W, Y.  
Most authors agree on at least six dynamic letters: J, K, Ñ, Q, X, and Z. Other authors add two additional dynamic letters: LL, RR.  
Another author adds a further one: CH.

## Dataset Structure

The main folder where the dataset is stored is named:  
**3D MSL Static Alphabet**

The reference is the following:  
Rios-Figueroa, Homero V.; Sosa-Jiménez, Candy O. (2025),  
“3D Mexican Sign Language Static Alphabet”,  
Mendeley Data, V1, doi: 10.17632/sjt79hnb2f.1

It contains 21 subfolders named:  
A, B, C, D, E, F, G, H, I, L, M, N, O, P, R, S, T, U, V, W, Y,  
corresponding to the static letters in the MSL Alphabet.

Each subfolder has 15 text files (.txt) with the name of the letter followed by a number between 1 and 15.  
For example, for letter A, the files are a1.txt, a2.txt… a15.txt.  
This naming convention is consistent across the dataset.  
A folder named with uppercase, for instance, “A”, is used for the class shape, and the 15 specific instances are named with lowercase.

## File Contents

Each text file has as many lines as the letter has 3D points for its spatial representation.  
Each line is composed of three floating point numbers that provide the coordinates (X, Y, Z) of a 3D point.

The coordinates (X, Y, Z) are in meter units.  
The MS Kinect V.1 sensor coordinate system for depth image acquisition is at the center of the depth camera.  
The coordinate system follows a right-handed convention.  
- The X horizontal axis points to the left (from the perspective of the sensor)
- The Y vertical axis points upward
- The Z depth axis points forward in the direction that the camera is facing

From the 3D data in the text file, it is possible to recover the geometrical and graphical representation.

## Data Statistics

In the dataset, each sample (file) is composed of a set of 3D points whose cardinality is variable due to the acquisition conditions with depth sensors.

The statistical analysis of the dataset shows that the number of 3D points for each sample (file) varies as follows:
- Minimum: 1291 3D points
- Average: 3232 (rounded value) 3D points
- Maximum: 7341 3D points
- Standard deviation: 1077 (rounded value)