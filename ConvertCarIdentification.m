function [caractere] = ConvertCarIdentification(bits_car)
% ConvertCarIdentification :
% Fonction permettant de convertir les 6 bits extrait d'une trame de
% message d'identification ADSB en sont caractère associé.

bits1To4 = bits_car(3)*8+bits_car(4)*4+bits_car(5)*2+bits_car(6)*1;
bits4To6 = bits_car(1)*2+bits_car(2)*1;

if bits4To6 == 0
    if bits1To4 == 1
        caractere = 'A';
    elseif bits1To4 == 2
        caractere = 'B';
    elseif bits1To4 == 3
        caractere = 'C';
    elseif bits1To4 == 4
        caractere = 'D';
    elseif bits1To4 == 5
        caractere = 'E';
    elseif bits1To4 == 6
        caractere = 'F';
    elseif bits1To4 == 7
        caractere = 'G';
    elseif bits1To4 == 8
        caractere = 'H';
    elseif bits1To4 == 9
        caractere = 'I';
    elseif bits1To4 == 10
        caractere = 'J';z
    elseif bits1To4 == 11
        caractere = 'K';
    elseif bits1To4 == 12
        caractere = 'L';
    elseif bits1To4 == 13
        caractere = 'M';
    elseif bits1To4 == 14
        caractere = 'N';
    elseif bits1To4 == 15
        caractere = 'O';
    else 
        caractere = "NULL";
    end
elseif bits4To6 == 1
        if bits1To4 == 0
            caractere = 'P';
        elseif bits1To4 == 1
            caractere = 'Q';
        elseif bits1To4 == 2
            caractere = 'R';
        elseif bits1To4 == 3
            caractere = 'S';
        elseif bits1To4 == 4
            caractere = 'T';
        elseif bits1To4 == 5
            caractere = 'U';
        elseif bits1To4 == 6
            caractere = 'V';
        elseif bits1To4 == 7
            caractere = 'W';
        elseif bits1To4 == 8
            caractere = 'X';
        elseif bits1To4 == 9
            caractere = 'Y';
        elseif bits1To4 == 10
            caractere = 'Z';
        else 
            caractere = "NULL";
        end
  elseif bits4To6 == 3
        if bits1To4 == 0
            caractere = '0';
        elseif bits1To4 == 1
            caractere = '1';
        elseif bits1To4 == 2
            caractere = '2';
        elseif bits1To4 == 3
            caractere = '3';
        elseif bits1To4 == 4
            caractere = '4';
        elseif bits1To4 == 5
            caractere = '5';
        elseif bits1To4 == 6
            caractere = '6';
        elseif bits1To4 == 7
            caractere = '7';
        elseif bits1To4 == 8
            caractere = '8';
        elseif bits1To4 == 9
            caractere = '9';
        else 
            caractere = "NULL";
        end
   elseif bits4To6 == 2
       if bits1To4 == 0
         caractere = " ";
       end
end


