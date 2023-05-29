%% Initialisation
clc
clear
close all

%% Parameters
load('params.mat')
s = tf('s');
Beq = 1.26e-6; %[Nm / (rad/s)]
Req = sens.curr.Rs + mot.R; %[ohm]
Jeq = mot.J + mld.J / gbox.N^2; %[kg m^2]
km = drv.dcgain * mot.Kt / (Req * Beq + mot.Kt * mot.Ke);
Tm = Req * Jeq / (Req * Beq + mot.Kt * mot.Ke);
P = km / (gbox.N * (Tm * s + 1)); % Omegal / U

%% Bode plot of P
figure(1)
hold on
grid on
bode(P)

%% Spec of controller
% A PI controller introduces a pole in zero, that allows perfect steady
% state tracking of a constant reference and perfect steady state rejection
% of constant disturbances.
tsmax = 0.18; %[s]
Mpmax = 0.088; %[%]

% Converting time specs to frequency specs
delta = -log(Mpmax) / sqrt(pi^2 + (log(Mpmax))^2);
wgc = 3 / (delta * tsmax);
phim = atan2(2 * delta, sqrt(sqrt(1 + 4 * delta^4) - 2 * delta^2));

% Determining Ki and Kp
p = evalfr(P, wgc * 1j);
DK = 1 / abs(p);
DP = -pi + phim - angle(p);
Kp = DK * cos(DP);
Ki = -wgc * DK * sin(DP);
C = Kp + Ki / s;

%% Closed-loop function evaluation
W = feedback(C * P, 1);
figure(2)
hold on
grid on
step(W)
stepinfo(W, "SettlingTimeThreshold", 0.05)

figure(3)
hold on
grid on
margin(W)

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
pid.Kp = Kp;
pid.Ki = Ki;

%% Step response
step.T = 3; %[s]
step.A = -250; %[rpm]
step.simtime = "18";

%% Staircase response
stair.dw = -50; %[rpm]
stair.dt = 5; %[s]
stair.time = 45;
stair.k = 1:((stair.time / stair.dt) + 1);
stair.simtime = string(stair.time);

%% Triangular wave
% Only one cicle is needed
triang.A = 450; %[rpm/s]
triang.dt = 2; %[s] Half length of a cycle
% Where the zeros and the peak are in the cycle
triang.times = (0:2) * triang.dt;
triang.values = [0 1 0]; % Normalized values assumed by the function
triang.simtime = "20";

%% Opening system
open_system("motor.slx")

%% Simulate
input = 3;

set_param("motor", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", stair.simtime);

sim("motor");

%% Plotting results
figure(4)
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

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.
