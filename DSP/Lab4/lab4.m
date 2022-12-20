%% Initialization
clc
clearvars
close all

%% Loading file
[y, Fs] = audioread("DSP\Lab4\vuvuzela.wav");
Ts = 1 / Fs;

%% Plotting information about the signal
t = Ts * (0:length(y) - 1);
figure(1)
plot(t, y)

[H, f] = freqz(y, 1, Fs);
f = f * Fs / (2 * pi);

figure(2)
plot(f, abs(H));

%% Creating the filter
f_ = 229;
r = 0.98;
[b, a] = notch(f_, r, Fs);
% z1 = exp(1j * f_);
% z2 = exp(-1j * f_);
%p1 = r * exp(1j * f_);
% p2 = r * exp(-1j * f_);

% b0 = (1 - 2 * r * cos(theta) + r^2) / (2 - 2 * cos(theta));
% b = [b0, -2 * b0 * cos(theta), b0];
% a = [1, -2 * r * cos(theta), r^2];

[G, fg] = freqz(b, a);
figure(3)
plot(fg, abs(G))
figure(4)
zplane(b, a)

%% Filter
y_ = filter(b, a, y);
[Y_, f_h] = freqz(y_, 1, Fs);

figure(5)
subplot(2, 1, 1)
plot(f, abs(H));
subplot(2, 1, 2)
plot(f_h, abs(Y_))

%% Other filters
f0 = 235;
[b0, a0] = notch(f0, r, Fs);
f1 = 465;
[b1, a1] = notch(f1, r, Fs);
f2 = 694;
[b2, a2] = notch(f2, r, Fs);
f3 = 932;
[b3, a3] = notch(f3, r, Fs);
yf = filter(b3, a3, filter(b2, a2, filter(b1, a1, filter(b0, a0, y))));


%% Utilities
function [b, a] = notch(f, r, Fs)
    theta = 2 * pi * f / Fs;
    b0 = (1 - 2 * r * cos(theta) + r^2) / (2 - 2 * cos(theta));
    b = [b0, -2 * b0 * cos(theta), b0];
    a = [1, -2 * r * cos(theta), r^2];
end
