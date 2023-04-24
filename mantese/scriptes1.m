%% questo script risolve l'equazione x^3 + 2x^2 - tanx = 0.564 con vari metodi
%  iterativi numero di matricola = 2069264;
%  z = 264; a = 0.3 + z * 0.001 = 0.564
clc
clear
close all

a = 0.564;
f = @(x) x^3 + 2 * x^2 - tan(x) - a;

%% preparo i grafici
f0 = figure('Name', 'grafico funzione f', 'NumberTitle', 'off');
f1 = figure('Name', 'grafico csi1', 'NumberTitle', 'off');
f2 = figure('Name', 'grafico csi2', 'NumberTitle', 'off');
f3 = figure('Name', 'grafico csi3', 'NumberTitle', 'off');

%% traccio il grafico della funzione
figure(f0)
ezplot(f, [-1 1.5]);
hold on
plot([-1 1.5] , [0 0],'r-');
hold off

%% verifico l'esistenza delle soluzioni tramite il teorema di Bolzano
% e comunico tali soluzioni a terminale
if f(-1) * f(0) <= 0
    csi1 = fzero(f, -0.5);
    fprintf('esiste una soluzione tra -1 e 0, ed è uguale a %3.5f \n',csi1);
end
if f(0.5) * f(1.2) <= 0
    csi2 = fzero(f, 0.85);
    fprintf('esiste una soluzione tra 0.5 e 1.2, ed è uguale a %3.5f \n',csi2);
end
if f(1.2) * f(1.5) <= 0
    csi3 = fzero(f, 1.35);
    fprintf('esiste una soluzione tra 1.2 e 1.5, ed è uguale a %3.5f \n',csi3);
end

%% approssimo le tre radici della funzione con Newton-Raphson e visualizzo
% i risultati

df = @(x) 3 * x^2 + 4 * x - (1 / cos(x)^2);
ddf = @(x) 6 * x + 4 - 2 * tan(x) * sec(x)^2;
tol = 1e-7;
itmax = 100;

%approssimo csi1

x0 = -0.5;
[xvec, scarti, iter] = newton(x0, f, df, tol, itmax);
MN = 0.5 * abs(ddf(xvec(end)) / df(xvec(end)));
errK = MN * (scarti(end)^2);
MatRisN = [iter, xvec(end), MN, errK, (csi1 - xvec(end))];

x1n = xvec(2); %valore salvato per il punto successivo

figure(f1) %plotto i dati sui grafici corrispondenti
semilogy(1:iter, scarti, 'or-')
hold on

%approssimo csi2

x0 = 0.85;
[xvec, scarti, iter] = newton(x0, f, df, tol, itmax);
MN = 0.5 * abs(ddf(xvec(end)) / df(xvec(end)));
errK = MN * (scarti(end)^2);
MatRisN = [MatRisN; iter, xvec(end), MN, errK, (csi2 - xvec(end))];

x2n = xvec(2);

figure(f2)
semilogy(1:iter, scarti, 'or-')
hold on

%approssimo csi3

x0 = 1.35;
[xvec, scarti, iter] = newton(x0, f, df, tol, itmax);
MN = 0.5 * abs(ddf(xvec(end)) / df(xvec(end)));
errK =MN * (scarti(end)^2);
MatRisN = [MatRisN; iter, xvec(end), MN, errK, (csi3 - xvec(end))];

figure(f3) 
semilogy(1:iter, scarti, 'or-')
hold on

clear x0 xvec scarti iter MN errK; 
%rimuovo variabili intermedie per non ingombrare il workspace


fprintf('\n\ncalcoli di Newton-Raphson');
fprintf('\n\nnumero iterazioni      soluzione finale        approssimazione M       stima erorre         errore vero\n');
fprintf('               %i           %10.9f              %10.9f       %10.6e        %10.6e\n', MatRisN(1, :));
fprintf('               %i            %10.9f              %10.9f       %10.6e       %10.6e\n', MatRisN(2, :));
fprintf('               %i            %10.9f              %10.9f       %10.6e       %10.6e\n', MatRisN(3, :));

%% approssimo csi1 e csi2 col metodo di steffensen e visualizzo i risultati

fprintf('\n\n\ncalcoli di Steffensen')
fprintf('\n\nnumero di iterazioni         soluzione finale\n');

%approssimo csi1
x0 = x1n;
clear x1n;
[xvec, scarti, iter] = steffensen(x0, f, tol, itmax);
fprintf('                %i               %10.9f\n', iter, xvec(end));

figure(f1) %plotto i dati sui grafici corrispondenti
semilogy(1:iter, scarti, 'sb-')
hold on

%approssimo csi2
x0 = x2n;
clear x2n;
[xvec, scarti, iter] = steffensen(x0, f, tol, itmax);
fprintf('                %i                %10.9f\n', iter, xvec(end));

figure(f2) 
semilogy(1:iter, scarti, 'sb-')

%% approssimo le tre radici della funzione con punto fisso e visualizzo i risultati
g = @(x) atan(x^3 + 2 * x^2 - a);
dg = @(x) (x * (4 + 3 * x)) / (1 + (-0.564 + 2 * x^2 + x^3)^2);
tol = 1e-12;
x0 = -0.5;

%verifico la convergenza di PF e poi calcolo
if abs(dg(csi1)) < 1
    [xvec, scarti, iter] = puntofisso(x0, g, tol, itmax);
    MPF = abs(dg(xvec(end)));
    errK = (dg(xvec(end)) / (1 - dg(xvec(end)))) * scarti(end);
    matRisPF = [iter, xvec(end), MPF, errK, (csi1 - xvec(end))];

    figure(f1) %plotto i dati sui grafici corrispondenti
    semilogy(1:iter, scarti, 'og-')
    legend({'convergenza di newton', 'convergenza di Steffensen', ...
        'convergenza di Punto Fisso'}, 'Location', 'northeast')
    hold on
else
    fprintf('\nil metodo di punto fisso non converge intorno a %3.5f\n', csi1);
    matRisPF = [0, 0, 0, 0, 0];
    figure(f1)
    legend({'convergenza di newton', 'convergenza di Steffensen'}, 'Location', ...
        'northeast')
    hold on
end

x0 = 0.85;

if abs(dg(csi2)) < 1
    [xvec, scarti, iter] = puntofisso(x0, g, tol, itmax);
    MPF = abs(dg(xvec(end)));
    errK = (dg(xvec(end)) / (1 - dg(xvec(end)))) * scarti(end);
    matRisPF = [matRisPF; iter, xvec(end), MPF, errK, (csi2 - xvec(end))];

    figure(f2) 
    semilogy(1:iter, scarti, 'og-')
    legend({'convergenza di newton', 'convergenza di Steffensen', ...
        'convergenza di Punto Fisso'}, 'Location', 'northeast')
    hold on
else
    fprintf('\nil metodo di punto fisso non converge intorno a %3.5f\n', csi2);
    matRisPF = [matRisPF; 0, 0, 0, 0, 0];
    figure(f2)
    legend({'convergenza di newton', 'convergenza di Steffensen'}, 'Location', ...
        'northeast')
    hold on
end

x0 = 1.35;

if abs(dg(csi3)) < 1
    [xvec, scarti, iter] = puntofisso(x0, g, tol, itmax);
    MPF = abs(dg(xvec(end)));
    errK = (dg(xvec(end)) / (1 - dg(xvec(end)))) * scarti(end);
    matRisPF = [matRisPF; iter, xvec(end), MPF, errK, (csi3 - xvec(end))];

    figure(f3) 
    semilogy(1:iter, scarti, 'og-')
    legend({'convergenza di newton', 'convergenza di Punto Fisso'}, 'Location', ...
        'northeast')
    hold off
else
    fprintf('\nil metodo di punto fisso non converge intorno a %3.5f\n', csi3);
    matRisPF=[matRisPF; 0, 0, 0, 0, 0];
    figure(f3)
    legend({'convergenza di newton', 'convergenza di Punto Fisso'}, 'Location', ...
        'northeast')
    hold off
end

fprintf('\n\ncalcoli di Punto Fisso');
fprintf('\n\nnumero iterazioni       soluzione finale        approssimazione M       stima erorre         errore vero\n');
fprintf('              %i           %10.9f              %10.9f       %10.6e        %10.6e\n', matRisPF(1, :));
fprintf('                %i            %10.9f              %10.9f       %10.6e        %10.6e\n', matRisPF(2, :));
fprintf('               %i            %10.9f              %10.9f       %10.6e        %10.6e\n', matRisPF(3, :));

clear MPF errK scarti xvec iter x0 itmax tol;

%% salvo i grafici su file

figure(f1);
print('grafico csi1', '-dpdf');
figure(f2);
print('grafico csi2', '-dpdf');
figure(f3);
print('grafico csi3', '-dpdf');