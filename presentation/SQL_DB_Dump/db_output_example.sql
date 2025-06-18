/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.11-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gestion_notes_db
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-0+deb12u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add Étudiant',7,'add_etudiant'),
(26,'Can change Étudiant',7,'change_etudiant'),
(27,'Can delete Étudiant',7,'delete_etudiant'),
(28,'Can view Étudiant',7,'view_etudiant'),
(29,'Can add Unité d\'Enseignement',8,'add_ue'),
(30,'Can change Unité d\'Enseignement',8,'change_ue'),
(31,'Can delete Unité d\'Enseignement',8,'delete_ue'),
(32,'Can view Unité d\'Enseignement',8,'view_ue'),
(33,'Can add Ressource',9,'add_ressource'),
(34,'Can change Ressource',9,'change_ressource'),
(35,'Can delete Ressource',9,'delete_ressource'),
(36,'Can view Ressource',9,'view_ressource'),
(37,'Can add Enseignant',10,'add_enseignant'),
(38,'Can change Enseignant',10,'change_enseignant'),
(39,'Can delete Enseignant',10,'delete_enseignant'),
(40,'Can view Enseignant',10,'view_enseignant'),
(41,'Can add Examen',11,'add_examen'),
(42,'Can change Examen',11,'change_examen'),
(43,'Can delete Examen',11,'delete_examen'),
(44,'Can view Examen',11,'view_examen'),
(45,'Can add Note',12,'add_note'),
(46,'Can change Note',12,'change_note'),
(47,'Can delete Note',12,'delete_note'),
(48,'Can view Note',12,'view_note');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES
(1,'pbkdf2_sha256$1000000$H8jT8eIrkPU64rSH0gntoT$KdN8/FmY6tm7PoGjfpGacq8u2sNzkiEg90fhBg0BHis=',NULL,1,'root','','','contact.cyprien@proton.me',1,1,'2025-06-14 20:10:38.261573');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(10,'enseignants','enseignant'),
(7,'etudiants','etudiant'),
(11,'examens','examen'),
(12,'notes','note'),
(9,'ressources','ressource'),
(6,'sessions','session'),
(8,'ues','ue');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES
(1,'contenttypes','0001_initial','2025-06-14 20:09:59.851133'),
(2,'auth','0001_initial','2025-06-14 20:10:00.433354'),
(3,'admin','0001_initial','2025-06-14 20:10:00.581831'),
(4,'admin','0002_logentry_remove_auto_add','2025-06-14 20:10:00.599969'),
(5,'admin','0003_logentry_add_action_flag_choices','2025-06-14 20:10:00.617030'),
(6,'contenttypes','0002_remove_content_type_name','2025-06-14 20:10:00.717701'),
(7,'auth','0002_alter_permission_name_max_length','2025-06-14 20:10:00.776573'),
(8,'auth','0003_alter_user_email_max_length','2025-06-14 20:10:00.815573'),
(9,'auth','0004_alter_user_username_opts','2025-06-14 20:10:00.831255'),
(10,'auth','0005_alter_user_last_login_null','2025-06-14 20:10:00.884678'),
(11,'auth','0006_require_contenttypes_0002','2025-06-14 20:10:00.888229'),
(12,'auth','0007_alter_validators_add_error_messages','2025-06-14 20:10:00.904065'),
(13,'auth','0008_alter_user_username_max_length','2025-06-14 20:10:00.941315'),
(14,'auth','0009_alter_user_last_name_max_length','2025-06-14 20:10:00.976695'),
(15,'auth','0010_alter_group_name_max_length','2025-06-14 20:10:01.015426'),
(16,'auth','0011_update_proxy_permissions','2025-06-14 20:10:01.069296'),
(17,'auth','0012_alter_user_first_name_max_length','2025-06-14 20:10:01.093660'),
(18,'enseignants','0001_initial','2025-06-14 20:10:01.113748'),
(19,'etudiants','0001_initial','2025-06-14 20:10:01.142215'),
(20,'ues','0001_initial','2025-06-14 20:10:01.172858'),
(21,'ressources','0001_initial','2025-06-14 20:10:01.245764'),
(22,'examens','0001_initial','2025-06-14 20:10:01.353803'),
(23,'notes','0001_initial','2025-06-14 20:10:01.510149'),
(24,'sessions','0001_initial','2025-06-14 20:10:01.564351');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enseignants_enseignant`
--

DROP TABLE IF EXISTS `enseignants_enseignant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `enseignants_enseignant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enseignants_enseignant`
--

LOCK TABLES `enseignants_enseignant` WRITE;
/*!40000 ALTER TABLE `enseignants_enseignant` DISABLE KEYS */;
INSERT INTO `enseignants_enseignant` VALUES
(1,'ALBERT','Arnauld'),
(2,'ECKLE','Olivier');
/*!40000 ALTER TABLE `enseignants_enseignant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etudiants_etudiant`
--

DROP TABLE IF EXISTS `etudiants_etudiant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `etudiants_etudiant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `numero_etudiant` varchar(20) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `groupe` varchar(50) NOT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_etudiant` (`numero_etudiant`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etudiants_etudiant`
--

LOCK TABLES `etudiants_etudiant` WRITE;
/*!40000 ALTER TABLE `etudiants_etudiant` DISABLE KEYS */;
INSERT INTO `etudiants_etudiant` VALUES
(1,'E2024001','BURDLOFF','Cyprien','RT132','photos_etudiants/thispersondoesnotexist.jpg','cyprien.burdloff@uha.fr'),
(2,'E2024002','HOUAMDI','Akli','RT131','photos_etudiants/thispersondoesnotexist1.jpg','akli.houamdi@uha.fr'),
(3,'E2024003','MEILLEURE','Quenous','RT111','photos_etudiants/thispersondoesnotexist2.jpg','meilleure.quenous@uha.fr');
/*!40000 ALTER TABLE `etudiants_etudiant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examens_examen`
--

DROP TABLE IF EXISTS `examens_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `examens_examen` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `titre` varchar(200) NOT NULL,
  `date` date NOT NULL,
  `coefficient` double NOT NULL,
  `enseignant_id` bigint(20) DEFAULT NULL,
  `ressource_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `examens_examen_enseignant_id_0e50ada5_fk_enseignan` (`enseignant_id`),
  KEY `examens_examen_ressource_id_ac7bfddd_fk_ressources_ressource_id` (`ressource_id`),
  CONSTRAINT `examens_examen_enseignant_id_0e50ada5_fk_enseignan` FOREIGN KEY (`enseignant_id`) REFERENCES `enseignants_enseignant` (`id`),
  CONSTRAINT `examens_examen_ressource_id_ac7bfddd_fk_ressources_ressource_id` FOREIGN KEY (`ressource_id`) REFERENCES `ressources_ressource` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examens_examen`
--

LOCK TABLES `examens_examen` WRITE;
/*!40000 ALTER TABLE `examens_examen` DISABLE KEYS */;
INSERT INTO `examens_examen` VALUES
(1,'TP Test','2024-11-08',2,2,1),
(2,'TD Test','2024-09-10',1,2,1),
(3,'TP Test Python','2025-03-03',2,2,2);
/*!40000 ALTER TABLE `examens_examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes_note`
--

DROP TABLE IF EXISTS `notes_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `note` double NOT NULL,
  `appreciation` longtext DEFAULT NULL,
  `etudiant_id` bigint(20) NOT NULL,
  `examen_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notes_note_examen_id_etudiant_id_984d2814_uniq` (`examen_id`,`etudiant_id`),
  KEY `notes_note_etudiant_id_6dd377ce_fk_etudiants_etudiant_id` (`etudiant_id`),
  CONSTRAINT `notes_note_etudiant_id_6dd377ce_fk_etudiants_etudiant_id` FOREIGN KEY (`etudiant_id`) REFERENCES `etudiants_etudiant` (`id`),
  CONSTRAINT `notes_note_examen_id_1dc32bd1_fk_examens_examen_id` FOREIGN KEY (`examen_id`) REFERENCES `examens_examen` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_note`
--

LOCK TABLES `notes_note` WRITE;
/*!40000 ALTER TABLE `notes_note` DISABLE KEYS */;
INSERT INTO `notes_note` VALUES
(1,8,'Pas bien',1,1),
(2,13,'Correct',2,1),
(3,17,'très bien',2,2),
(4,11.4,'Peut mieux faire',1,3),
(5,15,'TRÈS BIEN',2,3);
/*!40000 ALTER TABLE `notes_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ressources_ressource`
--

DROP TABLE IF EXISTS `ressources_ressource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ressources_ressource` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `descriptif` longtext NOT NULL,
  `coefficient` double NOT NULL,
  `ue_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `ressources_ressource_ue_id_8467727f_fk_ues_ue_id` (`ue_id`),
  CONSTRAINT `ressources_ressource_ue_id_8467727f_fk_ues_ue_id` FOREIGN KEY (`ue_id`) REFERENCES `ues_ue` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ressources_ressource`
--

LOCK TABLES `ressources_ressource` WRITE;
/*!40000 ALTER TABLE `ressources_ressource` DISABLE KEYS */;
INSERT INTO `ressources_ressource` VALUES
(1,'R1.01','Inititation aux réseaux locaux','Packet Tracer',21,1),
(2,'R2.08','Analyse et traitement de données structurées','Python++',15,6);
/*!40000 ALTER TABLE `ressources_ressource` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ues_ue`
--

DROP TABLE IF EXISTS `ues_ue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ues_ue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `semestre` int(10) unsigned NOT NULL CHECK (`semestre` >= 0),
  `credits_ects` int(10) unsigned NOT NULL CHECK (`credits_ects` >= 0),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ues_ue`
--

LOCK TABLES `ues_ue` WRITE;
/*!40000 ALTER TABLE `ues_ue` DISABLE KEYS */;
INSERT INTO `ues_ue` VALUES
(1,'UE1.1','[Administrer] - Administrer les réseaux et l\'internet',1,10),
(2,'UE1.2','[Connecter] - Connecter les entreprises et les usagers',1,10),
(3,'UE1.3','[Programmer] - Créer des outils et applications informatiques pour les R&T',1,10),
(4,'UE2.1','[Administrer] - Administrer les réseaux et l\'Internet',2,10),
(5,'UE2.2','[Connecter] - Connecter les entreprises et les usagers',2,10),
(6,'UE2.3','[Programmer] - Créer des outils et applications informatiques pour les R&T',2,10);
/*!40000 ALTER TABLE `ues_ue` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-18 12:51:24
