clc;
clear all;
close all;

%% Load the image 'eleph2.jpg'
I = imread("./DSP/Exercise 1-20221020/eleph2.jpg");

%% Plot the original image
figure, imagesc(I);
title("Original Image");

%% Convert from RGB to gray scale and the to double
Ig = rgb2gray(I);
Id = double(Ig);

%% Plot the Black and White image
figure, imagesc(Id);
colormap(gray);
title("Original Image B&W");

%% Define the window dimension, first try with window size 3x3, after change
%  window size and see what will happen if we increase sliding window
N = 7;
l = size(Id);

%% Define the matrix containg the result, creating matrix of zeros of
%  original image size
mean = zeros(l);
qmean = zeros(l);
locvar = zeros(l);

%% Zero padding
padded = zeros(l + [2 2]);
padded(2:l(1) + 1, 2:l(2) + 1) = Id;

%% Compute local variance of the image and save results in matrix defined to
%  cointain results
for i = 1:l(1) - N + 1
    for j = 1:l(2) - N + 1
        mean(i, j) = sum(padded(i:i + N - 1, j:j + N - 1), "all") / N^2;
        qmean(i, j) = sum(padded(i:i + N - 1, j:j + N - 1).^2, "all") / N^2;
    end
end
locvar = qmean - mean.^2;

%% Plot resulting matrix which cointains local variance
figure, imagesc(locvar);
colormap(gray);
title("Original Image B&W");

%% Define a Threshold
threshold = sum(locvar, "all") / (l(1) * l(2));

%% Set the pixel values based on threshold
locvarthr = locvar < threshold;

%% Plot detected edges
figure, imagesc(locvarthr);
colormap(gray);
title("Original Image B&W");
