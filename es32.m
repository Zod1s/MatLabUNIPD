%% Initialization
close all
clc
clearvars

%% Main
% Constants
A1 = 3;
A2 = 0.5;
f1 = 0.1;
f2 = 8;

Tc1 = 0.01;
Trect1 = 5;
K1 = 3000;
k1 = (-K1:K1 - 1);
t1 = k1 * Tc1;

Tc2 = 0.05;
Trect2 = 25;
K2 = 6000;
k2 = (-K2:K2 - 1);
t2 = k2 * Tc2;

% Signals
s1 = A1 * A2 * cos(2 * pi * f1 * k1 * Tc1) .* cos(2 * pi * f2 * k1 * Tc1) .* rect(k1 * Tc1/Trect1);
s2 = A1 * A2 * cos(2 * pi * f1 * k2 * Tc2) .* cos(2 * pi * f2 * k2 * Tc2) .* rect(k2 * Tc2/Trect2);

figure(1)
plot(t1, s1)

figure(2)
plot(t2, s2)

% Fourier Transform
fc1 = 1 / Tc1;
N1 = length(s1);
fs1 = fc1 / N1;
f1 = fs1 * (0:N1 - 1);
S1 = fftshift(Tc1 * fft(s1, N1) .* exp(-1j * 2 * pi * f1 * k1(1) * Tc1));
f1 = fs1 * (-N1/2:N1/2 - 1);

fc2 = 1 / Tc2;
N2 = length(s2);
fs2 = fc2 / N2;
f2 = fs2 * (0:N2 - 1);
S2 = fftshift(Tc2 * fft(s2, N2) .* exp(-1j * 2 * pi * f2 * k2(1) * Tc2));
f2 = fs2 * (-N2/2:N2/2 - 1);

figure(3)
plot(f1, abs(S1));

figure(4)
plot(f2, abs(S2));

% Fourier Antitransforms
s1ifft = ifft(ifftshift(S1) .* exp(1j * 2 * pi * f1 * k1(1) * Tc1)) / Tc1;
s2ifft = ifft(ifftshift(S2) .* exp(1j * 2 * pi * f2 * k2(1) * Tc2)) / Tc2;

figure(5)
plot(t1, abs(s1ifft))

figure(6)
plot(t2, abs(s2ifft))

%% Utilities

rect = @(t) abs(t) <= 0.5;
