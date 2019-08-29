
%% Fonction qui permet un affichage dynamique des trajectoires des avions

MER_LON = -0.710648; % Longitude de l'aéroport de Mérignac
MER_LAT = 44.836316; % Latitude de l'aéroport de Mérignac

figure(1);
plot(MER_LON,MER_LAT,'.r','MarkerSize',20);% On affiche l'aéroport de Mérignac sur la carte
text(MER_LON+0.05,MER_LAT,'Merignac airport','color','r')

xlabel('Longitude en degré');
ylabel('Lattitude en degré');
   
hold on;

% Affichage d'un avion
PLANE_LON = lon; % Longitude de l'avion
PLANE_LAT = lat; % Latitude de l'avion

plot(PLANE_LON,PLANE_LAT,'+b','MarkerSize',8);
text(PLANE_LON+0.05,PLANE_LAT,Id_airplane,'color','b');
