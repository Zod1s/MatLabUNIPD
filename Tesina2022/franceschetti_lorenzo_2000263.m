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

[xdm, Xdm] = demodulation(x_t, T, Fm, t, f);
% figure(1)
% subplot(211)
% plot(t, xdm)
% xlabel("time (s)")
% ylabel("x_{dm}(t)")
% subplot(212)
% plot(f, abs(Xdm))
% xlabel("frequency (Hz)")
% ylabel("|X_{dm}(f)|")
player = audioplayer(xdm, F);
play(player);

% Gli artefatti sonori sono causati dai picchi presenti nella
% trasformata di Fourier del segnale, che introducono
% frequenze non presenti nel segnale originale.

%% Filtering the given signal
F_filter1 = 31700; % By inspection of the FT of x_t
F_filter2 = 34750; % By inspection of the FT of x_t

Hnf1 = NF_design(T, F_filter1);
Hnf2 = NF_design(T, F_filter2);
xfilt = filter(Hnf1, x_t);
xfilt = filter(Hnf2, xfilt);

%% Demodulating the filtered signal
Fm = 40000;

[xfiltdm, Xfiltdm] = demodulation(xfilt, T, Fm, t, f);
% figure(1)
% subplot(311)
% plot(t, xfiltdm)
% xlabel("time (s)")
% ylabel("x_{filtdm}(t)")
% subplot(312)
% plot(f, abs(Xfiltdm))
% xlabel("frequency (Hz)")
% ylabel("|X_{filtdm}(f)|")
% subplot(313)
% plot(f, abs(Xdm - Xfiltdm))
% xlabel("frequency (Hz)")
% ylabel("|X_{dm} - X_{filtdm}(f)|")
player = audioplayer(xfiltdm, F);
play(player);

%% Resampling the demodulated signal
Fc = 29400;

tc = 1:6:length(t);
x_c = xdm(tc);
player = audioplayer(x_c, Fc);
play(player)

% Gli artefatti sono probabilmente dovuti al fenomeno di aliasing
% in quanto la frequenza di campionamento Fc non è maggiore del doppio
% della banda monolatera del segnale

% Xc = fftshift(fft(xc) / Fc);
% f1 = Fc * (-length(xc)/2:length(xc)/2 - 1) / length(xc);
% figure(4)
% plot(f1, abs(Xc))

%% Refiltering the signal with a low-pass filter
% Uso una frequenza di taglio di Fst = 14600 in modo che Fc > 2 * Fst
Fst = 14600;

Hlp = LPF_design(1 / Fc, Fst);
xdmfilt = filter(Hlp, xdm);

%% Resampling the low-pass-filtered signal
tc = 1:6:length(t);
x_c_hat = xdm(tc);
player = audioplayer(x_c_hat, Fc);
play(player)

%% Fourier transforms of sampled signals
% ricontrollare
N = length(x_c);
X_c = fftshift(fft(x_c) / Fc);
X_c_hat = fftshift(fft(x_c_hat) / Fc);
f_c = Fc / N;
f = f_c * (-N/2:N/2 - 1);

subplot(211)
plot(f, abs(X_c))
xlabel("frequency (Hz)")
ylabel("|X_{c}(f)|")

subplot(212)
plot(f, abs(X_c_hat))
xlabel("frequency (Hz)")
ylabel("|\^{X}_{c}(f)|")

%% Utilities
function rect = rect(t, T) 
    rect = 1 * double(abs(t) <= 0.5 * T) + 0.5 * double(abs(t) == 0.5 * T);
end

function [dm, Xdm] = demodulation(x, T, Fm, t, f)
    xdm = 2 * x .* cos(2 * pi * Fm * t);
    Xdm = fftshift(T * fft(xdm));
    Xdm = Xdm .* rect(f, Fm); % ricontrollare come fare la convoluzione
    dm = ifft(ifftshift(Xdm)) / T;
end
