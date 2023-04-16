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

Ie = I + m * l^2;
Me = M + m;
den = Me * Ie - m^2 * l^2;

%% Space state model for downward equilbrium
Fd = [0               1                     0 0;
      0 -(Ie * b) / den   m^2 * l^2 * g / den 0;
      0               0                     0 1;
      0 m * l * b / den -Me * m * l * g / den 0;
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
Fu = [0                1                    0 0;
      0  -(Ie * b) / den  m^2 * l^2 * g / den 0;
      0                0                    0 1;
      0 -m * l * b / den Me * m * l * g / den 0;
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
eigd = eig(Fd);
figure(1)
hold on
grid on
zplane(eigd)
% The first linearized system is marginally stable, so nothing can be said
% about the equilibrium of the non linear system around that point

eigu = eig(Fu);
figure(2)
hold on
grid on
zplane(eigu)
% The second system is unstable, since one of the eigenvalues of the
% linearized system has a positive real part

%% BIBO Stability from F to theta
[numdth, dendth] = tfdata(Pdth, 'v');
[zdth, pdth, kdth] = tf2zp(numdth, dendth);
% All the poles have strictly negative real part, so the system is BIBO
% stable

[numuth, denuth] = tfdata(Puth, 'v');
[zuth, puth, kuth] = tf2zp(numuth, denuth);
% One the poles has strictly positive real part, so the system is not BIBO
% stable

%% BIBO Stability from F to x
[numdx, dendx] = tfdata(Pdx, 'v');
[zdx, pdx, kdx] = tf2zp(numdx, dendx);
% One of the poles is the origin, so the system is not BIBO stable

[numux, denux] = tfdata(Pux, 'v');
[zux, pux, kux] = tf2zp(numux, denux);
% One of the poles is the origin, so the system is not BIBO stable

%% Initial conditions
xu = [0; 0; pi / 8; 0];
xd = [0; 0; 7 * pi / 8; 0];

figure(3)
grid on
initial(downward, xu)

%% Initiali conditions for Simulink
x0 = 0;
dx0 = 0;
th0 = 0;
dth0 = 0;





