%% Initialization
clearvars
close all
clc

load audio.mat

N = length(x_t);
fc = F / N;
Tc = 1 / F;
t = Tc * (0:N - 1);

%% Main
X = fftshift(Tc * fft(x_t));
f = fc * (-N/2:N/2 - 1);

Fm = 40000;
B = 30000;

figure(1)
plot(t, x_t)
figure(2)
plot(f, abs(X))

% Demodulation

fdm = fc * (-N:N - 1);
Xm = fftshift(Tc * fft(x_t, 2 * N));
Hdm = rect(fdm / (2 * B));
Xdm = Hdm .* Xm;
figure(3)
plot(fdm, abs(Xdm))

%% Utilities

rect = @(t) 1 * (abs(t) < 0.5) + 0.5 * (abs(t) == 0.5);
