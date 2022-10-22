%% Inizializzazione dell'ambiente
clearvars
close all
clc

load audio.mat % Carica il vettore x_t e la frequenza F

%{
    N_t: lunghezza del vettore x_t
    T: periodo di campionamento [s]
    t_t: istanti di tempo in cui è campionato il segnale x_t [s]
    B: larghezza della banda monolatera del segnale x [Hz]
       (massima frequenza udibile dall'orecchio umano)
%}

N_t = length(x_t);
T = 1 / F;
t_t = T * (0:N_t - 1);
B = 20000;

%% Q1) Grafici del segnale dato e della sua trasformata di Fourier
%{
    X_t: trasformata di Fourier del segnale x_t
    f_t: vettore di frequenze nell'intervallo [-1/2 * F, 1/2 * F) [Hz]
%}

X_t = fftshift(T * fft(x_t));
f_t = F / N_t * (-N_t/2:N_t/2 - 1);

figure(1)
plot(t_t, x_t)
title("Grafico di $x_{t}(t)$",'Interpreter','Latex')
xlabel("time (s)",'Interpreter','Latex')
ylabel("$x_{t}(t)$",'Interpreter','Latex')
grid on
grid minor

figure(2)
plot(f_t, abs(X_t))
title("Grafico di $|X_{t}(f)|$",'Interpreter','Latex')
xlabel("frequency (Hz)",'Interpreter','Latex')
ylabel("$|X_{t}(f)|$",'Interpreter','Latex')
grid on
grid minor

%% Q2) Demodulazione del segnale e ascolto
%{
    Fm: frequenza di modulazione [Hz]
    x: segnale x_t demodulato
%}

Fm = 40000;

x = demodulation(x_t, T, Fm, B, t_t, f_t);

player1 = audioplayer(x, F);
play(player1);

%% Q4) Filtraggio del segnale modulato
%{
    F_filter1, F_filter2: frequenze dei due picchi da eliminare [Hz]
    Hnf1, Hnf2: notch filter
    x_t_nffilt: segnale x_t filtrato con i due notch filter
%}

F_filter1 = 31700;
F_filter2 = 34750;

Hnf1 = NF_design(T, F_filter1);
Hnf2 = NF_design(T, F_filter2);

x_t_nffilt = filter(Hnf1, x_t);
x_t_nffilt = filter(Hnf2, x_t_nffilt);

%% Q5) Demodulazione del segnale filtrato e ascolto
%{
    Fm: frequenza di modulazione [Hz] (vedi passo Q2)
    x_nffilt: segnale x_t_nffilt demodulato
%}

x_nffilt = demodulation(x_t_nffilt, T, Fm, B, t_t, f_t);

player2 = audioplayer(x_nffilt, F);
play(player2);

%% Q6) Campionamento del segnale demodulato e ascolto
%{
    x: segnale demodulato (vedi passo Q2)
    Fc: frequenza alla quale campionare x [Hz]
    xc: segnale x campionato alla frequenza Fc
%}

Fc = 29400;

% essendo Fc = F / 6, l'operazione di campionamento 
% equivale a prendere un campione ogni 6
xc = x(1:6:length(t_t));

player3 = audioplayer(xc, Fc);
play(player3)

%% Q7) Filtraggio del segnale x_nffilt
%{
    Fst: frequenza di taglio per il filtro passa-basso [Hz]
    Hlp: filtro passa-basso alla frequenza Fst
    x_nffilt: segnale x_t filtrato con i due notch filter 
              e demodulato (vedi passo Q5) 
    x_nffilt_lpfilt: segnale x_nffilt filtrato con il filtro passa-basso
%}

Fst = 14650;

Hlp = LPF_design(T, Fst);
x_nffilt_lpfilt = filter(Hlp, x_nffilt);

%% Q7) Campionamento del nuovo segnale filtrato
%{
    xc_hat: segnale x_nffilt_lpfilt campionato alla frequenza Fc 
%}

% essendo Fc = F / 6, l'operazione di campionamento 
% equivale a prendere un campione ogni 6
xc_hat = x_nffilt_lpfilt(1:6:length(t_t));

player4 = audioplayer(xc_hat, Fc);
play(player4)

%% Q8) Confronto tra trasformate di Fourier di xc e xc_hat
%{
    Tc: periodo di campionamento dei due segnali [s]
    Nc: lunghezza del vettore xc
    fc: vettore di frequenze nell'intervallo [-1/2 * Fc, 1/2 * Fc) [Hz]
    Xc: trasformata di Fourier di xc
    Xc_hat: trasformata di Fourier di xc_hat
%}

Tc = 1 / Fc;

Nc = length(xc);
Xc = fftshift(Tc * fft(xc));
Xc_hat = fftshift(Tc * fft(xc_hat));
fc = Fc / Nc * (-Nc/2:Nc/2 - 1);

figure(7)
plot(fc, abs(Xc))
title("Grafico di $|X_{c}(f)|$",'Interpreter','Latex')
xlabel("frequency (Hz)",'Interpreter','Latex')
ylabel("$|X_{c}(f)|$",'Interpreter','Latex')
grid on
grid minor

figure(8)
plot(fc, abs(Xc_hat))
title("Grafico di $|\hat{X}_{c}(f)|$",'Interpreter','Latex')
xlabel("frequency (Hz)",'Interpreter','Latex')
ylabel("$|\hat{X}_{c}(f)|$",'Interpreter','Latex')
grid on
grid minor

%% Funzioni utili
% funzione finestra rettangolare
% t: vettore di istanti temporali
% T: numero reale non nullo
% y: rect(t/T)
% nei punti di discontinuità vale 0.5
function y = rect(t, T) 
    y = 1 * double(abs(t) < 0.5 * T) + 0.5 * double(abs(t) == 0.5 * T);
end

% funzione demodulatrice
% x: segnale da demodulare
% T: periodo di campionamento, inverso della frequenza di campionamento
% Fm: frequenza di modulazione
% B: larghezza di banda monolatera
% t: vettore di istanti temporali
% f: vettore di frequenze
% xdm: segnale x demodulato
% Xdm: trasformata di Fourier del segnale xdm
function xdm = demodulation(x, T, Fm, B, t, f)
    xdm = 2 * x .* cos(2 * pi * Fm * t);
    Xdm = fftshift(T * fft(xdm)) .* rect(f, 2 * B);
    xdm = ifft(ifftshift(Xdm) / T);
end
