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
diff.type = 2;
wlstar.T = 3; %[s]
wlstar.A = -250; %[rpm]
pid.Kp = 0.01;
pid.Ki = 4;

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
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 2, 2)
hold on
grid on
plot(wl.time, wl.data)
plot(w.time, w.data, "--")
plot(wl_star.time, wl_star.data)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("real", "measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 2, 3)
hold on
grid on
plot(e.time, e.data)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 2, 4)
hold on
grid on
plot(ia.time, ia.data)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% P controller isn't capable of tracking a constant reference due to its
% lack of a pole in the origin, so the type of the system is 0. PI
% controller has a pole in the origin, so the system is type 1 and is
% capable of tracking constant references with zero steady-state error.
