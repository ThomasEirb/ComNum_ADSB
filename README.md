# Communication Numérique : Projet ADSB

   Afin de surveiller l’état du réseau aérien, un système de diffusion appelé Automatic Dependant Surveillance - Broadcast (ADS-B) a été proposé en complément des radars classiques. Dans ce système, les appareils estiment leurs positions (longitude, latitude, altitude) grâce aux techniques de positionnement par satellite (GPS - Global Positionning System, GLONASS - Global Navi- gation Satellite System ou encore Galiléo) et diffusent ces informations régulièrement (toutes les secondes environ). Ces informations sont ensuite récupérées :
  - au sol : par des stations intermédiaires ou des tours de contrôle,
  - dans les autres appareils : qui peuvent utiliser ces signaux pour leurs systèmes anticollision.

  Le principal avantage du système ADS-B par rapport au radar classique est son faible coût d’infrastructure. En effet, la station réceptrice possède seulement une antenne de réception afin de recevoir les signaux ADS-B, le reste des traitements étant faits à bord des appareils. Le récepteur est donc entièrement passif et n’a pas besoin d’interroger l’appareil pour qu’il émette sa position.
Il existe plusieurs liaisons pour la transmission des signaux ADS-B. Les deux principales sont :
  - le 1090 Extended Squitter (1090 ES),
-  l’UAT (Universal Access Transponder).

  Dans ce projet, nous allons nous concentrer sur le 1090 ES car c’est le mode privilégié en Europe. Dans l’appellation 1090 ES, 1090 signifie que la fréquence porteuse des signaux ADS-B (pour ce mode de transmission) est 1090 MHz. ES signifie Extended Squitter, ce qui pourrait être traduit par message étendu. En effet, les messages transmis en utilisant ce mode avaient une durée de 56 bits (hors préambule de synchronisation). Dans le nouveau standard, les messages peuvent contenir 112 bits, d’où la notion de "message étendu".
  
  Le rapport de ce projet est présent sous le nom **TS111_RAMBEAU_SIX**.
  
  L'ensemble du code est réalisé sous **MATLAB**.
