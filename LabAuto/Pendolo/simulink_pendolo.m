%% Initialisation
clear all
clc
close all

%% Vars
deg2rad = pi / 180;
rad2deg = 180 / pi;

b = 0;
l = 0.1;
m = 1;
g = 9.81;

%% Open the system
open_system("pendolo.slx");

%% Initial conditions
th0 = 10 * deg2rad;
dot_th0 = 0;

A = [0, 1; -g / l, -b / (m * l^2)];
B = zeros(2, 1);
C = eye(2);
D = zeros(2, 1);
x0 = [th0; dot_th0];

%% Simulation   
set_param("primo", "SolverType", "Variable-step", ...
    "Solver", "ode45", "MaxStep", "0.01", "MinStep", "auto", ...
    "AbsTol", "auto", "RelTol", "1e-3", "StopTime", "15");

sim("primo");

%% Plotting results
t = simres.time;
th = simres.signals(1).values;
dot_th = simres.signals(2).values;

figure(1)
subplot(2, 1, 1);
plot(t, th);
ylabel("Position [rad]");
grid on;

subplot(2, 1, 2);
plot(t, dot_th);
ylabel("Angular velocity [rad/s]");
grid on;

%% Period
m = sin(th0 / 2);
K = ellipke(m^2);
T_nln = 4 * sqrt(l / g) * K;

%% Verifying the period
tf1 = T_nln * floor(t(end) / T_nln);

Ts = T_nln / 100;
t1 = 0:Ts:tf1;
th1 = interp1(t, th, t1);

Fs = 1 / Ts;
N1 = length(t1);
f1 = linspace(-Fs/2, Fs/2, N1);

th1_fft = 1 / N1 * fft(th1);

figure(2)
grid on
plot(f1, abs(fftshift(th1_fft)));








