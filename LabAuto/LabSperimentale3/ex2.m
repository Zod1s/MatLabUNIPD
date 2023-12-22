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

%% DATA Layout
% 1 -> wl_star
% 2 -> al_sstar
% 3 -> e
% 4 -> u_ideal
% 5 -> u_real
% 6 -> w
% 7 -> th
% 8 -> ia
%% Plotting results
figure(1)
subplot(2, 3, 1)
xlim([0 3])
ylim([-15 15])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(5).values, "b")
ylabel("$u$ [V]", "Interpreter", "latex")

subplot(2, 3, 4)
xlim([0 3])
ylim([-15 15])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(5).values, "b")
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
xlim([0 3])
ylim([-500 500])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(6).values, "r")
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(2, 3, 5)
xlim([0 3])
ylim([-500 500])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(6).values, "r")
plot(awu_ff_resp.time, awu_ff_resp.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(2, 3, 3)
xlim([0 3])
ylim([-60 60])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(3).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")

subplot(2, 3, 6)
xlim([0 3])
ylim([-60 60])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(3).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% 
figure(1)
subplot(1, 3, 1)
xlim([0 3])
ylim([-15 15])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(5).values, "b")
ylabel("$u_{real}$ [V]", "Interpreter", "latex")

subplot(1, 3, 2)
xlim([0 3])
ylim([-500 500])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(6).values, "r")
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(1, 3, 3)
xlim([0 3])
ylim([-60 60])
hold on
% grid minor
plot(awu_no_ff_resp.time, awu_no_ff_resp.signals(3).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")

figure(2)
subplot(1, 3, 1)
xlim([0 3])
ylim([-15 15])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(5).values, "b")
ylabel("$u_{real}$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(1, 3, 2)
xlim([0 3])
ylim([-500 500])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(6).values, "r")
plot(awu_ff_resp.time, awu_ff_resp.signals(1).values, "b--")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("misurata", "riferimento")

subplot(1, 3, 3)
xlim([0 3])
ylim([-60 60])
hold on
% grid minor
plot(awu_ff_resp.time, awu_ff_resp.signals(3).values, "b")
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")