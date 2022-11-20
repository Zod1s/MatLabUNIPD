clear all;
close all;
clc;

%% Design the filter using Hamming window method
M = 21;
a = (M - 1) / 2;
h = zeros(1, M);
for i = 0:M - 1
    h(i + 1) = g(i, a);
end
hh = hamming(1, M) .* h;

%% Plot the Ideal Impulse Response, Hamming Window and Actual
figure(1)
plot(h, '.')

figure(2)
plot(hh, '.')

%% Window Response


%% Create the signal which will be filtered
t = -10:0.1:10;
x = cos(t);

%% Filtered the signal and remove delay
yf = filter(h, 1, x);

%% Compute the expected derivative
ye = -sin(t);
figure(1)
hold on
plot(t, yf)
plot(t, ye)

%% Utilities
function h = g(n, a)
    if n == a
        h = 0;
    else
        h = cos(pi * (n - a)) / (n - a);
    end
end
