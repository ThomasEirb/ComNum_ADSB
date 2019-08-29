function [registre_out] = bit2Registre_RambeauSix(data,registre_in)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%% Initialisation (on recopie le vecteur d'entrée en sortie)

registre_out = registre_in;

% Test sur CRC
CRC_detector = crc.detector('0xFFF409'); % polynôme du checksum
[trame_utile, crcErrFlag] = detect(CRC_detector, data(:)); % retourne les données utiles(trame_utile) ainsi qu'un flag d'erreur(crcErrFlag) sur le checksum
                                                           % crcErrFlag = 1 : erreur
                                                           % crcErrFlag = 0 : RAS

if crcErrFlag == 0 % si le checksum ne retourne aucune erreur
    %% Décodage trame
    
    % Isolation de la trame ADSB en un vecteur ligne
    donnee_utile_ligne = trame_utile'; % permet de faire la transposer pour récupérer un vecteur ligne
    trame_ADSB = donnee_utile_ligne(33:88); % on isole la trame des données ADSB

    Ftc = trame_ADSB(1)*16+trame_ADSB(2)*8+trame_ADSB(3)*4+trame_ADSB(4)*2+trame_ADSB(5)*1; % Conversion binaire vers décimale

    if (Ftc >= 9) && (Ftc <= 22) % Ftc correspondant à Message de position en vol
        altitude_bits = trame_ADSB(9:20); % On extrait les bits correspondant aux différents blocs d'informations
        format_CPR = trame_ADSB(22);
        latitude_CPR = trame_ADSB(23:39);
        longitude_CPR = trame_ADSB(40:56);

        % Décodage de l'altitude
        altitude_bin = [altitude_bits(1:7) altitude_bits(9:12)]; % on enlève le bit numéro 8
        R_a = binaryVectorToDecimal(altitude_bin); % on convertit la valeur en décimale
        altitude = 25*R_a - 1000; % altitude 

        % Décodage de la latitude
        LAT = binaryVectorToDecimal(latitude_CPR, 'MSBFirst'); % convertion binaire vers décimale, avec le MSB comme premier bit du vecteur
        D_lat = (360/(4*15-format_CPR)); % Fonction donnée dans ennoncé
        lat_ref = 44.8048; % latitude de l'enseirb
        j = floor(lat_ref/D_lat)+floor(0.5+(lat_ref-(D_lat)*floor(lat_ref/D_lat))/D_lat-(LAT/(2^17))); % Fonction dans ennoncé

        lat = D_lat*(j+(LAT/(2^17)));

        % Décodage de la longitude
        % Calcul de D_lon en fonction du resultat de Nl(lat)-i cf ennoncé
        if (cprNL(lat)-format_CPR) > 0
            D_lon = (360/(cprNL(lat)-format_CPR));
        elseif (cprNL(lat)-format_CPR) == 0
            D_lon = 360;
        end

        % Calcul de la variable noté m dont la formule est dans l'ennoncé
        lon_ref = -0.5954; % longitude de l'enseirb
        LON = binaryVectorToDecimal(longitude_CPR);
        m = floor(lon_ref/D_lon)+floor(0.5+(lon_ref-(D_lon)*floor(lon_ref/D_lon))/D_lon-(LON/(2^17))); % Fonction dans ennoncé

        % Calcul final de la longitude
        lon = D_lon*(m+(LON/(2^17)));

        registre_out.altitude = altitude; % écriture de l'altitude décodée
        registre_out.latitude = lat; % ecriture de la latitude 
        registre_out.longitude = lon; % ecriture de la longitude
        registre_out.cprFlag = format_CPR;  % écriture de l'indicateur CPR

    else if (Ftc >= 1) && (Ftc <= 5) % Ftc correspondant à Message d'identification
            caractere1 = ConvertCarIdentification(trame_ADSB(9:14));   % On décode chaque caractére du message d'identification
            caractere2 = ConvertCarIdentification(trame_ADSB(15:20));
            caractere3 = ConvertCarIdentification(trame_ADSB(21:26));
            caractere4 = ConvertCarIdentification(trame_ADSB(27:32));
            caractere5 = ConvertCarIdentification(trame_ADSB(33:38));
            caractere6 = ConvertCarIdentification(trame_ADSB(39:44));
            caractere7 = ConvertCarIdentification(trame_ADSB(45:50));
            caractere8 = ConvertCarIdentification(trame_ADSB(51:56));

            caractere = strcat(caractere1, caractere2, caractere3, caractere4, caractere5, caractere6, caractere7, caractere8);

            registre_out.nom = caractere; % remplir le registre avec le nom décodé
    else 
        registre_out = "pas de données";
    end


    registre_out.type = Ftc;      % écriture du type de code 

end

end

