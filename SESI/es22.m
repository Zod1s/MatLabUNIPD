clearvars
close all
clc

Tp = 20;
To = 10;
R = 150;
C = 0.01;

T = 1e-4;
t = -20:T:20;
x = rep_rect(t, To, Tp);
y = zeros(1, length(t));
N = 500;
for k=-N:N
    y = y + ak(k, To, Tp) * H(wk(k, Tp), R, C) * exp(1j * wk(k, Tp) * t);
end
xn = zeros(1, length(t));
for k=-N:N
    xn = xn + ak(k, To, Tp) * exp(1j * wk(k, Tp) * t);
end
figure(1)
hold on
plot(t, xn);
plot(t, y);
legend('fourier sinput', 'fourier output')

function a = ak(k, To, Tp)
    a = To / Tp * sinc(To / Tp * k);
end

function s = sinc(x)    
    s = sin(pi * x) ./ (pi * x);
    s(x == 0) = 1;
end

function r = rect(t, To)
    r = abs(t / To) <= 0.5;
end

function g = rep_rect(t, To, Tp) 
    n = length(t);
    g = zeros(1,n);
    N = 10;
    
    for k = -N:N
        g = g+rect(t-k*Tp, To);
    end
end

function h = H(w, R, C)
    h = 1 / (1 + 1j * w * R * C);
end

function w = wk(k, Tp)
    w = 2 * pi * k / Tp;
end
