# Fichier de configuration local pour la production

import os
import pymysql
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = '__SECRET_KEY__'
DEBUG = False
ALLOWED_HOSTS = ['__WEB_VM_IP__', '__DOMAIN_NAME__', 'localhost']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '__DB_NAME__',
        'USER': '__DB_USER__',
        'PASSWORD': '__DB_PASSWORD__',
        'HOST': '__DB_VM_IP__',
        'PORT': '3306',
        'OPTIONS': {
            'init_command': "SET sql_mode='STRICT_TRANS_TABLES'",
        },
    }
}

# Configuration des fichiers statiques et media pour la production
STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'

MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

pymysql.install_as_MySQLdb()
