graph TD
    subgraph "Utilisateur Final"
        direction LR
        User("fa:fa-user Utilisateur<br>(Navigateur)")
    end

    subgraph "Réseau Interne (192.168.100.0/24)"
        direction TB

        subgraph "VM 1: Web-Server (Debian)"
            Nginx("fa:fa-server Nginx<br>Reverse Proxy")
            Gunicorn("fa:fa-cog Gunicorn<br>Serveur d'Application")
            Django("fab:fa-python Application Django")
            
            Nginx --> Gunicorn --> Django
        end

        subgraph "VM 2: DB-Server (Debian)"
            MariaDB("fa:fa-database MariaDB")
        end

        Django -- "Connexion TCP<br>Port 3306" --> MariaDB
    end

    User -- "Requête HTTP<br>Port 80" --> Nginx
