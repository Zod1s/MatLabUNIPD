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

% Signals
x = 3 * sin(13 * t);
h = exp(-t * (L + l) / (2 * m)) .* (L * exp(t * L / m) + 1 - l * exp(t * L / m) + l) / (2 * m * L);
figure(1)
plot(t, x)
figure(2)
plot(t, abs(h))

fc = 1 /Tc;

Nx = length(x);
fsx = fc / Nx;
X = fftshift(fft(x));
fx = fsx * (-Nx/2:Nx/2 - 1);

Nh = length(h);
fsh = fc / Nh;
H = fftshift(fft(h));
fh = fsh * (-Nh/2:Nh/2 - 1);

Y = X .* H;
y = ifft(ifftshift(Y));
yconv = conv(x, h);

figure(3)
plot(t, y)
plot(yconv)