%% Decoding a Universal Product Code (UPC)
clc;
clear all; 
close all; 

%% Read the image
I = imread("./upca5.gif");
figure, imagesc(I);

%% Select specific row of the figure
l = size(I);
row = floor(l(1) / 2);

%% Make 1D signal 
x = I(row, :);

%% Plot 1D signal
figure, plot(x);

%% Specify filter coefficients and filter using conv
%  1 * y(n) = 1 * x(n) - 1 * x(n - 1)
%  First difference filter 
h = [1 -1];
y = conv(x, h, 'valid');
figure, plot(y);

%% Threshold Operator
threshold = 10; % Found observing the data

%% Create sparse detected signal d by comparing magnitude of the y with
%  threshold
d = double(abs(y) > threshold);

%% Plot the sparse signal
figure, plot(d);

%% Convert to Locations
l = find(d > 0);

%% Apply a first-difference filter to the location signal
delta_n = conv(l, h, 'valid');

%% Plot l signal and delta_n
figure, stem(l);
figure, stem(delta_n);

%% Estimate the pixel width of the thinnest bar
w_b = min(delta_n);

%% Normalize Delta_n by the estimated w_b
delta_n_n = delta_n ./ w_b;

%% Round the obtained values
delta_n_n_r = round(delta_n_n);
figure, stem(delta_n_n_r);

%% Decode to digits  
digits = decodeUPC(delta_n_n_r);

%% Display obtained results
digits
