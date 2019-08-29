%% Initialisation
clear
clc
close all

Fe = 20e6;  % fréquence d'échantillonnage 
Te = 1/Fe;  % période d'échantillonnage
Ds = 1e6;   % Débit symbole
Ts = 1/Ds;  % periode d'echantillonnage Ts

Tp = 8e-6; % temps du signal sp

Fse = Ts/Te; % Facteur de sur-échantillonnage

sp = [ones(1, Fse/2), zeros(1, Fse/2), ones(1, Fse/2), zeros(1, 2*Fse),ones(1, Fse/2), zeros(1, Fse/2), ones(1, Fse/2), zeros(1, 3*Fse)];
dec = 10; % décalage temporel du signal transmis
Seuil = 0.8;

Nb = 500; % nombre de bit transmis

Nfft = 512; % Nombre de points pour les FFT

freq_axis = [-Fe/2:(Fe/Nfft):Fe/2-Fe/Nfft]; % axe fréquentiel (pas de fe/Nfft) 

p1 = [ones(1, Fse/2), zeros(1, Fse/2)]; % Filtre p0
p0 = [zeros(1, Fse/2), ones(1, Fse/2)]; % Filtre p1

h=[1]; % filre du canal : représentation d'un dirac (mettre des 0 devant pour décalage)
%% Tx

bits = rand(1, Nb)>0.5; % séquence binaire aléatoire avec une densité de probabilité uniforme


%bits = [0, 1, 1, 0, 1, 0]
sl = [];

for i=1:1:Nb
    if bits(i) == 1
        sl=[sl,p1];
    else
        sl=[sl,p0];   
    end
end

sl_sp = [zeros(1, dec*Fse), sp, sl]; % signal sp devant sl 

Nb_FFT = floor(length(sl)/Nfft); % arrondi minimum vers le bas

S = 0;
%Algo de welch
for i=1:Nb_FFT
    tmp = sl((i-1)*Nfft+1:i*Nfft);
    S = S + fftshift(abs(fft(tmp,Nfft)).^2);
end;

S = S/Nb_FFT; % DSP

% Génération du bruit
Eb = sum(sl.^2)/Nb; % Energie moyenne de chaque bit

Ebn0 = 20; % Valeure arbitraire 0 < X < 10

n0 = Eb/(10.^(Ebn0/10));  % n0 en fonction de (n0/Eb)
Variance = n0/2;          % variance
nl = (randn(1,length(sl_sp))*sqrt(Variance)); % génération du bruit en fonction de la variance
yl = sl_sp + 1; % signal + bruit
   
%% Canal

xl = conv(h, yl); % filtrage par le canal

%% Rx

mat_sl = synchrotempsSixRambeau(yl, sp, Fse, Seuil); % Algo de synch

% Fonction flip_lr(left right) pour retourner le vecteur
rl_p0 = conv(mat_sl, fliplr(p0)); % convolution par p0*(-t) filtre adapté de p0 
rl_p1 = conv(mat_sl, fliplr(p1)); % convolution par p1*(-t) filtre adapté de p1
   
rln_p0 = rl_p0(Fse:Fse:end); % échantillonnage au ryhtme Ts de rl_p0
rln_p1 = rl_p1(Fse:Fse:end); % échantillonnage au ryhtme Ts de rl_p1

for j=1:1:112
    if rln_p1(j) <= rln_p0(j) 
        bk(j) = 0;
    else
        bk(j) = 1;   
    end
end

%bk = RxSixRambeau(sl, p0, p1, Fse, Nb) % Fonction de réception

 BER = mean(abs(bits([1:112]) - bk)) % Taux d'erreur binaire

%% Figures

% hist(bits)
% 
% figure(1)
% plot(([0:length(sp)-1]*Te), sp);
% title('Filtre P1')
% 
% figure(2)
% plot(([0:length(p1)-1]*Te), p0);
% title('Filtre P0')
% 
% figure(3)
% plot(([0:length(sl)-1]*Te), sl)
% title('Signal Sl en sortie du filtre de mise en forme')
% 
% figure(4)
% subplot(211)
% plot(([0:length(rl_p1)-1]*Te), rl_p1)
% title('Signal rl_p1 en sortie du filtre de réception P1')
% xlim([0 1e-5])
% subplot(212)
% plot(([0:length(rl_p0)-1]*Te), rl_p0)
% title('Signal rl_p0 en sortie du filtre de réception P0')
% xlim([0 1e-5])
% 
% figure(5)
% subplot(211)
% plot(([0:length(rln_p1)-1]*Ts), rln_p1)
% title('Signal rln_p1 échantillonné')
% xlim([0 1e-5])
% subplot(212)
% plot(([0:length(rln_p0)-1]*Ts), rln_p0)
% title('Signal rln_p0 échantillonné')
% xlim([0 1e-5])
% 
% figure(6)
% plot(([0:length(bk)-1]*Ts), bk, 'r*')
% title('Signal bk')
% 
% eyediagram(rl_p1, 100, 2*Ts);
% 
% figure(8)
% semilogy(freq_axis, S);
% xlabel('Fréquences (Hz)');
% ylabel('Amplitude');
% title('Estimation de la DSP de sl(t)');
% grid on 
% 
% figure(9)
% semilogy(Ebn0, BER)
% xlabel('(Eb/N0) en dB');
% ylabel('BER');
% title('BER en fonction de Eb/N0');
% grid on 

figure(11)
plot(([0:length(yl)-1])*Te, yl);
