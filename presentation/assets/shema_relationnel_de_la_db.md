erDiagram
    Etudiant {
        int id PK "Clé primaire"
        varchar(20) numero_etudiant UK "N° étudiant unique"
        varchar(100) nom
        varchar(100) prenom
        varchar(50) groupe
        varchar(100) photo "Chemin vers l'image"
        varchar(254) email UK
    }

    Enseignant {
        int id PK "Clé primaire"
        varchar(100) nom
        varchar(100) prenom
    }

    UE {
        int id PK "Clé primaire"
        varchar(20) code UK "Code UE unique"
        varchar(200) nom
        int semestre
        int credits_ects
    }

    Ressource {
        int id PK "Clé primaire"
        int id_ue FK "Clé étrangère vers UE"
        varchar(20) code UK "Code ressource unique"
        varchar(200) nom
        text descriptif
        float coefficient
    }

    Examen {
        int id PK "Clé primaire"
        int id_ressource FK "Clé étrangère vers Ressource"
        int id_enseignant FK "Clé étrangère vers Enseignant (peut être NULL)"
        varchar(200) titre
        date date
        float coefficient
    }

    Note {
        int id PK "Clé primaire"
        int id_examen FK "Clé étrangère vers Examen"
        int id_etudiant FK "Clé étrangère vers Etudiant"
        float note "Note sur 20"
        text appreciation
    }

    UE ||--|{ Ressource : "contient"
    Ressource ||--|{ Examen : "est évaluée par"
    Enseignant ||--o{ Examen : "supervise"
    Examen ||--|{ Note : "donne lieu à"
    Etudiant ||--|{ Note : "reçoit"