%% Initialization
clc;
clear all;
close all;

%% Load the audio using audioread() function
[xx, fs] = audioread("Lab2\Exercise 1-20221108\SunshineSquare.wav");

%If you want to hear audio file, you can uncomment following lines of code
%Do not forget to keep volume low, because audio contains unpleasent sounds

pause(2);
sound(xx,fs);

%% Plot the spectogram in order to find disturbing sinusoidial noise
spectrogram(xx, fs)

%% Define the frequence to notch, the ones you have found on the spectogram
w1 = 0.2858 * pi;
w2 = 0.5713 * pi;
w3 = 0.8572 * pi;

%% First impulse response
%Do not forget to normalize to obtain DC unit gain
AA1 = -2 * cos(w1);
h1 = [1, AA1, 1];

%% Second impulse response
AA2 = -2 * cos(w2);
h2 = [1, AA2, 1];

%% Third impulse response
AA3 = -2 * cos(w3);
h3 = [1, AA3, 1];

%% Cascade two by two impulse responses using the convolution
hh = conv(conv(h1, h2), h3);

%% Check the frequency of the final filter by using following lines
ww = -pi:pi/100:pi; 
HH = freqz(hh, 1 ,ww);

%% Plot the overall frequency response 
%Magnitude of impulse response
figure(1)
plot(ww, abs(HH));

%Phase of impulse response
figure(2)
plot(ww, angle(HH));

%% Filter audio with the final filter
yy = filter(hh, 1, xx);

%% Plot the spectogram of output
spectrogram(yy, fs)

%% Reproduce original and output-filtered audio
pause(2);
sound(yy,fs);
