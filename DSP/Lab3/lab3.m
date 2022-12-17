%% Initialization
clc
clear all
close all

%% ZPLANE
zplane([1 2 1], [1 -0.8])

%% IMPZ
impz(1, [1 -0.9])

%% FREQZ1
freqz(1, [1 -0.9])

%% FREQZ3
freqz([1 0 0 0 0 0 0 0 -0.9^8], [1 -0.9])

%% FILTER
x = zeros(100, 1);
x(1, 1) = 1;
y = filter(1, [1 -0.9], x);
plot(y)

%% TF2ZP
[z, p, k] = tf2zp([1 2], [1 -0.8]);

%% ZP2TF
[b, a] = zp2tf(z, p, k);

%% ESERCIZIO 2.7-1
p = [0.5; 0.45 + 0.5*1j; 0.45 - 0.5*1j];
z = [-1; 1j; -1j];
k = 1;
[b, a] = zp2tf(z, p, k);
freqz(b, a);

%% ESERCIZIO 2.7-2
p0 = 0.9 * exp(0.1 * pi * 1j); 
p = [p0; conj(p0)];
z = [1 / p0; conj(1 / p0)];
[b, a] = zp2tf(z, p, 1);
freqz(b, a);

%% ESERCIZIO 2.7-3
x1 = [2, 3, 4];
x2 = [3, 4, 5, 6];

x = conv(x1, x2);
x

%% RESIDUEZ
[A, p, C] = residuez([0 1], [3 -4 1]);
impz([0 1], [3 -4 1])

%% ESERCIZIO 4.1
b = [0 1 -1.2 1];
a = [1 -1.3 1.04 -0.222];
freqz(b, a)
zplane(b, a)
[z, p, k] = tf2zp(b, a);
impz(b, a)

%% ESERCIZIO 4.2
b = [1 2];
a = [1 0.4 -0.12];
[r, p, k] = residuez(b, a);
n = 0:1:18;
h = -1.75 * (-0.6).^n + 2.75 * 0.2.^n;
x = [1 zeros(1, 17)];
y = filter(b, a, x);
figure(1)
impz(b, a)
figure(2)
stem(n, h)
figure(3)
stem(y)

%% ESERCIZIO 4.3
b = [0.15 0 -0.15];
a = [0.7 -0.5 1];
freqz(b, a)
zplane(b, a)



