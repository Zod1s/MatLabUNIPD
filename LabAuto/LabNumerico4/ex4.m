%% Initialisation
clear
close all
clc

%% Parameters
M = 0.455; %[kg]
m = 0.21; %[kg]
l = 0.305; %[m]
I = 0.0065; %[kg * m^2]
b = 1; %[Ns/m]
g = 9.81; %[m/s^2]
k = 0;

Ie = I + m * l^2;
Me = M + m;

den = Me * Ie - (m * l)^2;

%% Transfer functions
s = tf('s');
D = den * s^3 + b * Ie * s^2 - Me * m * g * l * s - b * m * l * g;

Pth = m * l * s / D;
Px = (Ie * s^2 - m * g * l) / (s * D);

%% Proportional controller for Pth
prop = minreal(feedback(Pth, 1));
figure(1)
hold on
grid on
rlocus(prop)
% For every k > 0, there is always a real positive pole, so the system
% is unstable
% Using kcrit = margin(prop) gives the k for which the branches cross the 
% imaginary axis. From the rlocus, it can be determined whether kcrit is
% the maximum k allowed or the minimum k allowed for stability.


%% PI controller for Pth
propi = minreal(feedback(Pth / s, 1));
figure(2)
hold on
grid on
rlocus(propi)
% For every k > 0, there is always at least one pole with positive real
% part, so the system is unstable

%% Adding a zero to the system
pizero1 = minreal(feedback(Pth * (s + 10) / s, 1));
figure(3)
hold on
grid on
rlocus(pizero1)
% For every k > 0, there is always at least one pole with positive real
% part, so the system is unstable

%% Moving the zero
pizero2 = minreal(feedback(Pth * (s + 4) / s, 1));
figure(4)
hold on
grid on
rlocus(pizero2)
% For every k > 0, there is always at least one pole with positive real
% part, so the system is unstable

%% Moving the zero
pizero3 = minreal(feedback(Pth * (s + 1) / s, 1));
figure(5)
hold on
grid on
rlocus(pizero3)
% For a sufficiently large k > 0, all the poles have negative real part, so
% the closed loop is stable

%% Verifying the poles
k = 11;
C = k * (s + 1) / s;
pizero4 = minreal(feedback(Pth * C, 1));
% All the poles have negative real part

%% Adding another zero
kth = 40;
Cth = kth * (s + 1) * (s + 3) / (s * (s + 10));
[numth, denth] = tfdata(Cth, 'v');
pizero5 = minreal(feedback(Pth * Cth, 1));
% All the poles have negative real part

%% Initial conditions
x0 = 0;
dx0 = 0;
th0 = pi / 6;
dth0 = 0;

%% Opening the model
open_system("nl_cart_4.slx")

%% Simulating the model
set_param("nl_cart_4", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.001", "StopTime", "5");

sim("nl_cart_4")

%% Plotting the results
figure(6)
subplot(2, 2, 1)
hold on
grid on
yline(x0)
plot(x.time, x.data)
legend("x0", "x")

subplot(2, 2, 3)
hold on
grid on
yline(dx0)
plot(dx.time, dx.data)
legend("dx0", "dx")

subplot(2, 2, 2)
hold on
grid on
yline(th0)
yline(pi)
plot(th.time, th.data)
legend("theta0", "pi", "theta")

subplot(2, 2, 4)
hold on
grid on
yline(dth0)
plot(dth.time, dth.data)
legend("dtheta0", "dtheta")

%% Controller for Px
Gx = minreal(Px / (1 + Cth * Pth));
propix = minreal(feedback(Gx / s, 1));
figure(7)
grid on
hold on
rlocus(propix)

%% Negative rlocus
propixn = minreal(feedback(-Gx / s, 1));
figure(8)
grid on
hold on
rlocus(propixn)

%% Adding a zero
pizerox1 = minreal(feedback(-Gx * (s + 0.5) / s, 1));
figure(9)
grid on
hold on
rlocus(pizerox1)

%% Adding another zero
pizerox2 = minreal(feedback(-Gx * (s + 0.5)^2 / (s * (s + 10)), 1));
figure(10)
grid on
hold on
rlocus(pizerox2)

%% Verifying the stability
kx = -15;
Cx = -15 * (s + 0.5)^2 / (s * (s + 10));
[numx, denx] = tfdata(Cx, 'v');
pizerox3 = minreal(feedback(Gx * Cx, 1));

%% Opening the model
open_system("nl_cart_5.slx")

%% Stability
st.A = 1;
st.t = 5;
d.A = 5;
d.t = 15;
x0 = 0;
dx0 = 0;
th0 = pi / 6;
dth0 = 0;

%% Simulating the model
set_param("nl_cart_5", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.001", "StopTime", "40");

sim("nl_cart_5")

%% Plotting the results
figure(11)
subplot(2, 2, 1)
hold on
grid on
yline(x0)
yline(st.A)
plot(x.time, x.data)
legend("x0", "new\_ref", "x")

subplot(2, 2, 3)
hold on
grid on
yline(dx0)
plot(dx.time, dx.data)
legend("dx0", "dx")

subplot(2, 2, 2)
hold on
grid on
yline(th0)
yline(pi)
yline(0)
plot(th.time, th.data)
legend("theta0", "pi", "0", "theta")

subplot(2, 2, 4)
hold on
grid on
yline(dth0)
plot(dth.time, dth.data)
legend("dtheta0", "dtheta")





