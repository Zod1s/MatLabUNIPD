%% Initialisation
close all
clear
clc

%% Parameters
sys.Ts = 0.02;
load('params.mat')
Beq = 1.1122e-6; %[Nm / (rad/s)]
Req = sens.curr.Rs + mot.R; %[ohm]
Jeq = 5.7419e-7; %[kg m^2]

%% Motor parameters
tausf = 9.6e-3; %[Nm]
dac.Ts = 0.001; %[s]
dac.q = 20 / (2^16 - 1); %[V]
dac.V = 10; %[V]
diff.wc = 2 * pi * 50;
diff.d = 1 / sqrt(2);
pid.Kp = 0.232;
pid.Ki = 8;
awu.Tw = 0.145 / 3;
awu.en = 1;

%% Discrete speed filter
s = tf('s');
H = diff.wc^2 * s / (s^2 + 2 * diff.wc * diff.d * s + diff.wc^2);
Hd = c2d(H, sys.Ts, 'tustin');
[numd, dend] = tfdata(Hd, 'v');

%% Input
step.A = 250; %[rpm]
step.t = 1;

%% Opening system
open_system("motor2.slx")

%% Simulate
set_param("motor2", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "6");

sim("motor2");

%% Plotting results
figure(4)
subplot(2, 3, 1)
hold on
grid on
plot(step_resp.time, step_resp.signals(3).values)
ylabel("$u_{ideal}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(step_resp.time, step_resp.signals(4).values)
ylabel("$u_{real}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
stairs(step_resp.time, step_resp.signals(5).values)
plot(step_resp.time, step_resp.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(step_resp.time, step_resp.signals(2).values)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(step_resp.time, step_resp.signals(7).values)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.
