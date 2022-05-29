%% Initialization
clearvars
close all
clc

load audio.mat

N = length(x_t);
T = 1 / F;
t = T * (0:N - 1);

%% Signal plots
X = fftshift(T * fft(x_t));
fc = F / N;
f = fc * (-N/2:N/2 - 1);

figure(1)
subplot(211)
plot(t, x_t)
xlabel("time (s)")
ylabel("x_{t}(t)")
subplot(212)
plot(f, abs(X))
xlabel("frequency (Hz)")
ylabel("|X_{t}(f)|")

%% Demodulation
Fm = 40000;

xdm = x_t ./ cos(2 * pi * Fm * t);
player = audioplayer(xdm, F);
play(player);

% Ricontrolla come fare la demodulazione
% Gli artefatti sonori sono causati dai picchi presenti nella
% trasformata di Fourier del segnale x_t, che introducono
% frequenze non presenti nel segnale originale.

%% Filtering the given signal
F_filter1 = 31700; % By inspection of the FT of x_t
F_filter2 = 34750; % By inspection of the FT of x_t

Hnf1 = NF_design(T, F_filter1);
Hnf2 = NF_design(T, F_filter2);
xfilt = filter(Hnf1, x_t);
xfilt = filter(Hnf2, xfilt);

% Xfilt = fftshift(T * fft(xfilt));
% figure(2)
% plot(f, abs(Xfilt))
% xlabel("frequency (Hz)")
% ylabel("|X_{filt}|")

%% Demodulating the filtered signal
Fm = 40000;

xfiltdm = xfilt ./ cos(2 * pi * Fm * t);
player = audioplayer(xfiltdm, F);
play(player);

%% Resampling the demodulated signal
Fc = 29400;

tc = 1:6:length(t);
xc = xdm(tc);
player = audioplayer(xc, Fc);
play(player);

% Gli artefatti sono probabilmente dovuti al fenomeno di aliasing
% in quanto la frequenza di campionamento Fc non è maggiore del doppio
% della banda monolatera del segnale

% Xc = fftshift(fft(xc) / Fc);
% f1 = Fc * (-length(xc)/2:length(xc)/2 - 1) / length(xc);
% figure(4)
% plot(f1, abs(Xc))

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
