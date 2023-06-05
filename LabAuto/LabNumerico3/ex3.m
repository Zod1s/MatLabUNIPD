%% Initialisation
clear
close all
clc

%% Parameters
M = 0.455; %[kg]
m = 0.21; %[kg]
l = 0.305; %[m]
I = 0.0065; %[kg * m^2]
b = 1; %[Ns/m]
g = 9.81; %[m/s^2]

Ie = I + m * l^2;
Me = M + m;

den = Me * Ie - (m * l)^2;

k1 = -0.02;
k2 = -1.1;
k3 = 7.5;
k4 = 0.7;
K = [k1, k2, k3, k4];
e = 1;

%% Initial conditions
x0 = 10;
dx0 = 0;
th0 = 0;
dth0 = 0;

%% Simulink
open_system("nl_cart_3.slx")

%% Simulating
set_param("nl_cart_3", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.1", "StopTime", "25");

sim("nl_cart_3")

%% Plotting results
figure(1)
subplot(2, 2, 1)
hold on
grid on
yline(x0)
plot(x.time, x.data)
legend("x0", "x")

subplot(2, 2, 3)
hold on
grid on
yline(dx0)
plot(dx.time, dx.data)
legend("dx0", "dx")

subplot(2, 2, 2)
hold on
grid on
yline(th0)
yline(pi)
plot(th.time, th.data)
legend("theta0", "theta")

subplot(2, 2, 4)
hold on
grid on
yline(dth0)
plot(dth.time, dth.data)
legend("dtheta0", "dtheta")

%% Space state model for upward equilibrium
Fu = [0                   1                       0    0;
      0     -(Ie * b) / den     m^2 * l^2 * g / den    0;
      0                   0                       0    1;
      0    -m * l * b / den    Me * m * l * g / den    0;
     ];

Gu = [          0;
         Ie / den;
                0;
      m * l / den;
     ];

Hu = [1 0 0 0;
      0 0 1 0];

Ju = 0;

upward = ss(Fu - Gu * K, 0 * Gu, Hu, Ju);

%% Poles of upward
eigu = eig(Fu - Gu * K);
figure(2)
grid on
hold on
zplane(eigu)
