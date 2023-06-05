%% Initialisation
close all
clear
clc

%% Parameters
sys.Ts = 0.02;
s = tf('s');
load('params.mat')
Beq = 1.26e-6; %[Nm / (rad/s)]
Req = sens.curr.Rs + mot.R; %[ohm]
Jeq = mot.J + mld.J / gbox.N^2; %[kg m^2]
km = drv.dcgain * mot.Kt / (Req * Beq + mot.Kt * mot.Ke);
Tm = Req * Jeq / (Req * Beq + mot.Kt * mot.Ke);
P = km / (gbox.N * (Tm * s + 1)); % Omegal / U

%% Discretizing the plant
Pd = c2d(P, sys.Ts, 'zoh');

%% Motor parameters
tausf = 1e-2; %[Nm]
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
stairs(w.time, w.data)
plot(wl_star.time, wl_star.data)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
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
