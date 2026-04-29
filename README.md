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

For example, file a1.txt, its corresponding class label is letter “A”, it has 1618 point. The data in this file can be read in a matrix of 1618 rows and 3 columns corresponding to the (X,Y,Z) coordinates. A simplified matrix representation showing the first two rows and the last two rows is represented in Table 1.

Rows	Column 1 = X coordinate	Column 2 = Y coordinate 	Column 3 = Z coordinate

Row 1	0.123009	              0.920465	                0.124559

Row 2	0.121412	              0.944210	                0.079560

    …	   …	                  …	                         …
    
    …	   …	                  …	                         …
    
Row 1617	-0.723007	          -0.196166	                -0.112065

Row 1618	-0.739257	          -0.290998	                -0.004261


Table 1. Matrix representation of the data in file a1.txt which has 1618 points.  



## Data Statistics

In the dataset, each sample (file) is composed of a set of 3D points whose cardinality is variable due to the acquisition conditions with depth sensors.

The statistical analysis of the dataset shows that the number of 3D points for each sample (file) varies as follows:
- Minimum: 1291 3D points
- Average: 3232 (rounded value) 3D points
- Maximum: 7341 3D points
- Standard deviation: 1077 (rounded value)

## Example code in three languages (MATLAB, Python, C++) to load data from a point cloud and plot it

A matlab file is provided.

A Phython project is provided.

A C# project is also provided.

## Example code in MATLAB to segment a point cloud using a plane

segmenta_nube_plano_Git_202603.m is the MATLAB code to segment

prism.txt is a synthetic point cloud with 6 vertices that define a 3D prism

## Index file.csv

Machine readable index file (excel file .csv), listing all samples in the dataset with their file name,  class labels,  participant identifiers and point cloud counts


## Recommended processing steps

Point clouds can be normalized before processing.

One standard processing step is to normalize the point cloud to a coordinate systems centered on the cloud centroid.
This normalization makes point coordinates invariant to translation.

if (Xc, Yc, Zc) is the computed centroid as 1/n* Sum (Xi,Yi,Zi), then the new normalized coordinates
can be computed as Xnew = Xold - Xc, Ynew = Yold-Yc, Znew = Zold - Zc.

To normalize in scale for example to fit a point cloud inside a sphere of radious 1. A search can be done of the
point farthest from the centroid as measured with Euclidean distance. If this distance is DistMax, then the coordinates
of a new point cloud that is both centered at the origin and inside a sphere of radius 1, can be computed as follows:
(Xnew2,Ynew2,Znew2) = (Xnew, Ynew, Znew)/DistMax, if DistMax is different from zero. 

This normalization makes all point cloud normalized in scale.

Additional normalization steps can be taken to normalize in 3D rotation. One useful reference for options in 
doing this is: J. Flusser, T Suk, B. Zitova. 2D and 3D Image Analysis by Moments, first ed., Wiley, 2016.

Once the point clouds are normalized one possible route following traditional AI is to develop a method to extract features using "hand crafted" features. 

Finally, the dataset can be randomly partitioned and use the developed method to train and test on cross validations portions of the dataset. The predicted classes on the test set can be compared with the actual classes to compute confussion matrices, and from there obtain classification metrics.

Other possible route is to do data augmentation on the data set to generate more samples, then design and apply an end to end neural network to train directly on the dataset, and afterward test its performance on the test set.

## Example Matlab code normaliza_coord_escala_multiple_20260424

This code read a point cloud and produces a new point cloud that is normalized in translation. The new point cloud is centered around the Cartesian coordinates origin (0,0,0). Also the new point cloud is normalized in scale to fit inside a sphere of radious one.
