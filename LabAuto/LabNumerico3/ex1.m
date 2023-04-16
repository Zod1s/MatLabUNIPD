%% Initialisation
clear
close all
clc

%% Parameters
M = 0.455; %[kg]
m = 0.21; %[kg]
l = 0.305; %[m]
I = 0.0065; %[kg * m^2]
b = 0; %[Ns/m]
g = 9.81; %[m/s^2]
k = 10; %[N/m]

Ie = I + m * l^2;
Me = M + m;

%% Initial conditions
x0 = 1;
dx0 = 0.1;
th0 = pi * 7 / 8;
dth0 = 0;

%% Opening the model
open_system("nl_cart_1.slx")

%% Simulating
set_param("nl_cart_1", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "5");

sim("nl_cart_1");

%% Plotting results
figure(1)
subplot(2, 2, 1)
hold on
grid on
yline(x0)
plot(x.time, x.data)
legend("X")

subplot(2, 2, 3)
hold on
grid on
yline(dx0)
plot(dx.time, dx.data)
legend("DX")

subplot(2, 2, 2)
hold on
grid on
yline(th0)
yline(pi)
plot(th.time, th.data)
legend("Theta")

subplot(2, 2, 4)
hold on
grid on
yline(dth0)
plot(dth.time, dth.data)
legend("DTheta")
