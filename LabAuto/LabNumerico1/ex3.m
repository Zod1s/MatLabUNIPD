%% Initialisation
clear all
close all
clc

%% Parameters
rads2rpm = 60 / (2 * pi); %[rpm * s/rad]
rpm2rads = 2 * pi / 60; %[rad/(s * rpm)]
mot.k = 5.2;
mot.T = 0.03;
Kp = 0.744;
w.t = 0.1; %[s]
w.A = 300 * rpm2rads; %[rad/s]
d.t = 0.5; %[s]
d.A = -3; %[V]
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
w0 = 0; %[rad/s]

open_system("motore.slx");

%% System simulation
set_param("motore", "SolverType", "Variable-step", ...
    "Solver", "ode45", "MaxStep", "0.001", "StopTime", "5");

sim("motore");




