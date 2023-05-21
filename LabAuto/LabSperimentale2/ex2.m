%% Initialisation
clc
clear
close all

% re-evaluate Beq and tausf from ex1 after changing time intervals

%% DATA STRUCTURE
% 1 -> wl_star
% 2 -> e
% 3 -> u
% 4 -> w
% 5 -> th
% 6 -> ia

%% Parameters
load('params.mat')
load('responses.mat')
Beq = 0.0022; %[Nm / (rad/s)]
tausf = 1.1691; % [Nm]

%% Setting up signal transformations
s = tf('s');
wc = 2 * pi * 20;
d = 1 / sqrt(2);
Ts = 0.001;
Hcal = wc^2 * s / (s^2 + 2 * d * wc * s + wc^2);
Hdal = c2d(Hcal, Ts, 'tustin');
Hcia = wc^2 / (s^2 + 2 * d * wc * s + wc^2);
Hdia = c2d(Hcia, Ts, 'tustin');
[numHdal, denHdal] = tfdata(Hdal, 'v');
[numHdia, denHdia] = tfdata(Hdia, 'v');

%% Obtaining acceleration from speed measurement and current
wl = triang_resp.signals(4).values * rpm2rads;
al = filter(numHdal, denHdal, wl);
ia = filter(numHdia, denHdia, triang_resp.signals(6).values);

%% Evaluating intervals
figure(1)
hold on
grid on
plot(triang_resp.time, wl)
ylabel("$w_{l}$ [rad/s]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

figure(2)
hold on
grid on
plot(triang_resp.time, al)
ylabel("$a_{l}$ [rad/$s^2$]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

figure(3)
hold on
grid on
plot(triang_resp.time, ia)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Calculating torque
tauf = Beq * wl * gbox.N + tausf * sign(wl) / gbox.N;
taum = mot.Kt * ia;
taui = taum - tauf;

%% Average acceleration

intervals_al = [
    [   0    1],
    [   1    2],
    [   2    3],
    [   3    4],
    [   4    5],
    [   5    6],
    [   6    7],
    [   7    8],
    [   8    9],
    [  10   11],
    [  11   12],
    [  10   11],
    [  11   12],
    [  12   13],
    [  13   14],
    [  14   15],
    [  15   16],
    [  16   17],
    [  17   18],
    [  18   19],
    [  19   20],
];

intervals_al = intervals_al / Ts + 1;

al_avg = zeros(20, 1);
for i = 1:20
    al_avg(i) = mean(al((i - 1) / Ts + 1:i / Ts + 1));
end

am_avg = al_avg * gbox.N;




