# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.5.6-MariaDB)
# Datenbank: nodedb
# Erstellt am: 2021-01-29 22:48:03 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Export von Tabelle admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vorname` varchar(255) DEFAULT NULL,
  `nachname` varchar(255) DEFAULT NULL,
  `studiengang` varchar(11) DEFAULT NULL,
  `semester` int(2) DEFAULT NULL,
  `matrikelnr` int(6) DEFAULT NULL,
  `username` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;

INSERT INTO `admins` (`id`, `vorname`, `nachname`, `studiengang`, `semester`, `matrikelnr`, `username`, `password`)
VALUES
	(1,'Oliver','Gorczyca','INI',3,935160,'oli','1234');

/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle fach
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fach`;

CREATE TABLE `fach` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `fachname` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `fach` WRITE;
/*!40000 ALTER TABLE `fach` DISABLE KEYS */;

INSERT INTO `fach` (`id`, `fachname`)
VALUES
	(1,'Mathe'),
	(2,'Informatik'),
	(3,'Deutsch'),
	(4,'Englisch'),
	(5,'Sport'),
	(6,'Politik');

/*!40000 ALTER TABLE `fach` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle lehrer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lehrer`;

CREATE TABLE `lehrer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `l_vorname` varchar(20) NOT NULL DEFAULT '',
  `l_nachname` varchar(20) NOT NULL DEFAULT '',
  `l_email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `lehrer` WRITE;
/*!40000 ALTER TABLE `lehrer` DISABLE KEYS */;

INSERT INTO `lehrer` (`id`, `l_vorname`, `l_nachname`, `l_email`)
VALUES
	(1,'Günther','Strauch','g.s@schule.de'),
	(2,'Dieter','Mann','dn@gmail.com'),
	(3,'Dieter','Rams','dr@gmail.com'),
	(4,'Hans','Deuter','hd@gmail.com'),
	(5,'Rudi','Rademann','rr@gmail.com'),
	(6,'Sven','Ritter','sr@gmail.com'),
	(7,'Eberhard','Wiese','ew@gmail.com'),
	(8,'Franz','Bremer','fb@gmail.com'),
	(9,'Paul','Hans','ph@gmail.com'),
	(10,'Gunnar','Uhrenmacher','gu@gmail.com');

/*!40000 ALTER TABLE `lehrer` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle lehrt
# ------------------------------------------------------------

DROP TABLE IF EXISTS `lehrt`;

CREATE TABLE `lehrt` (
  `lehrer_id` int(11) unsigned NOT NULL,
  `fach_id` int(11) unsigned NOT NULL,
  `wochenstunden` int(11) unsigned NOT NULL,
  `schuljahr` int(11) unsigned NOT NULL,
  KEY `fach_id` (`fach_id`),
  KEY `lehrer_id` (`lehrer_id`),
  CONSTRAINT `lehrt_ibfk_1` FOREIGN KEY (`lehrer_id`) REFERENCES `lehrer` (`id`),
  CONSTRAINT `lehrt_ibfk_2` FOREIGN KEY (`fach_id`) REFERENCES `fach` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `lehrt` WRITE;
/*!40000 ALTER TABLE `lehrt` DISABLE KEYS */;

INSERT INTO `lehrt` (`lehrer_id`, `fach_id`, `wochenstunden`, `schuljahr`)
VALUES
	(1,2,134,4),
	(4,3,5,3),
	(3,1,10,2),
	(6,5,20,1),
	(5,4,15,1),
	(4,6,12,3),
	(7,6,12,3),
	(3,6,12,3);

/*!40000 ALTER TABLE `lehrt` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle pruefen
# ------------------------------------------------------------

DROP TABLE IF EXISTS `pruefen`;

CREATE TABLE `pruefen` (
  `lehrer_id` int(11) unsigned NOT NULL,
  `schueler_id` int(11) unsigned NOT NULL,
  `note` int(11) unsigned NOT NULL,
  `fach_id` int(11) unsigned NOT NULL,
  KEY `fach_id` (`fach_id`),
  KEY `schueler_id` (`schueler_id`),
  KEY `lehrer_id` (`lehrer_id`),
  CONSTRAINT `pruefen_ibfk_1` FOREIGN KEY (`lehrer_id`) REFERENCES `lehrer` (`id`),
  CONSTRAINT `pruefen_ibfk_2` FOREIGN KEY (`schueler_id`) REFERENCES `schueler` (`id`),
  CONSTRAINT `pruefen_ibfk_3` FOREIGN KEY (`fach_id`) REFERENCES `fach` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `pruefen` WRITE;
/*!40000 ALTER TABLE `pruefen` DISABLE KEYS */;

INSERT INTO `pruefen` (`lehrer_id`, `schueler_id`, `note`, `fach_id`)
VALUES
	(3,1,1,1),
	(6,2,1,3),
	(5,2,1,4),
	(4,3,1,3),
	(1,4,2,2),
	(1,4,2,2),
	(1,4,1,2),
	(6,4,1,5),
	(1,4,3,2),
	(3,5,1,1),
	(2,6,5,6),
	(1,6,3,2),
	(6,7,1,5),
	(1,8,1,2),
	(1,8,1,2),
	(4,10,1,3);

/*!40000 ALTER TABLE `pruefen` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle raum
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raum`;

CREATE TABLE `raum` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `raumart` varchar(30) NOT NULL DEFAULT '',
  `sitzplaetze` int(11) NOT NULL,
  `raumbezeichner` varchar(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `raum` WRITE;
/*!40000 ALTER TABLE `raum` DISABLE KEYS */;

INSERT INTO `raum` (`id`, `raumart`, `sitzplaetze`, `raumbezeichner`)
VALUES
	(1,'Klassenzimmer',30,'101'),
	(2,'Lehrerzimmer',13,'002'),
	(3,'Sekretariat',2,'001'),
	(4,'Computerraum',28,'105'),
	(5,'Abstellkammer',0,'102'),
	(6,'Nachsitzraum',10,'119'),
	(7,'Nachsitzraum',11,'120'),
	(8,'Computerraum',40,'112');

/*!40000 ALTER TABLE `raum` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle raumverwendung
# ------------------------------------------------------------

DROP TABLE IF EXISTS `raumverwendung`;

CREATE TABLE `raumverwendung` (
  `klassen_id` int(10) unsigned NOT NULL,
  `raum_id` int(11) unsigned NOT NULL,
  KEY `klassen_id` (`klassen_id`),
  KEY `raum_id` (`raum_id`),
  CONSTRAINT `raumverwendung_ibfk_1` FOREIGN KEY (`klassen_id`) REFERENCES `schulklasse` (`id`),
  CONSTRAINT `raumverwendung_ibfk_2` FOREIGN KEY (`raum_id`) REFERENCES `raum` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `raumverwendung` WRITE;
/*!40000 ALTER TABLE `raumverwendung` DISABLE KEYS */;

INSERT INTO `raumverwendung` (`klassen_id`, `raum_id`)
VALUES
	(1,5),
	(1,3),
	(5,2),
	(5,1);

/*!40000 ALTER TABLE `raumverwendung` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle schueler
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schueler`;

CREATE TABLE `schueler` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `s_vorname` varchar(30) NOT NULL DEFAULT '',
  `s_nachname` varchar(30) NOT NULL DEFAULT '',
  `s_schuljahr` int(11) unsigned NOT NULL,
  `klassen_id` int(11) unsigned DEFAULT NULL,
  `s_email` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `klassen_id` (`klassen_id`),
  CONSTRAINT `schueler_ibfk_1` FOREIGN KEY (`klassen_id`) REFERENCES `schulklasse` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `schueler` WRITE;
/*!40000 ALTER TABLE `schueler` DISABLE KEYS */;

INSERT INTO `schueler` (`id`, `s_vorname`, `s_nachname`, `s_schuljahr`, `klassen_id`, `s_email`)
VALUES
	(1,'Fabian','Ostermann',2,NULL,NULL),
	(2,'Dieter','Nuhr',1,NULL,NULL),
	(3,'Adrian','Herrmann',3,NULL,''),
	(4,'Dennis','Ohlsen',3,NULL,''),
	(5,'Emil','Bauer',1,NULL,''),
	(6,'Gulliver','Hood',1,NULL,'talktotheG@hood.com'),
	(7,'Fridolin','Buderson',4,NULL,''),
	(8,'Jannes','Leonard',1,NULL,''),
	(9,'Hannes','Orion',2,NULL,''),
	(10,'Georg','Mann',4,NULL,''),
	(14,'Gulliver','Hund',1,1,'talktotheG@hood.com');

/*!40000 ALTER TABLE `schueler` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle schulklasse
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schulklasse`;

CREATE TABLE `schulklasse` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `klassenlehrer_id` int(11) unsigned DEFAULT NULL,
  `klassensprecher_id` int(11) unsigned DEFAULT NULL,
  `jahrgang` int(2) NOT NULL,
  `bezeichner` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `klassenlehrer_id` (`klassenlehrer_id`),
  KEY `klassensprecher_id` (`klassensprecher_id`),
  CONSTRAINT `schulklasse_ibfk_1` FOREIGN KEY (`klassenlehrer_id`) REFERENCES `lehrer` (`id`),
  CONSTRAINT `schulklasse_ibfk_2` FOREIGN KEY (`klassensprecher_id`) REFERENCES `schueler` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `schulklasse` WRITE;
/*!40000 ALTER TABLE `schulklasse` DISABLE KEYS */;

INSERT INTO `schulklasse` (`id`, `klassenlehrer_id`, `klassensprecher_id`, `jahrgang`, `bezeichner`)
VALUES
	(1,NULL,NULL,1,'a'),
	(2,NULL,NULL,1,'b'),
	(3,NULL,NULL,1,'c'),
	(4,NULL,NULL,2,'a'),
	(5,NULL,NULL,2,'d'),
	(9,NULL,NULL,2,'b');

/*!40000 ALTER TABLE `schulklasse` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle unterrichtet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `unterrichtet`;

CREATE TABLE `unterrichtet` (
  `fach_id` int(11) unsigned NOT NULL,
  `klassen_id` int(11) unsigned NOT NULL,
  `lehrer_id` int(11) unsigned NOT NULL,
  KEY `klassen_id` (`klassen_id`),
  KEY `lehrer_id` (`lehrer_id`),
  KEY `fach_id` (`fach_id`),
  CONSTRAINT `unterrichtet_ibfk_2` FOREIGN KEY (`klassen_id`) REFERENCES `schulklasse` (`id`),
  CONSTRAINT `unterrichtet_ibfk_3` FOREIGN KEY (`fach_id`) REFERENCES `fach` (`id`),
  CONSTRAINT `unterrichtet_ibfk_4` FOREIGN KEY (`lehrer_id`) REFERENCES `lehrer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `unterrichtet` WRITE;
/*!40000 ALTER TABLE `unterrichtet` DISABLE KEYS */;

INSERT INTO `unterrichtet` (`fach_id`, `klassen_id`, `lehrer_id`)
VALUES
	(2,1,1),
	(3,1,3),
	(5,1,4),
	(4,1,5),
	(1,1,2);

/*!40000 ALTER TABLE `unterrichtet` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
