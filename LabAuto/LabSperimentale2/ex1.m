%% Initialisation
clc
clear
close all

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
plot(w_pos.time, w_pos.data)
ylabel("$i_{a}$ [A]", "Interpreter", "latex")
xlabel("$t$ [s]", "Interpreter", "latex")

%% Creating the matrix of positive regressors for wl and tsf
intervals_wl_pos = [
    [ 0.3  4.7];
    [ 5.3  9.8];
    [10.3 14.7];
    [15.5 19.8];
    [20.4 24.7];
    [25.5 29.7];
    [30.5 34.7];
    [35.5 39.7];
    [40.5   45]
];

intervals_wl_pos = int64(intervals_wl_pos / Ts + 1);

wl_pos = stair_resp_pos.signals(4).values; % [rpm]
% wl_pos = w_pos.data;

wl_avg_pos = zeros(9, 1);
for i = 1:9
    wl_avg_pos(i) = mean(wl_pos(intervals_wl_pos(i, 1):intervals_wl_pos(i, 2)));
end

wm_pos = gbox.N * wl_avg_pos * rpm2rads; % [rad/s]
tau_pos = sign(wm_pos) / gbox.N;
phi_pos = [wm_pos, tau_pos];

%% Calculating positive current
ia_pos = filter(numHd, denHd, stair_resp_pos.signals(6).values);
% ia_pos_data = filter(numHd, denHd, ia_pos.data);

intervals_ia_pos = [
    [ 0.5  4.6];
    [ 5.6  9.8];
    [10.3 14.7];
    [15.2 19.6];
    [20.2 24.7];
    [25.5 29.6];
    [30.5 34.7];
    [35.5 39.7];
    [40.5   45]
];

intervals_ia_pos = int64(intervals_ia_pos / Ts + 1);

ia_avg_pos = zeros(9, 1);
for i = 1:9
    ia_avg_pos(i) = mean(ia_pos(intervals_ia_pos(i, 1):intervals_ia_pos(i, 2)));
end

taum_pos = mot.Kt * ia_avg_pos; % [Nm]

%% Finding positive values
est_pos = phi_pos\taum_pos;
Beq_pos = est_pos(1);
tsf_pos = est_pos(2);

%% Creating the matrix of positive regressors for wl and tsf
intervals_wl_neg = [
    [ 0.3  4.7];
    [ 5.3  9.8];
    [10.3 14.7];
    [15.5 19.8];
    [20.4 24.7];
    [25.5 29.7];
    [30.5 34.7];
    [35.5 39.7];
    [40.5   45]
];

intervals_wl_neg = int64(intervals_wl_neg / Ts + 1);

wl_neg = stair_resp_neg.signals(4).values;
% wl_neg = w_neg.data;

wl_avg_neg = zeros(9, 1);
for i = 1:9
    wl_avg_neg(i) = mean(wl_neg(intervals_wl_neg(i, 1):intervals_wl_neg(i, 2)));
end

wm_neg = gbox.N * wl_avg_neg * rpm2rads;
tau_neg = sign(wm_neg) / gbox.N;
phi_neg = [wm_neg, tau_neg];

%% Calculating positive current
ia_neg = filter(numHd, denHd, stair_resp_neg.signals(6).values);
% ia_neg_data = filter(numHd, denHd, ia_neg.data);

intervals_ia_neg = [
    [ 0.5  4.6];
    [ 5.6  9.8];
    [10.3 14.7];
    [15.2 19.6];
    [20.2 24.7];
    [25.5 29.6];
    [30.5 34.7];
    [35.5 39.7];
    [40.5   45]
];

intervals_ia_neg = int64(intervals_ia_neg / Ts + 1);

ia_avg_neg = zeros(9, 1);
for i = 1:9
    ia_avg_neg(i) = mean(ia_neg(intervals_ia_neg(i, 1):intervals_ia_neg(i, 2)));
end

taum_neg = mot.Kt * ia_avg_neg;

%% Finding negative values
est_neg = phi_neg\taum_neg;
Beq_neg = est_neg(1);
tsf_neg = est_neg(2);

%% Average estimations
Beq_est = (Beq_pos + Beq_neg) / 2;
tsf_est = (abs(tsf_pos) + abs(tsf_neg)) / 2;

%% Plotting results
figure(3)
hold on
grid on
scatter(wm_pos, taum_pos)
tau_pos = Beq_est * wm_pos + tsf_est / gbox.N;
plot(wm_pos, tau_pos)
scatter(wm_neg, taum_neg)
tau_neg = Beq_est * wm_neg - tsf_est / gbox.N;
plot(wm_neg, tau_neg)
