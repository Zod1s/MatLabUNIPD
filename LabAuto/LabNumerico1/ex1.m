%% Initialisation
close all
clear all
clc

%% Parameters
T = 1 / (2 * pi * 50);
wc = 2 * pi * 50;
d = 1 / sqrt(2);

s = tf('s');

A = 1;
t = 0:0.001:4;

%% Transfer functions
H0 = s;
H1 = s / (T * s + 1);
H2 = wc^2 * s / (s^2 + 2 * d * wc * s + wc^2);

%% Bode plots
figure(1)
hold on
bode(H0)
bode(H1)
bode(H2)
legend("Ideal", "H1", "H2")

%% Response to the first input signal
w1 = 2 * pi * 0.5;
u = A * sin(w1 * t);

y1 = lsim(H1, u, t, 0);
y2 = lsim(H2, u, t, 0);
y = A * w1 * cos(w1 * t);

figure(2)
hold on
plot(t, y)
plot(t, y1)
plot(t, y2)
legend("Ideal", "H1", "H2")

figure(3)
plot(t, y1 - y')

figure(4)
plot(t, y2 - y')

%% Response to the second input signal
w2 = 2 * pi * 20;
u = A * sin(w2 * t);

y1 = lsim(H1, u, t, 0);
y2 = lsim(H2, u, t, 0);
y = A * w2 * cos(w2 * t);

figure(2)
hold on
plot(t, y)
plot(t, y1)
plot(t, y2)
legend("Ideal", "H1", "H2")

figure(3)
plot(t, y1 - y')

figure(4)
plot(t, y2 - y')

%% Magnitude and phase evaluation
Hj0 = freqresp(H0, w2);
Hj1 = freqresp(H1, w2);
Hj2 = freqresp(H2, w2);
M0 = abs(Hj0);
p0 = angle(Hj0);
M1 = abs(Hj1);
p1= angle(Hj1);
M2 = abs(Hj2);
p2 = angle(Hj2);

% H2 is better in terms of magnitude, since is the nearer of the two to
% the ideal case

% H1 is better in terms of phase, since is the nearer of the two to
% the ideal case

%% Response to a ramp
a = 0.001;
r = 25 * t;
n = 2 * a * (rand(1, length(t)) - 0.5);
u = r + n;

yn1 = lsim(H1, u, t, 0);
yn2 = lsim(H2, u, t, 0);

figure(5)
hold on
plot(t, yn1)
plot(t, yn2)

%% Evaluating the variance
v1 = var(yn1(100:end));
v2 = var(yn2(100:end));

% yn2 has a smaller variance, so H2 produces the less noisy output







