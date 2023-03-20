%% Initialisation
clear all
clc
close all

%% Vars
mot.k = 8.3;
mot.T = 0.028;
wctrl.kp = 8.4e-3;
wctrl.ki = 1.05;
drv.kc = 0.6;

Ts = 0.01;

rads2rpm = 60 / (2 * pi);
rpm2rads = 2 * pi / 60;

%% Open the system
open_system("motore.slx");

%% Initial conditions


%% Simulation   
set_param("motore", "SolverType", "Variable-step", ...
    "Solver", "ode45", "MaxStep", "0.001", "StopTime", "0.5");

sim("motore");

%% Plotting results


