-- OM 2021.02.17
-- FICHIER MYSQL POUR FAIRE FONCTIONNER LES EXEMPLES
-- DE REQUETES MYSQL
-- Database: MACCAUD_OLIVIER_INFO1X_FILMS_164_2023

-- Destruction de la BD si elle existe.
-- Pour être certain d'avoir la dernière version des données

DROP DATABASE IF EXISTS raifi_loran_expi1a_inventaire;

-- Création d'un nouvelle base de donnée

CREATE DATABASE IF NOT EXISTS raifi_loran_expi1a_inventaire;

-- Utilisation de cette base de donnée

USE raifi_loran_expi1a_inventaire;
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


-- Listage de la structure de la base pour raifi_loran_expi1a_inventaire
DROP DATABASE IF EXISTS `raifi_loran_expi1a_inventaire`;
CREATE DATABASE IF NOT EXISTS `raifi_loran_expi1a_inventaire` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `raifi_loran_expi1a_inventaire`;

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_destockage
DROP TABLE IF EXISTS `t_destockage`;
CREATE TABLE IF NOT EXISTS `t_destockage` (
  `id_destockage` int NOT NULL AUTO_INCREMENT,
  `id_entrepot` int DEFAULT NULL,
  `date_destockage` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_destockage`),
  KEY `id_entrepot` (`id_entrepot`),
  CONSTRAINT `t_destockage_ibfk_1` FOREIGN KEY (`id_entrepot`) REFERENCES `t_entrepot` (`id_entrepot`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_destockage : ~10 rows (environ)
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
	(10, 5, '2023-01-24', 'Usé');

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_emprunt
DROP TABLE IF EXISTS `t_emprunt`;
CREATE TABLE IF NOT EXISTS `t_emprunt` (
  `id_emprunt` int NOT NULL AUTO_INCREMENT,
  `date_emprunt` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_emprunt`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_emprunt : ~10 rows (environ)
DELETE FROM `t_emprunt`;
INSERT INTO `t_emprunt` (`id_emprunt`, `date_emprunt`, `etat`) VALUES
	(1, '2023-01-01', 'Usé'),
	(2, '2023-01-02', 'Neuf'),
	(3, '2023-01-03', 'Usé'),
	(4, '2023-01-04', 'Neuf'),
	(5, '2023-01-05', 'Usé'),
	(6, '2023-01-06', 'Neuf'),
	(7, '2023-01-07', 'Usé'),
	(8, '2023-01-08', 'Neuf'),
	(9, '2023-01-09', 'Usé'),
	(10, '2023-01-10', 'Neuf');

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_entrepot
DROP TABLE IF EXISTS `t_entrepot`;
CREATE TABLE IF NOT EXISTS `t_entrepot` (
  `id_entrepot` int NOT NULL AUTO_INCREMENT,
  `date_entrepot` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_entrepot`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_entrepot : ~10 rows (environ)
DELETE FROM `t_entrepot`;
INSERT INTO `t_entrepot` (`id_entrepot`, `date_entrepot`, `etat`) VALUES
	(1, '2023-01-15', 'En stock'),
	(2, '2023-01-16', 'En transit'),
	(3, '2023-01-17', 'En stock'),
	(4, '2023-01-18', 'En transit'),
	(5, '2023-01-19', 'En stock'),
	(6, '2023-01-20', 'En transit'),
	(7, '2023-01-21', 'En stock'),
	(8, '2023-01-22', 'En transit'),
	(9, '2023-01-23', 'En stock'),
	(10, '2023-01-24', 'En transit');

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_lieu
DROP TABLE IF EXISTS `t_lieu`;
CREATE TABLE IF NOT EXISTS `t_lieu` (
  `id_lieu` int NOT NULL AUTO_INCREMENT,
  `nom_lieu` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_lieu`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_lieu : ~4 rows (environ)
DELETE FROM `t_lieu`;
INSERT INTO `t_lieu` (`id_lieu`, `nom_lieu`) VALUES
	(1, 'galta'),
	(2, 'sous sol 1'),
	(3, 'sous sol 2'),
	(4, 'bureau informatique');

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_objets
DROP TABLE IF EXISTS `t_objets`;
CREATE TABLE IF NOT EXISTS `t_objets` (
  `id_objets` int NOT NULL AUTO_INCREMENT,
  `nom_objets` varchar(50) NOT NULL,
  `etat_objets` varchar(50) NOT NULL,
  `numero_serie` varchar(20) NOT NULL,
  `id_retour` int DEFAULT NULL,
  PRIMARY KEY (`id_objets`),
  KEY `fk_id_retour` (`id_retour`),
  CONSTRAINT `fk_id_retour` FOREIGN KEY (`id_retour`) REFERENCES `t_retour` (`id_retour`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_objets : ~10 rows (environ)
DELETE FROM `t_objets`;
INSERT INTO `t_objets` (`id_objets`, `nom_objets`, `etat_objets`, `numero_serie`, `id_retour`) VALUES
	(1, 'Ordinateur portable', 'Fonctionnel', 'SN123456789', NULL),
	(2, 'Imprimante laser', 'Hors service', 'SN987654321', NULL),
	(3, 'Clavier sans fil', 'Fonctionnel', 'SN111222333', NULL),
	(4, 'Souris optique', 'Fonctionnel', 'SN444555666', NULL),
	(5, 'Disque dur externe', 'En réparation', 'SN777888999', NULL),
	(6, 'Écran LCD', 'Fonctionnel', 'SN666555444', NULL),
	(7, 'Routeur sans fil', 'Hors service', 'SN333222111', NULL),
	(8, 'Casque audio', 'Fonctionnel', 'SN999888777', NULL),
	(9, 'Webcam HD', 'Fonctionnel', 'SN123321123', NULL),
	(10, 'Lecteur de cartes mémoire', 'Hors service', 'SN456654456', NULL);

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_personne
DROP TABLE IF EXISTS `t_personne`;
CREATE TABLE IF NOT EXISTS `t_personne` (
  `id_personne` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `mail_entreprise` varchar(100) DEFAULT NULL,
  `id_emprunt` int DEFAULT NULL,
  PRIMARY KEY (`id_personne`),
  KEY `id_emprunt` (`id_emprunt`),
  CONSTRAINT `t_personne_ibfk_1` FOREIGN KEY (`id_emprunt`) REFERENCES `t_emprunt` (`id_emprunt`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_personne : ~10 rows (environ)
DELETE FROM `t_personne`;
INSERT INTO `t_personne` (`id_personne`, `nom`, `prenom`, `service`, `mail_entreprise`, `id_emprunt`) VALUES
	(1, 'Doe', 'John', 'Ressources humaines', 'john.doe@example.com', 1),
	(2, 'Smith', 'Alice', 'Ventes', 'alice.smith@example.com', 2),
	(3, 'Johnson', 'Michael', 'Informatique', 'michael.johnson@example.com', 3),
	(4, 'Williams', 'Jessica', 'Marketing', 'jessica.williams@example.com', 4),
	(5, 'Brown', 'Chris', 'Logistique', 'chris.brown@example.com', 5),
	(6, 'Garcia', 'Maria', 'Finance', 'maria.garcia@example.com', 6),
	(7, 'Martinez', 'David', 'Production', 'david.martinez@example.com', 7),
	(8, 'Lopez', 'Sophia', 'Service client', 'sophia.lopez@example.com', 8),
	(9, 'Lee', 'James', 'Achats', 'james.lee@example.com', 9),
	(10, 'Gonzalez', 'Paula', 'Qualité', 'paula.gonzalez@example.com', 10);

-- Listage de la structure de table raifi_loran_expi1a_inventaire. t_retour
DROP TABLE IF EXISTS `t_retour`;
CREATE TABLE IF NOT EXISTS `t_retour` (
  `id_retour` int NOT NULL AUTO_INCREMENT,
  `date_retour` date DEFAULT NULL,
  `etat` varchar(50) DEFAULT NULL,
  `id_objets` int DEFAULT NULL,
  PRIMARY KEY (`id_retour`),
  KEY `fk_id_objets` (`id_objets`),
  CONSTRAINT `fk_id_objets` FOREIGN KEY (`id_objets`) REFERENCES `t_objets` (`id_objets`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Listage des données de la table raifi_loran_expi1a_inventaire.t_retour : ~7 rows (environ)
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
