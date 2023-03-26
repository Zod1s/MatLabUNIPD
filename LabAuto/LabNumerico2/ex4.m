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
Hts = minreal(c2d(H, Ts, "tustin"));

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
Hfe1 = minreal(((z - 1) / Ts) / (T * (z - 1) / Ts + 1));
Hbe1 = minreal(((1 - z^-1) / Ts) / (T * (1 - z^-1) / Ts + 1));
Hts1 = minreal(c2d(H1, Ts, "tustin"));

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
Hfe2 = minreal(wc^2 * s2 / (s2^2 + 2 * d * wc * s2 + wc^2));
s2 = (1 - z^-1) / Ts;
Hbe2 = minreal(wc^2 * s2 / (s2^2 + 2 * d * wc * s2 + wc^2));
Hts2 = minreal(c2d(H2, Ts, "tustin"));

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
t = k * Ts;
r = 25 * t;
n = 0.002 * (rand(1, 2001) - 0.5);
u = r + n;

[num, den] = tfdata(Hbe, 'v');
u1  = filter(num, den, u);
% [num, den] = tfdata(Hfe, 'v');
% u2  = filter(num, den, u);
[num, den] = tfdata(Hts, 'v');
u3  = filter(num, den, u);
[num, den] = tfdata(Hbe1, 'v');
u4  = filter(num, den, u);
[num, den] = tfdata(Hfe1, 'v');
u5  = filter(num, den, u);
[num, den] = tfdata(Hts1, 'v');
u6  = filter(num, den, u);
[num, den] = tfdata(Hbe2, 'v');
u7  = filter(num, den, u);
[num, den] = tfdata(Hfe2, 'v');
u8  = filter(num, den, u);
[num, den] = tfdata(Hts2, 'v');
u9  = filter(num, den, u);
[num, den] = tfdata(H3, 'v');
u10 = filter(num, den, u);
[num, den] = tfdata(H4, 'v');
u11 = filter(num, den, u);

figure(6)
grid on
hold on
plot(t, u)

figure(7)
grid on
hold on
plot(t, u1)
% plot(t, u2)
plot(t, u3)
plot(t, u4)
plot(t, u5)
plot(t, u6)
plot(t, u7)
plot(t, u8)
plot(t, u9)
plot(t, u10)
plot(t, u11)
legend("Hbe", "Hts", "Hbe1", "Hfe1", "Hts1", "Hbe2", "Hfe2", "Hts2", ...
    "H3", "H4")

%% Computing variance
vars = [var(u1(100:end))
        var(u3(100:end))
        var(u4(100:end))
        var(u5(100:end))
        var(u6(100:end))
        var(u7(100:end))
        var(u8(100:end))
        var(u9(100:end))
        var(u10(100:end))
        var(u11(100:end))];
% var2 = var(u2(100:end));

% The minimum variance is for u7, so Hbe2
