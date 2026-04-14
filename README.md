# 📡 Radar à Ultrasons & Visualisation PC

### 📝 Description du projet
Un système de cartographie d'obstacles en temps réel inspiré des radars classiques (SONAR). Il effectue un balayage physique de l'environnement sur 180° et affiche les échos sur une interface graphique PC.

### ⚙️ Implémentation Technique
* **Hardware :** Arduino Leonardo, Capteur US-100, Moteur Pas-à-pas.
* **Précision Capteur (Mon travail) :** Le capteur US-100 est utilisé en **Mode UART** (au lieu du mode Pulse/PWM standard). J'ai écrit le firmware pour exploiter la compensation de température intégrée et obtenir des mesures fiables.
* **Stabilité USB (Note technique) :** Une séquence de redémarrage dynamique du port Série (`Serial.end/begin`) a été implémentée. Elle permet de réinitialiser la connexion USB native de la Leonardo sans avoir à débrancher physiquement le câble lors des redémarrages du script.
* **Interface Processing :** Adaptation d'un code Java libre de droits (source internet) sur Processing v4.2. Elle traduit les données polaires (Angle/Distance) reçues via le port Série en affichage graphique.

### 🔌 Câblage (Pinout)

Le projet utilise un **Arduino Leonardo**. L'utilisation du port `Serial1` permet de dédier la communication USB à l'affichage graphique sur PC sans interférences.

* **Capteur US-100 (Mode UART)** :
    * **VCC** -> Pin **5V**
    * **GND** -> Pin **GND**
    * **Trig/TX** -> Pin **0 (RX)** de l'Arduino Leonardo
    * **Echo/RX** -> Pin **1 (TX)** de l'Arduino Leonardo
    * ⚠️ **Note matérielle importante :** Le capteur US-100 possède un petit "jumper" (cavalier) à l'arrière. Pour qu'il fonctionne en mode UART avec ce code, **ce jumper doit impérativement être en place**. S'il est retiré, le capteur bascule en mode classique "Trigger/Echo" et la communication série ne fonctionnera pas.
* **Moteur Pas-à-pas (28BYJ-48) & Driver ULN2003** :
    * **IN1** -> Pin **9**
    * **IN2** -> Pin **10**
    * **IN3** -> Pin **11**
    * **IN4** -> Pin **8**
    * *Note : L'ordre des pins est spécifiquement configuré pour correspondre à la séquence de pas définie dans le firmware.*
* **Contrôle & Indicateurs** :
    * **Interrupteur (Start/Stop)** -> Pin **6** (relié au GND, utilise le `INPUT_PULLUP` interne).
    * **Indicateur de Pause** -> Pin **13** (Utilise la LED intégrée à la carte).

### 📺 Démo Vidéo
[▶️ Voir la démonstration vidéo sur YouTube](https://youtu.be/SPf-uMdrIcA)

### 📄 Licence & Crédits
* **Firmware Arduino :** Sous licence **GNU GPLv3**. Vous êtes libres d'utiliser, modifier et redistribuer ce logiciel, à condition de me créditer et de conserver la même licence libre pour les travaux dérivés.
* **Interface Processing :** Adaptation d'un code Java libre de droits (source internet) sur Processing v4.2.
