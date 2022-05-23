%% Initialization
close all
clc
clearvars

%% Main program

% Constants
A = 3;
T0 = 0.1;
Tc = 0.001;
t =-4:Tc:4 - Tc;

% Signal
x = A * rect(t / T0);
x(find(x == A, 1, 'first')) = 0.5 * A;
x(find(x == A, 1, 'last')) = 0.5 * A;
figure(1)
plot(t, x, '-*')

% Fourier Transforms
N = length(x);
fc = 1 / Tc;
fs = fc / N;
f = fs * (0:N - 1);
X = fftshift(Tc * fft(x, N) .* exp(-1j * 2 * pi * f * t(1)));

f = fs * (-N/2:N/2 - 1);
Xsym = A * T0 * sinc(f * T0);

Xsym_r = A * T0 * sinc(f * T0);
for i = 1:100
    Xsym_r = Xsym_r + A * T0 * sinc((f - i * fc) * T0) + A * T0 * sinc((f + i * fc) * T0);
end

figure(2)
hold on
plot(f, abs(X), '.r')
plot(f, abs(Xsym), '-b')
plot(f, abs(Xsym_r), ':g')

% Fourier Antitransforms
xifft = ifft(ifftshift(X) .* exp(1j * 2 * pi * f * t(1))) * fc;
xifftsym = ifft(ifftshift(Xsym) .* exp(1j * 2 * pi * f * t(1))) * fc;
xifftsym_r = ifft(ifftshift(Xsym_r) .* exp(1j * 2 * pi * f * t(1))) * fc;

figure(3)
hold on
plot(t, real(xifft), '.r')
plot(t, real(xifftsym), '-b')
plot(t, abs(xifftsym_r), 'vk')


%% Utility functions
rect = @(t) abs(t) <= 0.5;

function s = sinc(t)
    s = sin(pi * t) ./ (pi * t);
    s(t == 0) = 1;
end