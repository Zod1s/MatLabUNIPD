%% Initialisation
clear
close all
clc

%% Parameters
rads2rpm = 60 / (2 * pi); %[rpm * s/rad]
rpm2rads = 2 * pi / 60; %[rad/(s * rpm)]
KpP = 0.7170 / 4;
KpPI = 0.2255 / 4;
Ts = 0.001;
mot.k = 5.2;
mot.T = 0.03;
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);


