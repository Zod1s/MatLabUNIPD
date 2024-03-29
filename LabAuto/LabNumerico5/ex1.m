%% Initialisation
clear
close all
clc

%% Parameters
load("params.mat")
Beq = 1.28e-6; %[Nm/(rad/s)] Beq = Bm + Bl / N^2
Jeq = mld.J / gbox.N^2 + mot.J; %[kg m^2]
tausf = 1e-2; %[Nm]
dac.Ts = 0.001; %[s]
dac.q = 20 / (2^16 - 1); %[V]
dac.V = 10; %[V]
diff.Tc = 1 / (2 * pi * 50); %[s]
diff.wc = 2 * pi * 50; %[rad]
diff.d = 1 / sqrt(2);
diff.N = 10;
diff.Ts = 0.001; %[s]
diff.type = 3; %[2nd order]
us.t = 3; %[s]
us.A = -6; %[V]

%% Simulink model
open_system("motor1.slx")

%% Simulate
set_param("motor1", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "18");

sim("motor1");

%% Plotting results
figure(1)
subplot(2, 2, 1)
hold on
grid on
plot(u.time, u.data, "k")
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 2, 2)
hold on
grid on
plot(w.time, w.data, "Color", [0.8 0.8 0.8])
plot(wl.time, wl.data, "--k")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("real","measured")

subplot(2, 2, 3)
hold on
grid on
plot(thl.time, thl.data, "Color", [0.8 0.8 0.8])
plot(thl.time, thl.data, "--k")
ylabel("$\theta_{l}$ [deg]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("real","measured")

subplot(2, 2, 4)
hold on
grid on
plot(ia.time, ia.data, "k")
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Single images
figure(3)
hold on
grid on
plot(w.time, w.data, "Color", [0.8 0.8 0.8])
plot(wl.time, wl.data, "--k")
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")
legend("real","measured")

%% Comparing Bode plots of derivative filters
s = tf('s');
z = tf('z', diff.Ts);

H1 = s / (diff.Tc * s + 1);
H2 = diff.wc^2 * s / (s^2 + 2 * diff.d * diff.wc * s + diff.wc^2);
H3 = (1 - z^-diff.N) / (diff.Ts * diff.N);

figure(2)
hold on
grid onsìsì
bode(H1)
bode(H2)
bode(H3)

legend("H1", "H2", "H3")

% H2 and H3 attenuate high frequencies, whereas H1 has a nearly constant
% gain at high frequencies, so it doesn't attenuate noise.
