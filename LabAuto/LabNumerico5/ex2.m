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
diff.type = 3;
us.t = 1.5; %[s]
us.A = -6; %[V]

%% Simulink model
open_system("motor2.slx")

%% Simulate
set_param("motor2", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "18");

sim("motor2");

%% Plotting results
figure(1)
subplot(2, 2, 1)
hold on
grid on
plot(u.time, u.data)
ylabel("u [V]")
xlabel("t [s]")

subplot(2, 2, 2)
hold on
grid on
plot(wl.time, wl.data)
plot(w.time, w.data, "--")
ylabel("\omega_{l} [rpm]")
legend("real","measured")
xlabel("t [s]")

subplot(2, 2, 3)
hold on
grid on
plot(thl.time, thl.data)
plot(thl.time, thl.data, "--")
ylabel("\theta_{l} [deg]")
legend("real","measured")
xlabel("t [s]")

subplot(2, 2, 4)
hold on
grid on
plot(ia.time, ia.data)
ylabel("i_{a} [A]")
xlabel("t [s]")
