clearvars
close all
clc

a = 0.1;
b = 0.05;
I0 = 1;
N = 100;
I = zeros(N);
I(1) = I0;

for i = 2:N
    I(i) = next(a, b, Ps(i - 1), I(i - 1));
end

figure(1)
plot(1:N, I)

function n = next(a, b, ps, ik)
    n = ik * (1 + a * ps - b);
end

function ps = Ps(k)
    ps = 5 * sinc(k * pi / 50);
end

function y = sinc(x)
    y = sin(pi * x) / (pi * x);
    y(x == 0) = 1;
end