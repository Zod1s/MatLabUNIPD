%% Initialisation
clc
clear
close all

%% Parameters
load('params.mat')
load('responses.mat')

%% Setting up signal transformations
s = tf('s');
wc = 2 * pi * 20;
d = 1 / sqrt(2);
Ts = 0.001;
Hc = wc^2 * s / (s^2 + 2 * d * wc^2 * s + wc^2);
Hd = c2d(Hc, Ts, 'tustin');
[numHd, denHd] = tfdata(Hd, 'v');

%% 
