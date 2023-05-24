%% Initialisation
clc
clear
close all

%% Parameters
load('params.mat')
Beq = 1.26e-6; %[Nm / (rad/s)]
Jeq = mot.J + mld.J / gbox.N^2; %[kg m^2]

%% Motor parameters
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
pid.Kp = 0.0298; % Kp;
pid.Ki = 6.5015; % Ki;
input = 3;

%% Step response
step.T = 3; %[s]
step.A = -250; %[rpm]
step.simtime = "18";

%% Staircase response
stair.dw = 50; %[rpm]
stair.dt = 5; %[s]
stair.time = 45;
stair.k = 1:((stair.time / stair.dt) + 1);
stair.simtime = string(stair.time);

%% Triangular wave
% Only one cicle is needed
triang.A = 450; %[rpm/s]
triang.dt = 1; %[s] Half length of a cycle
% Where the zeros and the peak are in the cycle
triang.times = (0:2) * triang.dt;
triang.values = [0 1 0]; % Normalized values assumed by the function
triang.simtime = "20";

%% Opening system
open_system("motor.slx")

%% Simulate
set_param("motor", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", step.simtime);

sim("motor");

%% Plotting results
figure(4)
subplot(2, 3, 1)
hold on
grid on
plot(step_resp.time, step_resp.signals(3).values)
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(step_resp.time, step_resp.signals(4).values, "--")
plot(step_resp.time, step_resp.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
plot(step_resp.time, step_resp.signals(2).values)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(step_resp.time, step_resp.signals(6).values)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(step_resp.time, step_resp.signals(5).values)
ylabel("$\theta$ [deg]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.

%% DATA STRUCTURE
% 1 -> wl_star
% 2 -> e
% 3 -> u
% 4 -> w
% 5 -> th
% 6 -> ia

%% Plots
figure(5)
hold on
grid on
plot(triang_resp.time, triang_resp.signals(4).values, "--")
plot(triang_resp.time, triang_resp.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")





