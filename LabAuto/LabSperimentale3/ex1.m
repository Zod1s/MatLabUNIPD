%% Initialisation
clc
clear
close all

%% Parameters
load('params.mat')
s = tf('s');
Beq = 1.11e-6; %[Nm / (rad/s)]
Req = sens.curr.Rs + mot.R; %[ohm]
Jeq = 5.87e-7; %[kg m^2]

%% Motor parameters
tausf = 9.7e-3; %[Nm]
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
awu.Tw = 0.03;
awu.en = 0;

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
plot(u_ideal.time, u_ideal.data)
ylabel("$u_{ideal}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(u_real.time, u_real.data)
ylabel("$u_{real}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(wl.time, wl.data)
plot(w.time, w.data, "--")
plot(wl_star.time, wl_star.data)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("real", "measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
plot(e.time, e.data)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(ia.time, ia.data)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.
