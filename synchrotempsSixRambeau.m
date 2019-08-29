function [mat_sl] = synchrotempsSixRambeau(yl, sp, Fse, Seuil)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Traitement du signal pour resynchronisation
xl_M = abs(yl); % calcul du module 

% Intercorrélation pour détection de préambule
Esp = sqrt((sum(sp.^2)));% Energie de Sp
for i=1:1:length(xl_M)-length(sp)
    Rpx = 0;
    for j=1:length(sp)
        Rpx = Rpx + sp(j)*xl_M((i+j)-1); % Intercorrélation entre préambule(Sp) et xl_M
    end
    Exl_M = sqrt(sum(xl_M(i:i+length(sp)).^2)); % Energie du signal que l'on regarde
    Rpx = Rpx/(Exl_M*Esp);
    Rpx_n(i) = Rpx;
end

figure(1)
plot(([0:length(Rpx_n)-1]), Rpx_n)
figure(2)
plot(([0:length(yl)-1]), yl)



% recherche des peaks au dessus du seuil
[yp xp] = findpeaks(Rpx_n, 'MinpeakHeight', Seuil-0.1, 'MinPeakDistance', 3);

% Stockage dans matrice des signaux 
mat_sl = []; 
for k=1:length(xp)
    if (xp(k)+length(sp)+112*Fse-1)<length(yl)
        mat_sl(k,:)= yl([xp(k)+length(sp):xp(k)+length(sp)+112*Fse-1]);
    end    
end

