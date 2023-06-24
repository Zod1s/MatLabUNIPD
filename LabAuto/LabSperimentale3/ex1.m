%% Initialisation
clc
clear
close all

%% Parameters
load('params.mat')
s = tf('s');
Beq = 1.1122e-6; %[Nm / (rad/s)]
Req = sens.curr.Rs + mot.R; %[ohm]
Jeq = 5.7419e-7; %[kg m^2]

%% Motor parameters
tausf = 9.6e-3; %[Nm]
dac.Ts = 0.001; %[s]
dac.q = 20 / (2^16 - 1); %[V]
dac.V = 10; %[V]
diff.Tc = 1 / (2 * pi * 50);
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
diff.N = 10;
diff.Ts = 0.001;
diff.type = 2;
pid.Kp = 0.0298;
pid.Ki = 6.5015;
awu.Tw = 0.145 / 3;
awu.en = 1;

%% Step response
step.T = 1; %[s]
step.A = 450; %[rpm]
step.simtime = "5";

%% Opening system
open_system("motor1.slx")

%% Simulate
set_param("motor1", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", step.simtime);

sim("motor1");

%% Plotting results
figure(4)
subplot(2, 3, 1)
hold on
grid on
plot(step_no_awu.time, step_no_awu.signals(3).values)
ylabel("$u_{ideal}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(step_no_awu.time, step_no_awu.signals(4).values)
ylabel("$u_{real}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
plot(step_no_awu.time, step_no_awu.signals(5).values, "--")
plot(step_no_awu.time, step_no_awu.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(step_no_awu.time, step_no_awu.signals(2).values)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(step_no_awu.time, step_no_awu.signals(7).values)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% DATA Layout
% 1 -> wl_star
% 2 -> e
% 3 -> u_ideal
% 4 -> u_real
% 5 -> w
% 6 -> th
% 7 -> ia

