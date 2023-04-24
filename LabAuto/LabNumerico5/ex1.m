%% Initialisation
clear
close all
clc

%% Parameters
load("params.mat")
Beq = 1.28e-6; %[Nm/(rad/s)] Beq = Bm + Bl / N^2
Jeq = mld.J / gbox.N^2 + mot.J; 
tausf = 1e-2; %[Nm]
dac.Ts = 0.001; %[s]
dac.q = 20 / (2^16 - 1); %[V]
dac.V = 10; %[V]
diff.Tc = 1 / (2 * pi * 50);
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
diff.N = 10;
diff.Ts = 0.001;
diff.d = 1;
us.t = 1.5; %[s]
us.i = 6; %[V]
us.f = -6; %[V]

%% Simulink model
open_system("motor1.slx")

%% Simulate
set_param("motor1", "SolverType", "Fixed-step", "Solver", "ode3", ...
    "MaxStep", "0.0001", "StopTime", "0.1");

sim("motor1");

%% Plotting results
figure(1)
subplot(2, 2, 1)
hold on
grid on
plot(u.time, u.data)
legend("u")

subplot(2, 2, 2)
hold on
grid on
plot(w.time, w.data)
legend("w")

subplot(2, 2, 3)
hold on
grid on
plot(wl.time, wl.data)
legend("w_{l}")


