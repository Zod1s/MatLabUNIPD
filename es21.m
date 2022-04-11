clearvars
close all
clc

A = 1;
f = 1;
w = 2 * pi * f;
R = 150;
C = 0.01;

T = 1e-4;
t = -1:T:5;

x = A * cos(w * t) .* (t >= 0);
H = 1 / (1 + 1j * w * R * C);
yrp = abs(H) * A * cos(w * t + angle(H));
ytr = - (exp(-t ./ (R * C)) ./ (1 + (w * R * C) ^ 2));
y = yrp + ytr;

figure(1)
hold on
plot(t, y);
plot(t, yrp);
legend('y', 'yrp')