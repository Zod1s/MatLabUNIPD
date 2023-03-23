%% Initialisation
clear all
close all
clc

%% Parameters
rads2rpm = 60 / (2 * pi); %[rpm * s/rad]
rpm2rads = 2 * pi / 60; %[rad/(s * rpm)]
mot.k = 5.2;
mot.T = 0.03;
Kp = 0.7442;
w.t = 0.1; %[s]
w.A = 300 * rpm2rads; %[rad/s]
d.t = 0.5; %[s]
d.A = -3; %[V]
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
w0 = 0; %[rad/s]

%% Open the model
open_system("motore_P.slx");

%% Simulating the model
set_param("motore_P", "SolverType", "Variable-step", ...
    "Solver", "ode45", "MaxStep", "0.001", "StopTime", "1");

sim("motore_P");

%% Plotting results
figure(1)
subplot(2, 1, 1)
hold on
grid on
plot(w_star.time, w_star.data * rads2rpm)
plot(w.time, w.data * rads2rpm)
plot(wm.time, wm.data * rads2rpm)
legend("w^{*}", "w", "w_{m}")

subplot(2, 1, 2)
hold on
grid on
plot(u.time, u.data)
legend("u")

%% Open the model
open_system("motore_PI.slx");

%% Simulating the model
set_param("motore_PI", "SolverType", "Variable-step", ...
    "Solver", "ode45", "MaxStep", "0.001", "StopTime", "5");

sim("motore_PI");

%% Plotting results
figure(1)
subplot(2, 1, 1)
hold on
grid on
plot(w_star_i.time, w_star_i.data * rads2rpm)
plot(w_i.time, w_i.data * rads2rpm)
plot(wm_i.time, wm_i.data * rads2rpm)
legend("w^{*}", "w", "w_{m}")

subplot(2, 1, 2)
hold on
grid on
plot(u_i.time, u_i.data)
legend("u")
















