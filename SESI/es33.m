%% Initialization
close all
clearvars
clc

%% Main

% Constants
l = 0.9;
k = 5;
m = 0.1;
L = sqrt(l^2 - 4 * k * m);

Tc = 0.01;
t = 0:Tc:5;
Nt = length(t);

% Signals
x = 3 * sin(13 * t);
h = exp(-t * (L + l) / (2 * m)) .* (L * exp(t * L / m) + 1 - l * exp(t * L / m) + l) / (2 * m * L);
figure(1)
plot(t, x)
figure(2)
plot(t, abs(h))

X = fft(x);
H = fft(h);
Y = H .* X;
y = ifft(Y);

yconv = conv(x, h);
yconv = t .* yconv(1:Nt);

ysim = 390 * ((117 * sin(13 * t) - 119 * cos(13 * t)) / 27850 ...
    + exp(-9 * t / 2) .* (119 * sqrt(119) * cos(sqrt(119) * t / 2) ... 
    - 1971 * sin(sqrt(119) * t / 2)) / (27850 * sqrt(119)));

figure(3)
hold on
plot(t, real(y))
plot(t, real(yconv))
plot(t, ysim)