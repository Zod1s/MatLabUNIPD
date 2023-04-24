%% script per risolvere l'equazione x^3+2x^2-tanx=a col metodo di Aitken a
%partire dal metodo di punto fisso con g(x)=arctan(x^3+2x^2-a)
clc
clear
close all

a = 0.564;
f = @(x) x^3 + 2 * x^2 - tan(x) - a;
g = @(x) atan(x^3 + 2 * x^2 - a);
dg = @(x) (x * (4 + 3 * x)) / (1 + (a - x^2 * (2 + x))^2);
ddg = @(x) -(2 * x^2 * (4 + 3 * x)^2 * (-a + x^2 * (2 + x)) + (-4 - 6 * x) ...
    * (1 + (a - x^2 * (2 + x))^2)) / (1 + (a - x^2 * (2 + x))^2)^2;
x0 = -0.5;
tol = 1e-8;
itmax = 100;
csi = fzero(f, x0);
[xvec, scarti, iter] = aitken(x0, g, tol, itmax);

xk = xvec(end);
MA = abs(ddg(xk) / 2) * abs(dg(xk) / (1 - dg(xk)));
errk = MA * abs(scarti(end)^2);
fprintf('\n\nnumero iterazioni      soluzione finale        approssimazione M       stima erorre        errore vero\n');
fprintf('               %i           %10.9f              %10.9f       %10.6e       %10.6e\n',iter,xk,MA,errk,(xvec(end)-csi));
