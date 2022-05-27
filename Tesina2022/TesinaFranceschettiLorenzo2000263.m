%% Initialization
clearvars
close all
clc

load audio.mat

N = length(x_t);
fc = F / N;
Tc = 1 / F;
t = Tc * (0:N - 1);

%% Signal plots
X = fftshift(Tc * fft(x_t));
f = fc * (-N/2:N/2 - 1);

figure(1)
plot(t, x_t)
figure(2)
plot(f, abs(X))

%% Demodulation
Fm = 40000;

xdm = x_t ./ cos(2 * pi * Fm * t);
player = audioplayer(xdm, F);

% Gli artefatti sonori sono causati dai picchi presenti nella
% trasformata di Fourier del segnale x_t, che introducono
% frequenze non presenti nel segnale originale.

%% Filtering the given signal
F_filter1 = 31700; % By inspection of the FT of x_t
F_filter2 = 34750; % By inspection of the FT of x_t
F_filter3 = 39825; % By inspection of the FT of x_t
F_filter4 = 40175; % By inspection of the FT of x_t

Hnf1 = NF_design(Tc, F_filter1);
Hnf2 = NF_design(Tc, F_filter2);
Hnf3 = NF_design(Tc, F_filter3);
Hnf4 = NF_design(Tc, F_filter4);
xfilt = filter(Hnf1, x_t);
xfilt = filter(Hnf2, xfilt);
xfilt = filter(Hnf3, xfilt);
xfilt = filter(Hnf4, xfilt);

%% Demodulating the filtered signal
Fm = 40000;
xdm = xfilt ./ cos(2 * pi * Fm * t);

%% Resampling the filtered signal
Fc = 29400;

tc = 1:6:length(t);
xc = xdm(tc);
player = audioplayer(xc, Fc);
% Gli artefatti sono probabilmente dovuti al fenomeno di aliasing
% in quanto la frequenza di campionamento Fc non è maggiore del doppio
% della banda monolatera del segnale

%% Refiltering the signal with a low-pass filter
% Uso una frequenza di taglio di Fst = 14600 in modo che Fc > 2 * Fst
Fc = 29400;

Fst = 14600;
Hlp = LPF_design(1 / Fc, Fst);
xfilt = filter(Hlp, xfilt);

%% Demodulating the low-pass-filtered signal
Fm = 40000;
xdm = xfilt ./ cos(2 * pi * Fm * t);

%% Resampling the low-pass-filtered signal
tc = 1:6:length(t);
xc = xdm(tc);
player = audioplayer(xc, Fc);
