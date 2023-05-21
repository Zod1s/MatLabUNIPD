%% Initialisation
clc
clear
close all

% re-evaluate intervals for ia

%% Parameters
load('params.mat')
load('responses.mat')

%% Plotting results
figure(1)
subplot(2, 3, 1)
hold on
grid on
plot(stair_resp_pos.time, stair_resp_pos.signals(3).values)
ylabel("$u$ [V]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 2)
hold on
grid on
plot(stair_resp_pos.time, stair_resp_pos.signals(4).values, "--")
plot(stair_resp_pos.time, stair_resp_pos.signals(1).values)
ylabel("$\omega_{l}$ [rpm]", "Interpreter", "latex")
legend("measured", "reference")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 3)
hold on
grid on
plot(stair_resp_pos.time, stair_resp_pos.signals(2).values)
ylabel("$e$ [rpm]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 4)
hold on
grid on
plot(stair_resp_pos.time, stair_resp_pos.signals(6).values)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

subplot(2, 3, 5)
hold on
grid on
plot(stair_resp_pos.time, stair_resp_pos.signals(5).values)
ylabel("$\theta$ [deg]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

% Overshoot specification is not satisfied due to the fact that it was
% designed based on a semplification of the real dinamics, so it is an
% approximation of its behaviour.

%% DATA STRUCTURE
% 1 -> wl_star
% 2 -> e
% 3 -> u
% 4 -> w
% 5 -> th
% 6 -> ia

%% Setting up signal transformations
s = tf('s');
wc = 2 * pi * 20;
d = 1 / sqrt(2);
Ts = 0.001;
Hc = wc^2 / (s^2 + 2 * d * wc * s + wc^2);
Hd = c2d(Hc, Ts, 'tustin');
[numHd, denHd] = tfdata(Hd, 'v');

%% Evaluating intervals
figure(2)
hold on
grid on
plot(stair_resp_neg.time, ia_neg)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Creating the matrix of positive regressors for wl and tsf
w_pos = (1:9) * 50 * rpm2rads;
t_pos = sign(w_pos) / gbox.N;
phi_pos = [w_pos; t_pos]'; % Matrix of regressors

%% Calculating positive current
ia_pos = filter(numHd, denHd, stair_resp_pos.signals(6).values);

intervals_ia_pos = [
    [   1  4.5],
    [   7  9.5],
    [  12   15],
    [16.5   20],
    [  21 24.5],
    [25.5   30],
    [  31 34.5],
    [35.5   40],
    [40.5   45]
];

intervals_ia_pos = intervals_ia_pos / Ts + 1;

ia_avg_pos = zeros(9, 1);
for i = 1:9
    ia_avg_pos(i) = mean(ia_pos(intervals_ia_pos(i, 1):intervals_ia_pos(i, 2)));
end

%% Finding positive values
est_pos = phi_pos\ia_avg_pos;
B_pos = est_pos(1);
tsf_pos = est_pos(2);

%% Creating the matrix of positive regressors for wl and tsf
w_neg = -(1:9) * 50 * rpm2rads;
t_neg = sign(w_neg) / gbox.N;
phi_neg = [w_neg; t_neg]'; % Matrix of regressors

%% Calculating negative current
ia_neg = filter(numHd, denHd, stair_resp_neg.signals(6).values);

intervals_ia_neg = [
    [ 2.5  4.5],
    [   7   10],
    [  11   15],
    [16.5   20],
    [22.5   25],
    [27.5   30],
    [  32 34.5],
    [35.5   40],
    [40.5   45]
];

intervals_ia_neg = intervals_ia_neg / Ts + 1;

ia_avg_neg = zeros(9, 1);
for i = 1:9
    ia_avg_neg(i) = mean(ia_neg(intervals_ia_neg(i, 1):intervals_ia_neg(i, 2)));
end

%% Finding negative values
est_neg = phi_neg\ia_avg_neg;
B_neg = est_neg(1);
tsf_neg = est_neg(2);

%% Average estimations
B_est = (B_pos + B_neg) / 2;
tsf_est = (abs(tsf_pos) + abs(tsf_neg)) / 2;

%% Plotting results
figure(3)
hold on
grid on
scatter((1:9) * 50 * rpm2rads, ia_avg_pos)
wm_pos = (50:0.01:450) * rpm2rads;
tau_pos = B_est * wm_pos + tsf_est / gbox.N;
plot(wm_pos, tau_pos)
scatter(-(1:9) * 50 * rpm2rads, ia_avg_neg)
wm_neg = -(50:0.01:450) * rpm2rads;
tau_neg = B_est * wm_neg - tsf_est / gbox.N;
plot(wm_neg, tau_neg)



