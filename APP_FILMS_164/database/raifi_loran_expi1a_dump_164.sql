-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour raifi_loran_expi1a_inventaire_v1_v1
DROP DATABASE IF EXISTS `raifi_loran_expi1a_inventaire_v1_v1`;
CREATE DATABASE IF NOT EXISTS `raifi_loran_expi1a_inventaire_v1_v1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `raifi_loran_expi1a_inventaire_v1_v1`;

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_destockage
DROP TABLE IF EXISTS `t_destockage`;
CREATE TABLE IF NOT EXISTS `t_destockage` (
  `id_destockage` int NOT NULL AUTO_INCREMENT,
  `id_entrepot` int DEFAULT NULL,
  `date_destockage` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_destockage`),
  KEY `id_entrepot` (`id_entrepot`),
  CONSTRAINT `t_destockage_ibfk_1` FOREIGN KEY (`id_entrepot`) REFERENCES `t_entrepot` (`id_entrepot`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_destockage : ~10 rows (environ)
DELETE FROM `t_destockage`;
INSERT INTO `t_destockage` (`id_destockage`, `id_entrepot`, `date_destockage`, `etat`) VALUES
	(1, 1, '2023-01-15', 'Neuf'),
	(2, 1, '2023-01-16', 'Usé'),
	(3, 2, '2023-01-17', 'Neuf'),
	(4, 2, '2023-01-18', 'Usé'),
	(5, 3, '2023-01-19', 'Neuf'),
	(6, 3, '2023-01-20', 'Usé'),
	(7, 4, '2023-01-21', 'Neuf'),
	(8, 4, '2023-01-22', 'Usé'),
	(9, 5, '2023-01-23', 'Neuf'),
	(10, 5, '2023-01-20', 'Usé');

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_emprunt
DROP TABLE IF EXISTS `t_emprunt`;
CREATE TABLE IF NOT EXISTS `t_emprunt` (
  `id_emprunt` int NOT NULL AUTO_INCREMENT,
  `date_emprunt` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  `id_retour` int DEFAULT NULL,
  PRIMARY KEY (`id_emprunt`),
  KEY `id_retour` (`id_retour`),
  CONSTRAINT `t_emprunt_ibfk_1` FOREIGN KEY (`id_retour`) REFERENCES `t_retour` (`id_retour`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_emprunt : ~10 rows (environ)
DELETE FROM `t_emprunt`;
INSERT INTO `t_emprunt` (`id_emprunt`, `date_emprunt`, `etat`, `id_retour`) VALUES
	(1, '2023-01-01', 'Usé', NULL),
	(2, '2023-01-02', 'Neuf', NULL),
	(3, '2023-01-03', 'Usé', NULL),
	(4, '2023-01-04', 'Neuf', NULL),
	(5, '2023-01-05', 'Usé', NULL),
	(6, '2023-01-06', 'Neuf', NULL),
	(7, '2023-01-07', 'Usé', NULL),
	(8, '2023-01-08', 'Neuf', NULL),
	(9, '2023-01-09', 'Usé', NULL),
	(10, '2023-01-10', 'Neuf', NULL);

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_entrepot
DROP TABLE IF EXISTS `t_entrepot`;
CREATE TABLE IF NOT EXISTS `t_entrepot` (
  `id_entrepot` int NOT NULL AUTO_INCREMENT,
  `date_entrepot` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  `id_retour` int DEFAULT NULL,
  PRIMARY KEY (`id_entrepot`),
  KEY `id_retour` (`id_retour`),
  CONSTRAINT `t_entrepot_ibfk_1` FOREIGN KEY (`id_retour`) REFERENCES `t_retour` (`id_retour`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_entrepot : ~10 rows (environ)
DELETE FROM `t_entrepot`;
INSERT INTO `t_entrepot` (`id_entrepot`, `date_entrepot`, `etat`, `id_retour`) VALUES
	(1, '2023-01-15', 'En stock', NULL),
	(2, '2023-01-16', 'En transit', NULL),
	(3, '2023-01-17', 'En stock', NULL),
	(4, '2023-01-18', 'En transit', NULL),
	(5, '2023-01-19', 'En stock', NULL),
	(6, '2023-01-20', 'En transit', NULL),
	(7, '2023-01-21', 'En stock', NULL),
	(8, '2023-01-22', 'En transit', NULL),
	(9, '2023-01-23', 'En stock', NULL),
	(10, '2023-01-24', 'En transit', NULL);

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_lieu
DROP TABLE IF EXISTS `t_lieu`;
CREATE TABLE IF NOT EXISTS `t_lieu` (
  `id_lieu` int NOT NULL AUTO_INCREMENT,
  `nom_lieu` varchar(50) DEFAULT NULL,
  `id_entrepot` int DEFAULT NULL,
  PRIMARY KEY (`id_lieu`),
  KEY `id_entrepot` (`id_entrepot`),
  CONSTRAINT `t_lieu_ibfk_1` FOREIGN KEY (`id_entrepot`) REFERENCES `t_entrepot` (`id_entrepot`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_lieu : ~4 rows (environ)
DELETE FROM `t_lieu`;
INSERT INTO `t_lieu` (`id_lieu`, `nom_lieu`, `id_entrepot`) VALUES
	(1, 'galta', NULL),
	(2, 'sous sol 1', NULL),
	(3, 'sous sol 2', NULL),
	(4, 'bureau informatique', NULL);

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_objets
DROP TABLE IF EXISTS `t_objets`;
CREATE TABLE IF NOT EXISTS `t_objets` (
  `id_objets` int NOT NULL AUTO_INCREMENT,
  `nom_objets` varchar(50) NOT NULL,
  `etat_objets` varchar(50) DEFAULT NULL,
  `numero_serie` varchar(20) DEFAULT NULL,
  `is_assigned` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id_objets`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_objets : ~8 rows (environ)
DELETE FROM `t_objets`;
INSERT INTO `t_objets` (`id_objets`, `nom_objets`, `etat_objets`, `numero_serie`, `is_assigned`) VALUES
	(4, 'Souris optique', 'Fonctionnel', 'SN444555666', 0),
	(5, 'Disque dur externe', 'En réparation', 'SN777888999', 0),
	(6, 'Écran LCD', 'Fonctionnel', 'SN666555444', 0),
	(7, 'Routeur sans fil', 'Hors service', 'SN333222111', 0),
	(8, 'Casque audio', 'Fonctionnel', 'SN999888777', 0),
	(9, 'Webcam HD', 'Fonctionnel', 'SN123321123', 0),
	(10, 'Lecteur de cartes mémoire', 'Hors service', 'SN456654456', 0),
	(12, 'pc', 'usé', NULL, 0),
	(13, 'eeee', NULL, NULL, 0);

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_objets_personne
DROP TABLE IF EXISTS `t_objets_personne`;
CREATE TABLE IF NOT EXISTS `t_objets_personne` (
  `id_objets_personne` int NOT NULL AUTO_INCREMENT,
  `id_personne` int NOT NULL,
  `id_objets` int NOT NULL,
  PRIMARY KEY (`id_objets_personne`),
  KEY `id_personne` (`id_personne`),
  KEY `id_objets` (`id_objets`),
  CONSTRAINT `t_objets_personne_ibfk_1` FOREIGN KEY (`id_personne`) REFERENCES `t_personne` (`id_personne`),
  CONSTRAINT `t_objets_personne_ibfk_2` FOREIGN KEY (`id_objets`) REFERENCES `t_objets` (`id_objets`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_objets_personne : ~0 rows (environ)
DELETE FROM `t_objets_personne`;

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_personne
DROP TABLE IF EXISTS `t_personne`;
CREATE TABLE IF NOT EXISTS `t_personne` (
  `id_personne` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `mail_entreprise` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_personne`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_personne : ~10 rows (environ)
DELETE FROM `t_personne`;
INSERT INTO `t_personne` (`id_personne`, `nom`, `prenom`, `service`, `mail_entreprise`) VALUES
	(1, 'Doe', 'John', 'IT', 'test.test@test.ch'),
	(2, 'Smith', 'Alice', 'Ventes', 'alice.smith@example.com'),
	(3, 'Johnson', 'Michael', 'Informatique', 'michael.johnson@example.com'),
	(4, 'Williams', 'Jessica', 'Marketing', 'jessica.williams@example.com'),
	(5, 'Brown', 'Chris', 'Logistique', 'chris.brown@example.com'),
	(6, 'Garcia', 'Maria', 'Finance', 'maria.garcia@example.com'),
	(7, 'Martinez', 'David', 'Production', 'david.martinez@example.com'),
	(8, 'Lopez', 'Sophia', 'Service client', 'sophia.lopez@example.com'),
	(9, 'Lee', 'James', 'Achats', 'james.lee@example.com'),
	(10, 'Gonzalez', 'Paula', 'Qualité', 'paula.gonzalez@example.com'),
	(11, 'claude', 'Arthur', 'Informaticien', 'arthur.terra@la-ligniere.ch');

-- Listage de la structure de table raifi_loran_expi1a_inventaire_v1_v1. t_retour
DROP TABLE IF EXISTS `t_retour`;
CREATE TABLE IF NOT EXISTS `t_retour` (
  `id_retour` int NOT NULL AUTO_INCREMENT,
  `date_retour` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  `id_objets` int DEFAULT NULL,
  PRIMARY KEY (`id_retour`),
  KEY `id_objets` (`id_objets`),
  CONSTRAINT `t_retour_ibfk_1` FOREIGN KEY (`id_objets`) REFERENCES `t_objets` (`id_objets`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire_v1_v1.t_retour : ~7 rows (environ)
DELETE FROM `t_retour`;
INSERT INTO `t_retour` (`id_retour`, `date_retour`, `etat`, `id_objets`) VALUES
	(1, '2023-01-01', 'usé', NULL),
	(2, '2023-01-02', 'cassé', NULL),
	(3, '2023-01-03', 'neuf', NULL),
	(4, '2023-01-04', 'presque neuf', NULL),
	(5, '2023-01-05', 'bientot casse', NULL),
	(6, '2023-01-06', 'peu usé', NULL),
	(7, '2023-01-07', 'très usé', NULL);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
