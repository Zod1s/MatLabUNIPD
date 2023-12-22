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
figure(1)
subplot(2, 3, 1)
xlim([0 3])
ylim([0 16])
hold on
plot(step_no_awu.time, step_no_awu.signals(3).values, "r")
plot(step_no_awu.time, step_no_awu.signals(4).values, "b")
legend("richiesta", "fornita")
ylabel("$u$ [V]", "Interpreter", "latex")

subplot(2, 3, 4)
xlim([0 3])
ylim([0 16])
hold on
plot(step_awu.time, step_awu.signals(3).values, "r")
plot(step_awu.time, step_awu.signals(4).values, "b")
legend("richiesta", "fornita")
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
xlim([0 3])
ylim([0 500])
hold on
plot(step_no_awu.time, step_no_awu.signals(5).values, "r")
plot(step_no_awu.time, step_no_awu.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(2, 3, 5)
xlim([0 3])
ylim([0 500])
hold on
plot(step_awu.time, step_awu.signals(5).values, "r")
plot(step_awu.time, step_awu.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(2, 3, 3)
xlim([0 3])
hold on
plot(step_no_awu.time, step_no_awu.signals(2).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")

subplot(2, 3, 6)
xlim([0 3])
hold on
plot(step_awu.time, step_awu.signals(2).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% DATA Layout
% 1 -> wl_star
% 2 -> e
% 3 -> u_ideal
% 4 -> u_real
% 5 -> w
% 6 -> th
% 7 -> ia

