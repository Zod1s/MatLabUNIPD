%% Inizializzazione
clearvars
close all
clc

load audio.mat

%{
N_t: lunghezza del vettore x_t
T: periodo di campionamento
t_t: istanti di tempo in cui è campionato il segnale x_t
B: banda monolatera del segnale x, 
   massima frequenza udibile dall'orecchio umano
graphs: flag per mostrare i grafici
        - 0 per riprodurre le tracce audio
        - 1 per mostrare i grafici relativi
%}

N_t = length(x_t);
T = 1 / F;
t_t = T * (0:N_t - 1);
B = 20000;

graphs = 0;

%% Grafici del segnale dato e della sua trasformata di Fourier
%{
X_t: trasformata di Fourier del segnale x_t
f_t: vettore di frequenze nel periodo [-1/(2 * T), 1/(2 * T))
%}

X_t = fftshift(T * fft(x_t));
f_t = F / N_t * (-N_t/2:N_t/2 - 1);

figure(1)
plot(t_t, x_t)
xlabel("time (s)")
ylabel("x_{t}(t)")
grid on
grid minor

figure(2)
plot(f_t, abs(X_t))
xlabel("frequency (Hz)")
ylabel("|X_{t}(f)|")
grid on
grid minor

%% Demodulazione del segnale modulato
%{
Fm: frequenza di modulazione
x: segnale x_t demodulato
X: trasformata del segnale x
%}

Fm = 40000;

[x, X] = demodulation(x_t, T, Fm, B, t_t, f_t);

if graphs
    figure(3)
    subplot(211)
    plot(t_t, x)
    xlabel("time (s)")
    ylabel("x(t)")
    grid on
    grid minor
    subplot(212)
    plot(f_t, abs(X))
    xlabel("frequency (Hz)")
    ylabel("|X(f)|")
    grid on
    grid minor
else
    player1 = audioplayer(x, F);
    play(player1);
end

% Gli artefatti sonori sono causati dai picchi presenti nella
% trasformata di Fourier del segnale, che introducono
% frequenze non presenti nel segnale originale.

%% Filtraggio del segnale modulato
%{
F_filter1, F_filter2: frequenze dei due picchi da eliminare
Hnf1, Hnf2: notch filter
x_t_nffilt: segnale x_t filtrato con i due notch filter
%}

F_filter1 = 31700;
F_filter2 = 34750;

Hnf1 = NF_design(T, F_filter1);
Hnf2 = NF_design(T, F_filter2);
x_t_nffilt = filter(Hnf1, x_t);
x_t_nffilt = filter(Hnf2, x_t_nffilt);

%% Demodulazione del segnale filtrato
%{
x_nffilt: segnale x_t_nffilt demodulato
X_nffilt: trasformata di Fourier di x_nffilt
%}

[x_nffilt, X_nffilt] = demodulation(x_t_nffilt, T, Fm, B, t_t, f_t);

if graphs
    figure(4)
    subplot(211)
    plot(t_t, x_nffilt)
    xlabel("time (s)")
    ylabel("x_{filtdm}(t)")
    grid on
    grid minor
    subplot(212)
    plot(f_t, abs(X_nffilt))
    xlabel("frequency (Hz)")
    ylabel("|X_{filtdm}(f)|")
    grid on
    grid minor
else
    player2 = audioplayer(x_nffilt, F);
    play(player2);
end

%% Campionamento del segnale demodulato
%{
Fc: frequenza alla quale campionare x_t
xc: segnale x_nffilt campionato alla frequenza Fc
%}

Fc = 29400;

xc = x_nffilt(1:6:length(t_t));

if ~graphs
    player3 = audioplayer(xc, Fc);
    play(player3)
end

%% Filtraggio del segnale x_nffilt
%{
Fst: frequenza di taglio per il filtro passa-basso
Hlp: filtro passa-basso alla frequenza Fst
x_nffilt_lpfilt: segnale x_nffilt filtrato con il filtro passa-basso
%}

Fst = 14600;

Hlp = LPF_design(T, Fst);
x_nffilt_lpfilt = filter(Hlp, x_nffilt);

%% Campionamento del nuovo segnale filtrato
%{
xc_hat: segnale x_nffilt_lpfilt campionato alla frequenza Fc 
%}

xc_hat = x_nffilt_lpfilt(1:6:length(t_t));

if ~graphs
    player4 = audioplayer(xc_hat, Fc);
    play(player4)
end

%% Confronto tra trasformate di Fourier di xc e xc_hat
%{
Tc: periodo di campionamento dei due segnali
Nc: lunghezza del vettore xc
fc: vettore di frequenze nel periodo [-1/(2 * Tc), 1/(2 * Tc))
Xc: trasformata di Fourier di xc
Xc_hat: trasformata di Fourier di xc_hat
%}

Tc = 1 / Fc;

Nc = length(xc);
Xc = fftshift(Tc * fft(xc));
Xc_hat = fftshift(Tc * fft(xc_hat));
fc = Fc / Nc * (-Nc/2:Nc/2 - 1);

figure(5)
plot(fc, log10(abs(Xc)))
xlabel("frequency (Hz)")
ylabel("|X_{c}(f)|")
grid on
grid minor

figure(6)
plot(fc, log(abs(Xc_hat)))
xlabel("frequency (Hz)")
ylabel("|X^\^_{c}(f)|")
grid on
grid minor

%% Utilities
function rect = rect(t, T) 
    rect = 1 * double(abs(t) < 0.5 * T) + 0.5 * double(abs(t) == 0.5 * T);
end

function [xdm, Xdm] = demodulation(x, T, Fm, B, t, f)
    xdm = 2 * x .* cos(2 * pi * Fm * t);
    Xdm = fftshift(T * fft(xdm)) .* rect(f, 2 * B);
    xdm = ifft(ifftshift(Xdm) / T);
end
