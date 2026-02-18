% Read 3D Mexican Sign Language Static Alphabet Dataset
% This script reads a text file containing 3D point coordinates
% and plots them in 3D space

% Clear workspace and command window
clear all;
close all;
clc;

% Specify the base path to the dataset
% NOTE: Change this path depending on where the dataset is stored on your computer
% In this example, the dataset is stored in the Downloads directory
path = 'C:\Users\vladi\Downloads\3D MSL Static Alphabet';

% Specify the file to read
% Example: reading file 'a1.txt' from folder 'A'
folder = 'A';  % Change this to the desired letter folder
file_number = 1;  % Change this to the desired file number (1-15)
file_name = fullfile(path, folder, sprintf('%s%d.txt', lower(folder), file_number));

% Read the 3D coordinates from the text file
try
    coordinates = readmatrix(file_name);
catch
    error(sprintf('Error: Could not open file %s. Please check the file path and name.', file_name));
end

% Display information about the loaded data
[num_points, num_columns] = size(coordinates);
fprintf('File: %s\n', file_name);
fprintf('Number of 3D points: %d\n', num_points);
fprintf('Number of columns: %d\n', num_columns);

% Verify that we have exactly 3 columns (X, Y, Z coordinates)
if num_columns ~= 3
    error('Error: The file does not contain 3 columns (X, Y, Z coordinates).');
end

% Extract X, Y, Z coordinates
X = coordinates(:, 1);
Y = coordinates(:, 2);
Z = coordinates(:, 3);

% Create a 3D scatter plot
% Please note that in the scatter3 function, the Y and Z axis have been interchanged,
% because in the MS Kinect V1 sensor the Y axis points up, and the Z axis points forward
figure('Name', sprintf('3D MSL Alphabet - Letter %s (Sample %d)', upper(folder), file_number));
scatter3(X, Z, Y, 20, 'filled', 'b');
hold on;
grid on;
xlabel('X (meters)');
ylabel('Z (meters)');
zlabel('Y (meters)');
title(sprintf('3D Points of Letter %s - Sample %d', upper(folder), file_number));
axis equal;
rotate3d on;

% Display statistics
fprintf('\nCoordinate Statistics:\n');
fprintf('X - Min: %.4f, Max: %.4f, Mean: %.4f\n', min(X), max(X), mean(X));
fprintf('Y - Min: %.4f, Max: %.4f, Mean: %.4f\n', min(Y), max(Y), mean(Y));
fprintf('Z - Min: %.4f, Max: %.4f, Mean: %.4f\n', min(Z), max(Z), mean(Z));