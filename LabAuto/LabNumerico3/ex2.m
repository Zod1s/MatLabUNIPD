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
k = 0; %[N/m]

Ie = I + m * l^2;
Me = M + m;
den = Me * Ie - m^2 * l^2;

%% Space state model for downward equilbrium
Fd = [0                 1                       0   0;
      0   -(Ie * b) / den     m^2 * l^2 * g / den   0;
      0                 0                       0   1;
      0   m * l * b / den   -Me * m * l * g / den   0;
     ];

Gd = [           0;
          Ie / den;
                 0;
      -m * l / den;
     ];

Hd = [1 0 0 0;
      0 0 1 0];

Jd = 0;

downward = ss(Fd, Gd, Hd, Jd);
Pd = tf(downward);
Pdx = Pd(1);
Pdth = Pd(2);

%% Space state model for upward equilibrium
Fu = [0                   1                       0    0;
      0     -(Ie * b) / den     m^2 * l^2 * g / den    0;
      0                   0                       0    1;
      0    -m * l * b / den    Me * m * l * g / den    0;
     ];

Gu = [          0;
         Ie / den;
                0;
      m * l / den;
     ];

Hu = [1 0 0 0;
      0 0 1 0];

Ju = 0;

upward = ss(Fu, Gu, Hu, Ju);
Pu = tf(upward);
Pux = Pu(1);
Puth = Pu(2);

%% Computing the eigenvalues
% The stability can be determined by the linearization theorem  
eigd = eig(Fd);
eigu = eig(Fu);
figure(1)
subplot(1, 2, 1)
hold on
grid on
zplane(eigd)
% The first linearized system is marginally stable, so nothing can be said
% about the equilibrium of the non linear system around that point

subplot(1, 2, 2)
hold on
grid on
zplane(eigu)
% The second system is unstable, since one of the eigenvalues of the
% linearized system has a positive real part


%% BIBO Stability from F to theta
pdth = pole(Pdth);
% All the poles have strictly negative real part, so the system is BIBO
% stable

puth = pole(Puth);
% One the poles has strictly positive real part, so the system is not BIBO
% stable

%% BIBO Stability from F to theta
pdx = pole(Pdx);
% One of the poles is the origin, so the system is not BIBO stable

pux = pole(Pux);
% One of the poles is the origin, so the system is not BIBO stable

%% Opening the model
open_system("nl_cart_2.slx")

%% Comparing natural responses with the upward model
xu0 = 0;
dxu0 = 0;
thu0 = pi / 8;
dthu0 = 0;
x0u = [xu0; dxu0; thu0; dthu0];
% x0u = [xu0, dxu0, thu0, dthu0];

%% Simulating the simulink model
set_param("nl_cart_2", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "5");

sim("nl_cart_2");

%% Simulating the linearized model
[xthu, t] = initial(upward, x0u, 5);
xu = xthu(:, 1);
thu = xthu(:, 2);

%% Comparing the results
figure(2)
subplot(1, 2, 1)
hold on
grid on
yline(xu0)
plot(x.time, x.data)
plot(t, xu)
legend("initial", "x", "xu")

subplot(1, 2, 2)
hold on
grid on
yline(thu0)
yline(pi)
plot(th.time, th.data)
plot(t, thu)
legend("initial", "pi", "theta", "thetau")

%% Comparing natural responses with the downward model
xd0 = 0;
dxd0 = 0;
thd0 = pi / 8;
dthd0 = 0;
x0d = [xd0; dxd0; thd0; dthd0];
% x0u = [xu0, dxu0, thu0, dthu0];

%% Simulating the simulink model
set_param("nl_cart_2", "SolverType", "Variable-step", "Solver", "ode45", ...
    "MaxStep", "0.0001", "StopTime", "5");

sim("nl_cart_2");

%% Simulating the linearized model
[xthd, t] = initial(downward, x0d, 5);
xd = xthd(:, 1);
thd = xthd(:, 2);

%% Comparing the results
figure(3)
subplot(1, 2, 1)
hold on
grid on
yline(xd0)
plot(x.time, x.data)
plot(t, xd)
legend("initial", "x", "xd")

subplot(1, 2, 2)
hold on
grid on
yline(thd0)
plot(th.time, th.data - pi)
plot(t, thd)
legend("initial", "theta", "thetad")

%% Spring
k = 10;
K = [k, 0, 0, 0];

Fd1 = Fd - Gd * K;
Gd1 = 0;
Hd1 = Hd;
Jd1 = 0;

eigd1 = eig(Fd1);
figure(4)
hold on
grid on
zplane(eigd1)
% All the poles have strictly negative real part, so the linearized model
% is asimptotically stable. This means that the original model is
% asimptotically stable in x = [0, 0, 0, 0]
