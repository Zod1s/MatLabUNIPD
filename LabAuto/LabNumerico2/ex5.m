%% Initialisation
clear all
close all
clc

%% Parameters
rpm2rads = 2 * pi / 60;
rads2rpm = 60 / (2 * pi);
mot.k = 5.2;
mot.T = 0.03;
Ts = 0.001;
wc = 2 * pi * 50;
d = 1  /sqrt(2);

s = tf('s');
z = tf('z', Ts);
P1 = mot.k / (mot.T * s + 1);
integ = 1 / s;
P = P1 * integ;

%% Discretising the model
P1z = c2d(P1, Ts, "zoh");
integz = Ts / (z - 1);
H2 = minreal(wc^2 / integz / ((1 / integz)^2 + 2 * d * wc * (1 / integz) ...
    + wc^2));

system = feedback(P1z * integz * H2, 1);
figure(1)
rlocus(system)
Kpc = margin(system);

%% Simulating the model
Kp = Kpc / 4;
k = 0:1:300;
t = k * Ts;

w1 = stepDataOptions("InputOffset", 0, "StepAmplitude", 300 * rpm2rads);

W = minreal(feedback(Kp * P1z, integz * H2));
w = step(W, w1, t);
Wm = minreal(feedback(Kp * P1z * integz * H2, 1));
wm = step(Wm, w1, t);
Wu = minreal(feedback(Kp, P1z * integz * H2));
u = step(Wu, w1, t);

figure(2)
hold on
grid on
plot(t, 300 * ones(1, length(t)))
plot(t, u)
plot(t, w * rads2rpm)
plot(t, wm * rads2rpm)
legend("input", "control signal", "actual speed", "measured speed")

%% Getting step response infos of Wu system
infos = stepinfo(Wu, "SettlingTimeThreshold", 0.05);

%% Using PI controller
C = (1 + 100 * integz);

systemPI = feedback(C * P1z * integz * H2, 1);
figure(3)
rlocus(systemPI)
KpcPI = margin(systemPI);

%% Simulating the model
KpPI = KpcPI / 4;

WPI = minreal(feedback(KpPI * C * P1z, integz * H2));
wPI = step(WPI, w1, t);
WmPI = minreal(feedback(KpPI * C * P1z * integz * H2, 1));
wmPI = step(WmPI, w1, t);
WuPI = minreal(feedback(KpPI * C, P1z * integz * H2));
uPI = step(WuPI, w1, t);

figure(2)
hold on
grid on
plot(t, 300 * ones(1, length(t)))
plot(t, uPI)
plot(t, wPI * rads2rpm)
plot(t, wmPI * rads2rpm)
legend("input", "control signal", "actual speed", "measured speed")

%% Getting step response infos of WuPI system
infosPI = stepinfo(WuPI, "SettlingTimeThreshold", 0.05);


