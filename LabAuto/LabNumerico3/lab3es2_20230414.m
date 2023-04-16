clearvars;
clc;

% parametri nominali
M = 0.455;
m = 0.21;
l = 0.305;
I = 1/3*m*l^2;
b = 1;
Ie = I + m*l^2;
Me = m + M;
g = 9.81;
den = Me*Ie-(m*l)^2;
rad2deg = 180/pi;

%% EXERCISE 2: model linearization and stability

%% 1. SS representation of downward (Sd) and upward (Su) systems

% downward(d)
Ad = [0,1,0,0;
      0,-b*Ie/den,(m*l)^2*g/den,0;
      0,0,0,1;
      0,m*l*b/den,-m*g*l*Me/den,0];
Bd = [0;Ie/den;0;-m*l/den];
Cd = [0,0,1,0;
      1,0,0,0];
Dd = [0;0];
Sd = ss(Ad,Bd,Cd,Dd);
Pd = tf(Sd);
Pd_TH = Pd(1);
Pd_X  = Pd(2);

% upward(u)
Au = [0,1,0,0;
      0,-b*Ie/den,(m*l)^2*g/den,0;
      0,0,0,1;
      0,-m*l*b/den,m*g*l*Me/den,0];
Bu = [0;Ie/den;0;m*l/den];
Cu = [0,0,1,0;
      1,0,0,0];
Du = [0;0];
Su = ss(Au,Bu,Cu,Du);
Pu = tf(Su);
Pu_TH = Pu(1);
Pu_X  = Pu(2);

%% 2. eigenvalues of Ad(Au), stability of downward(upward) configuration

% eigenvalues
eigd = eig(Ad);
eigu = eig(Au);
eigu = complex(eigu);

% plot
% figure;
% subplot(2,1,1);
% grid on;
% plot(eigd,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Eigenvalues of Ad');
% subplot(2,1,2);
% grid on;
% plot(eigu,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Eigenvalues of Au');

%% 3a. poles and zeros of FDTs (from u to TH)

% Pd_TH
pd_TH = pole(Pd_TH);
pd_TH = complex(pd_TH);

% Pu_TH
pu_TH = pole(Pu_TH);
pu_TH = complex(pu_TH);

% plot
% figure;
% subplot(2,1,1);
% grid on;
% plot(pd_TH,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Poles of Pd_TH');
% subplot(2,1,2);
% grid on;
% plot(pu_TH,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Poles of Pu_TH');

%% 3b. poles and zeros of FDTs (from u to X)

% Pd_X
pd_X = pole(Pd_X);
pd_X = complex(pd_X);

% Pu_X
pu_X = pole(Pu_X);
pu_X = complex(pu_X);

% plot
% figure;
% subplot(2,1,1);
% grid on;
% plot(pd_X,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Poles of Pd_X');
% subplot(2,1,2);
% grid on;
% plot(pu_X,'x');
% xlabel('Real axis');
% ylabel('Imaginary axis');
% title('Poles of Pu_X');

%% 4. comparison between models
ic_c = [0;0;pi/8;0];
ic_f = [0;0;pi*7/8;0];
t = 0:0.001:10;
u = zeros(size(t));

% upward
yu = lsim(Su,u,t,ic_c);
THu = yu(:,1);
Xu = yu(:,2);

% figure;
% subplot(1,2,1);
% grid on;
% plot(t,Xu);
% xlabel('Time [s]');
% ylabel('C. position [m]');
% title('Su with IC=[0,0,pi/8,0]^T');
% 
% subplot(1,2,2);
% grid on;
% plot(t,THu*rad2deg);
% xlabel('Time [s]');
% ylabel('P. position [deg]');

% downward
yd = lsim(Sd,u,t,ic_f);
THd = yd(:,1);
Xd = yd(:,2);

% figure;
% subplot(1,2,1);
% grid on;
% plot(t,Xd);
% xlabel('Time [s]');
% ylabel('C. position [m]');
% title('Sd with IC=[0,0,pi*7/8,0]^T');
% 
% subplot(1,2,2);
% grid on;
% plot(t,THd*rad2deg);
% xlabel('Time [s]');
% ylabel('P. position [deg]');

%% 5. as.stability of S1d new system with F = -K*x (K = [k,0,0,0])
k = 10;
K = [k,0,0,0];
A1d = Ad - Bd*K;
B1d = zeros(size(Bd));
C1d = Cd;
D1d = zeros(size(Dd));
S1d = ss(A1d,B1d,C1d,D1d);

% eigenvalues
eig1d = eig(A1d);

% plot
figure;
grid on;
plot(eig1d,'x');
xlabel('Real axis');
ylabel('Imaginary axis');
title('Eigenvalues of A1d');
