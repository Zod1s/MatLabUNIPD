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
F0 = 0; %[N]
k = 10; %[N/m]

Ie = I + m * l^2;
Me = M + m;

%% Initial conditions
x0 = 1;
dx0 = 0.1;
th0 = pi;
dth0 = 0;

%% Opening the model
open_system("nl_cart.slx")

%% Simulating
set_param("nl_cart", "SolverType", "Fixed-step", "Solver", "ode5", ...
    "MaxStep", "0.0001", "StopTime", "6");

sim("nl_cart");

%% Plotting results
figure(1)
subplot(2, 1, 1)
hold on
grid on
plot(x.time, x.data)
plot(dx.time, dx.data)
legend("X", "DX")

subplot(2, 1, 2)
hold on
grid on
plot(th.time, th.data)
plot(dth.time, dth.data)
legend("Theta", "DTheta")











