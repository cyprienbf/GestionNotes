#!/bin/bash

set -e

# --- VARIABLES À CONFIGURER ---
DB_VM_IP="192.168.100.x"
WEB_VM_IP="192.168.100.y"
DB_NAME="gestion_notes_db"
DB_USER="django_user"
DB_PASSWORD="il_faut_le_changer"
PROJECT_DIR="/opt/GestionNotes"
PROJECT_REPO="https://github.com/cyprienbf/GestionNotes.git"
MAIN_PROJECT_NAME="gestion_notes"
SYSTEM_USER="django"
DOMAIN_NAME="votre-domaine.com"
DJANGO_SUPERUSER_USERNAME="admin"
DJANGO_SUPERUSER_PASSWORD="un_autre_super_mot_de_passe"
DJANGO_SUPERUSER_EMAIL="admin@example.com"

# Chemin vers le dossier contenant les fichiers de config
CONFIG_DIR="$(pwd)/config_files"

# --- ÉTAPE 1 : PRÉPARATION DU SYSTÈME ---
echo ">>> Étape 1 : Mise à jour et installation des dépendances..."
apt-get update
apt-get upgrade -y
apt-get install -y python3-venv python3-pip python3-dev default-libmysqlclient-dev nginx git ufw sudo
useradd -r -s /bin/false $SYSTEM_USER || echo "Utilisateur '$SYSTEM_USER' existe déjà."

# --- ÉTAPE 2 : DÉPLOIEMENT DU PROJET ---
echo ">>> Étape 2 : Clonage du projet et configuration de l'environnement..."
git clone "$PROJECT_REPO" "$PROJECT_DIR"
chown -R $SYSTEM_USER:$SYSTEM_USER "$PROJECT_DIR"
sudo -u $SYSTEM_USER bash -c "cd $PROJECT_DIR && python3 -m venv venv && source venv/bin/activate && pip install --upgrade pip && pip install django gunicorn pillow weasyprint pymysql" # mysqlclient?

# --- ÉTAPE 3 : CONFIGURATION DE DJANGO ---
echo ">>> Étape 3 : Copie et adaptation du fichier de configuration Django..."
LOCAL_SETTINGS_SOURCE="$CONFIG_DIR/settings.py"
LOCAL_SETTINGS_DEST="$PROJECT_DIR/$MAIN_PROJECT_NAME/settings.py"
cp "$LOCAL_SETTINGS_SOURCE" "$LOCAL_SETTINGS_DEST"

# Remplacement des placeholders dans le fichier settings.py
SECRET_KEY_VALUE=$(openssl rand -hex 32)
sed -i "s|__SECRET_KEY__|$SECRET_KEY_VALUE|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__WEB_VM_IP__|$WEB_VM_IP|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__DOMAIN_NAME__|$DOMAIN_NAME|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__DB_NAME__|$DB_NAME|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__DB_USER__|$DB_USER|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__DB_PASSWORD__|$DB_PASSWORD|g" "$LOCAL_SETTINGS_DEST"
sed -i "s|__DB_VM_IP__|$DB_VM_IP|g" "$LOCAL_SETTINGS_DEST"
chown $SYSTEM_USER:$SYSTEM_USER "$LOCAL_SETTINGS_DEST"

echo "Ajout de l'import des settings locaux au settings.py principal..."
echo -e "\ntry:\n    from .settings import *\nexcept ImportError:\n    pass" >> "$PROJECT_DIR/$MAIN_PROJECT_NAME/settings.py"

echo "Exécution des commandes de management Django..."
sudo -u $SYSTEM_USER bash -c "cd $PROJECT_DIR && source venv/bin/activate && python manage.py collectstatic --noinput && python manage.py migrate --noinput"
sudo -u $SYSTEM_USER bash -c "cd $PROJECT_DIR && source venv/bin/activate && export DJANGO_SUPERUSER_USERNAME=$DJANGO_SUPERUSER_USERNAME && export DJANGO_SUPERUSER_PASSWORD=$DJANGO_SUPERUSER_PASSWORD && export DJANGO_SUPERUSER_EMAIL=$DJANGO_SUPERUSER_EMAIL && python manage.py createsuperuser --noinput"

# --- ÉTAPE 4 : CONFIGURATION DE GUNICORN ---
echo ">>> Étape 4 : Copie et adaptation du service Gunicorn..."
GUNICORN_SERVICE_SOURCE="$CONFIG_DIR/gunicorn.service"
GUNICORN_SERVICE_DEST="/etc/systemd/system/gunicorn.service"
cp "$GUNICORN_SERVICE_SOURCE" "$GUNICORN_SERVICE_DEST"

sed -i "s|__SYSTEM_USER__|$SYSTEM_USER|g" "$GUNICORN_SERVICE_DEST"
sed -i "s|__PROJECT_DIR__|$PROJECT_DIR|g" "$GUNICORN_SERVICE_DEST" # Utiliser un délimiteur différent (ici |) car le chemin contient des /
sed -i "s|__MAIN_PROJECT_NAME__|$MAIN_PROJECT_NAME|g" "$GUNICORN_SERVICE_DEST"

systemctl daemon-reload
systemctl start gunicorn
systemctl enable gunicorn

# --- ÉTAPE 5 : CONFIGURATION DE NGINX ---
echo ">>> Étape 5 : Copie et adaptation de la configuration Nginx..."
NGINX_SITE_SOURCE="$CONFIG_DIR/nginx_site"
NGINX_SITE_DEST="/etc/nginx/sites-available/$MAIN_PROJECT_NAME"
cp "$NGINX_SITE_SOURCE" "$NGINX_SITE_DEST"

sed -i "s|__WEB_VM_IP__|$WEB_VM_IP|g" "$NGINX_SITE_DEST"
sed -i "s|__DOMAIN_NAME__|$DOMAIN_NAME|g" "$NGINX_SITE_DEST"
sed -i "s|__PROJECT_DIR__|$PROJECT_DIR|g" "$NGINX_SITE_DEST"

ln -s "$NGINX_SITE_DEST" /etc/nginx/sites-enabled/ || echo "Lien symbolique Nginx existe déjà."
rm -f /etc/nginx/sites-enabled/default

nginx -t
systemctl restart nginx

# --- ÉTAPE 6 : CONFIGURATION DU PARE-FEU ---
echo ">>> Étape 6 : Configuration du pare-feu..."
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 'Nginx Full'
ufw --force enable

echo "========================================================"
echo "    Configuration du serveur web terminée !            "
echo "    Site accessible à l'adresse http://$WEB_VM_IP"
echo "========================================================"