%% Initialisation
close all
clear all
clc

%% Parameters
rads2rpm = 60 / (2 * pi);
rpm2rads = 2 * pi / 60;
s = tf('s');
km = 5.2;
Tm = 0.03;

%% Transfer functions
P1 = km / (Tm * s + 1);
integ = 1 / s;
P = P1 * integ;

%% Derivative filter
wc = 2 * pi * 50;
d = 1 / sqrt(2);
H2 = wc^2 * s / (s^2 + 2 * d * wc * s + wc^2);

%% Open-Chain system
G = P * H2;
kc = margin(G);

figure(1)
rlocus(G)

% The critical gain is 2.98

%% Response to step input with P controller
Kp = kc / 4;
t = 0:0.001:0.3;
w1 = stepDataOptions("InputOffset", 0, "StepAmplitude", 300 * rpm2rads);

% Let Wu be the system response with u as output
Wu = feedback(Kp, P * H2);
Wu = minreal(Wu);
u = step(Wu, t, w1);
% Let Ww be the system response with w as output
Ww = feedback(Kp * P1, integ * H2);
Ww = minreal(Ww);
w = step(Ww, t, w1);
% Let Wm be the system response with wm as output
Wm = feedback(Kp * P * H2, 1);
Wm = minreal(Wm);
wm = step(Wm, t, w1);

figure(2)
hold on
grid on
plot(t, 300 * ones(1, length(t)))
plot(t, u)
plot(t, w * rads2rpm)
plot(t, wm * rads2rpm)
legend("input", "control signal", "actual speed", "measured speed")

%% Getting step response infos of Ww system
infos = stepinfo(Ww, "SettlingTimeThreshold", 0.05);

%% Switch to PI controller
Pi = (s + 100) / s;

%% Root locus
G1 = Pi * P * H2;
kc1 = margin(G1);

figure(3)
rlocus(G1)

%% Response to step input with PI controller
PI = Pi * kc1 / 4;
t = 0:0.001:0.3;

% Let Wu be the system response with u as output
Wui = feedback(PI, P * H2);
Wui = minreal(Wui);
ui = step(Wui, t, w1);
% Let Ww be the system response with w as output
Wwi = feedback(PI * P1, integ * H2);
Wwi = minreal(Wwi);
wi = step(Wwi, t, w1);
% Let Wm be the system response with wm as output
Wmi = feedback(PI * P * H2, 1);
Wmi = minreal(Wmi);
wmi = step(Wmi, t, w1);

figure(4)
hold on
grid on
plot(t, 300 * ones(1, length(t)))
plot(t, ui)
plot(t, wi * rads2rpm)
plot(t, wmi * rads2rpm)
legend("input", "control signal", "actual speed", "measured speed")

%% Getting step response infos of Ww system
infosi = stepinfo(Wwi, "SettlingTimeThreshold", 0.05);

