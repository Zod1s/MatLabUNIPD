f0 = 20;
a = -10;
t = -0.25:0.0001:0.25;
s = exp((a + 2 * pi * 1i * f0) * t);
figure
subplot(2, 2, 1);
plot(t, real(s));
grid on
xlabel('t'); ylabel('Real');

subplot(2, 2, 2);
plot(t, imag(s));
grid on
xlabel('t'); ylabel('Imag');

subplot(2, 2, 3);
plot(t, abs(s));
grid on
xlabel('t'); ylabel('Modulus');

subplot(2, 2, 4);
plot(t, angle(s));
grid on
xlabel('t'); ylabel('Phase');
