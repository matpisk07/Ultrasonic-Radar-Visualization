# 📡 Radar à Ultrasons & Visualisation PC

### 📝 Description du projet
Un système de cartographie d'obstacles en temps réel inspiré des radars classiques (SONAR). Il effectue un balayage physique de l'environnement sur 180° et affiche les échos sur une interface graphique PC.

### ⚙️ Implémentation Technique
* **Hardware :** Arduino Leonardo, Capteur US-100, Moteur Pas-à-pas.
* **Précision Capteur (Mon travail) :** Le capteur US-100 est utilisé en **Mode UART** (au lieu du mode Pulse/PWM standard). J'ai écrit le firmware pour exploiter la compensation de température intégrée et obtenir des mesures fiables.
* **Stabilité USB (Note technique) :** Une séquence de redémarrage dynamique du port Série (`Serial.end/begin`) a été implémentée. Elle permet de réinitialiser la connexion USB native de la Leonardo sans avoir à débrancher physiquement le câble lors des redémarrages du script.
* **Interface Processing :** Adaptation d'un code Java libre de droits (source internet) sur Processing v4.2. Elle traduit les données polaires (Angle/Distance) reçues via le port Série en affichage graphique.

### 📺 Démo Vidéo
[▶️ Voir la démonstration vidéo sur YouTube](https://youtu.be/SPf-uMdrIcA)

### 📄 Licence & Crédits
* **Firmware Arduino :** Sous licence **GNU GPLv3**. Vous êtes libres d'utiliser, modifier et redistribuer ce logiciel, à condition de me créditer et de conserver la même licence libre pour les travaux dérivés.
* **Interface Processing :** Adaptation d'un code Java libre de droits (source internet) sur Processing v4.2.
