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
awu.Tw = 0.03;
awu.en = 1;
ff.en = 1;
ff.BEMF = gbox.N * mot.Ke / drv.dcgain;
ff.friction = Req / (drv.dcgain * mot.Kt * gbox.N);
ff.inertia = gbox.N * Req * Jeq / (drv.dcgain * mot.Kt);
ff.coulomb = tausf;
ff.viscous = gbox.N^2 * Beq;

%% Input function
in.a = 900; %[rpm / s]
in.t = 0.5; %[s]
in.simtime = "3";

%% Opening system
open_system("motor2.slx")

%% Simulate
set_param("motor2", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", in.simtime);

sim("motor2");

%% Plotting results
figure(4)
subplot(2, 3, 1)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(4).values)
ylabel("$u_{ideal}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(5).values)
ylabel("$u_{real}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(6).values, "--")
plot(awu_ff_resp.time, awu_ff_resp.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(3).values)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(8).values)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 6)
hold on
grid on
plot(awu_ff_resp.time, awu_ff_resp.signals(2).values)
ylabel("$a_{l}$ [rpm / s]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.

%% DATA Layout
% 1 -> wl_star
% 2 -> al_sstar
% 3 -> e
% 4 -> u_ideal
% 5 -> u_real
% 6 -> w
% 7 -> th
% 8 -> ia

