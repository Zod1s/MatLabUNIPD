a = 3;
b = 3;
t = -10:0.1:10;
figure

subplot(3, 1, 1);
hold on

plot(t, tanh(t));
plot(t, tanh(t - b));
plot(t, tanh(t + b));

legend('s(t)', 's(t - b)', 's(t + b)')

grid on

subplot(3, 1, 2);
hold on

plot(t, tanh(t));
plot(t, tanh(a * t));
plot(t, tanh(t / a));

legend('s(t)', 's(a * t)', 's(t / a)')

grid on

subplot(3, 1, 3);
hold on

plot(t, tanh(t));
plot(t, tanh(a * t - b));
plot(t, tanh(a * t + b));
plot(t, tanh(t / a - b));
plot(t, tanh(t / a + b));

legend('s(t)', 's(a * t - b)', 's(a * t + b)', 's(t / a - b)', 's(t / a + b)')

grid on