%% Initialisation
clear
close all
clc

%% Parameters
rads2rpm = 60 / (2 * pi); %[rpm * s/rad]
rpm2rads = 2 * pi / 60; %[rad/(s * rpm)]
Ts = 0.001;
mot.k = 5.2;
mot.T = 0.03;
ref.A = 300 * rpm2rads;
ref.t = 0.1;
d.A = -3;
d.t = 0.5;
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
w0 = 0;

z = tf('z', Ts);
s = (z - 1) / Ts;
H2 = minreal(diff.wc^2 * s / (s^2 + 2 * diff.wc * diff.d * s + diff.wc^2));
[num, den] = tfdata(H2, 'v');

%% Opening P model
open_system("motore_P.slx")
KpP = 0.7170 / 4;

%% Simulating them model
set_param("motore_P", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.001", "StopTime", "1");

sim("motore_P");

%% Plotting results
figure(1)
subplot(2, 1, 1)
hold on
grid on
stairs(w_star.time, w_star.data * rads2rpm)
plot(w.time, w.data * rads2rpm)
stairs(wm.time, wm.data * rads2rpm)
legend("w^{*}", "w", "w_{m}")

subplot(2, 1, 2)
hold on
grid on
plot(u.time, u.data)
legend("u")

%% Opening PI model
open_system("motore_PI.slx")
KpPI = 0.2255 / 4;

%% Simulating them model
set_param("motore_PI", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.001", "StopTime", "1");

sim("motore_PI");

%% Plotting results
figure(1)
subplot(2, 1, 1)
hold on
grid on
stairs(w_stari.time, w_stari.data * rads2rpm)
plot(wi.time, wi.data * rads2rpm)
stairs(wmi.time, wmi.data * rads2rpm)
legend("w^{*}", "w", "w_{m}")

subplot(2, 1, 2)
hold on
grid on
plot(ui.time, ui.data)
legend("u")

