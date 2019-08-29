%% Initialisation
clear
clc
close all

registre = struct('adresse', [], 'format', [], 'type', [], 'nom', [], ...
           'altitude', [], 'timeFlag', [], 'cprFlag', [], 'latitude', ...
           [], 'longitude', [], 'trajectoire', []);
 
 load trames_20141120.mat
 trames = trames_20141120';

 %% Fonction qui permet un affichage dynamique des trajectoires des avions

MER_LON = -0.710648; % Longitude de l'a�roport de M�rignac
MER_LAT = 44.836316; % Latitude de l'a�roport de M�rignac

figure(1);
plot(MER_LON,MER_LAT,'.r','MarkerSize',20);% On affiche l'a�roport de M�rignac sur la carte
text(MER_LON+0.005,MER_LAT,'Merignac airport','color','r')

xlabel('Longitude en degr�');
ylabel('Lattitude en degr�');

% Fonctionne uniquement si c'est le m�me registre (d'un m�me avion) qui est
% mis � jour
for i=1:21
registre = bit2Registre_RambeauSix(trames_20141120(:,i), registre); % ' permet de faire la transposer pour r�cup�rer un vecteur ligne

% Affichage d'un avion
PLANE_LON = registre.longitude; % Longitude de l'avion
PLANE_LAT = registre.latitude; % Latitude de l'avion

hold on;
plot(PLANE_LON,PLANE_LAT,'+b','MarkerSize',8);

end

hold on
text(PLANE_LON+0.005,PLANE_LAT,registre.nom,'color','b');









