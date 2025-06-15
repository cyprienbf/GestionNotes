#!/bin/bash

set -e

# --- VARIABLES À CONFIGURER ---
DB_VM_IP="192.168.100.x"
WEB_VM_IP="192.168.100.y"
DB_NAME="gestion_notes_db"
DB_USER="django_user"
DB_PASSWORD="il_faut_le_changer"

# Chemin vers le dossier contenant les fichiers de config
CONFIG_DIR="$(pwd)/config_files"

# --- ÉTAPE 1 : INSTALLATION ---
echo ">>> Étape 1 : Mise à jour du système et installation de MariaDB..."
apt-get update
apt-get upgrade -y
apt-get install -y mariadb-server ufw

# --- ÉTAPE 2 : COPIE ET ADAPTATION DE LA CONFIGURATION MARIADB ---
echo ">>> Étape 2 : Configuration de MariaDB..."
CONFIG_FILE_SOURCE="$CONFIG_DIR/99-custom.cnf"
CONFIG_FILE_DEST="/etc/mysql/mariadb.conf.d/99-custom.cnf"

echo "Copie du fichier de configuration vers $CONFIG_FILE_DEST"
cp "$CONFIG_FILE_SOURCE" "$CONFIG_FILE_DEST"

echo "Adaptation du fichier de configuration avec les bonnes valeurs..."
sed -i "s|__DB_VM_IP__|$DB_VM_IP|g" "$CONFIG_FILE_DEST"

echo "Redémarrage de MariaDB..."
systemctl restart mariadb

# --- ÉTAPE 3 : CRÉATION DE LA BASE DE DONNÉES ET DE L'UTILISATEUR ---
echo ">>> Étape 3 : Création de la base de données et de l'utilisateur..."
mariadb -e "CREATE DATABASE IF NOT EXISTS \`$DB_NAME\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER'@'$WEB_VM_IP' IDENTIFIED BY '$DB_PASSWORD';"
mariadb -e "GRANT ALL PRIVILEGES ON \`$DB_NAME\`.* TO '$DB_USER'@'$WEB_VM_IP';"
mariadb -e "FLUSH PRIVILEGES;"

# --- ÉTAPE 4 : CONFIGURATION DU PARE-FEU ---
echo ">>> Étape 4 : Configuration du pare-feu..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow from $WEB_VM_IP to any port 3306 proto tcp comment 'Allow Django Web VM'
ufw --force enable

echo "========================================================"
echo "  Configuration du serveur de base de données terminée !  "
echo "========================================================"
