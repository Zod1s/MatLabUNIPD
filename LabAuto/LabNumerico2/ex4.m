%% Initialisation
clear all
close all
clc

%% Parameters
T = 1 / (2 * pi * 50);
wc = 2 * pi * 50;
d = 1 / sqrt(2);
Ts = 0.001;

s = tf('s');
z = tf('z', Ts);

%% Transfer functions
H = s;
H1 = s / (T * s + 1);
H2 = wc^2 * s / (s^2 + 2 * d * wc * s + wc^2);

%% Discretisation of ideal
Hfe = (z - 1) / Ts;
Hbe = (1 - z^-1) / Ts;
Hts = c2d(H, Ts, "tustin");

figure(1)
grid on
hold on
bode(H)
bode(Hfe)
bode(Hbe)
bode(Hts)
legend("ideal", "forward", "backward", "tustin")

% Hts approximates best the phase
% Both Hbe and Hfe are physically implementable

%% Discretisation of H1
Hfe1 = ((z - 1) / Ts) / (T * (z - 1) / Ts + 1);
Hbe1 = ((1 - z^-1) / Ts) / (T * (1 - z^-1) / Ts + 1);
Hts1 = c2d(H1, Ts, "tustin");

figure(2)
grid on
hold on
bode(H1)
% bode(Hfe1)
% bode(Hbe1)
% bode(Hts1)
% legend("first order", "forward", "backward", "tustin")

% Hts approximates best the phase
% Both Hbe and Hfe approximate best the magnitude

%% Discretisation of H2
s2 = (z - 1) / Ts;
Hfe2 = wc^2 * s2 / (s2^2 + 2 * d * wc * s2 + wc^2);
s2 = (1 - z^-1) / Ts;
Hbe2 = wc^2 * s2 / (s2^2 + 2 * d * wc * s2 + wc^2);
Hts2 = c2d(H2, Ts, "tustin");

figure(2)
grid on
hold on
bode(H2)
bode(Hfe2)
bode(Hbe2)
bode(Hts2)
legend("second order", "forward", "backward", "tustin")

% Hts approximates best the phase
% Both Hbe and Hfe approximate best the magnitude

%% Generalised H3
N = 4;
H3 = (1 - z^-N) / (N * Ts);

figure(4)
grid on
hold on
bode(Hbe)
bode(H3)
legend("ideal discrete", "general")

% H3 has a zero at high frequency, it attenuates more than Hbe

%% Approximating H
H4 = 1 / (6 * Ts) * (1 + 3 * z^-1 - 3 * z^-2 - z^-3);

figure(5)
hold on
bode(H4)
bode(H)
legend("H4", "ideal")

% Magnitude is similar for low frequencies, whereas the phase is different
% H4 is physically implementable

%% Simulating an input
k = 0:1:2000;
r = 25 * k * Ts;
n = 0.002 * (rand(1, 2001) - 0.5);
u = r + n;

figure(6)
grid on
hold on
plot(k * Ts, u)
































