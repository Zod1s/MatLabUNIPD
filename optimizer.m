%% Initialization
clc;
close all;
clear all;

%% Constanst
B = 100000;
V0 = 1;
R0 = V0^2 / (12 * B);

lb = [0, 0];
ub = [1000, 10 * B];

%% Optimizer

%% Function
phi = @(Fs, L) Fs * log2(L);

%% Optimization
