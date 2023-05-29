%% Initialisation
clc
clear
close all

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
Beq = 1.1085e-6; % [Nm/(rad/s)]
tausf = 0.0097; % [Nm]

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

%% Plotting al
figure(4)
hold on
grid on
plot(triang_resp.time, al)
ylabel("$a_{l}$ [rad/$s^2$]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Plotting taui
figure(5)
hold on
grid on
plot(triang_resp.time, taui)
ylabel("$\tau_{i}$ [Nm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Average acceleration
intervals_al = [
    [ 0.17   0.97];
    [  1.1    1.9];
    [ 2.17   2.95];
    [  3.1    3.9];
    [ 4.16   4.95];
    [ 5.16   5.95];
    [ 6.15   6.94];
    [ 7.15   7.93];
    [ 8.17   8.92];
    [ 9.17   9.95];
    [10.14  10.94];
    [11.12  11.95];
    [12.13  12.92];
    [13.14  13.91];
    [14.14  14.96];
    [15.12  15.93];
    [16.17  16.93];
    [17.13  17.91];
    [18.24   18.9];
    [ 19.2  19.87]
];

intervals_al = int64(intervals_al / Ts + 1);

al_avg = zeros(20, 1);
for i = 1:20
    al_avg(i) = mean(al(intervals_al(i, 1):intervals_al(i, 2)));
end

am_avg = al_avg * gbox.N;

%% Average torque
intervals_taui = [
    [ 0.17   0.97];
    [  1.1    1.9];
    [ 2.17   2.95];
    [  3.1    3.9];
    [ 4.16   4.95];
    [ 5.16   5.95];
    [ 6.15   6.94];
    [ 7.15   7.93];
    [ 8.17   8.92];
    [ 9.17   9.95];
    [10.14  10.94];
    [11.12  11.95];
    [12.13  12.92];
    [13.14  13.91];
    [14.14  14.96];
    [15.12  15.93];
    [16.17  16.93];
    [17.13  17.91];
    [18.24   18.9];
    [ 19.2  19.87]
];

intervals_taui = int64(intervals_taui / Ts + 1);

taui_avg = zeros(20, 1);
for i = 1:20
    taui_avg(i) = mean(taui(intervals_taui(i, 1):intervals_taui(i, 2)));
end

%% Estimating J
P = 10;
Jest = 0;
for i = 0:(P - 1)
    Jest = Jest + (taui_avg(2 * i + 1) - taui_avg(2 * i + 2)) / (am_avg(2 * i + 1) - am_avg(2 * i + 2));
end
Jest = Jest / P;
