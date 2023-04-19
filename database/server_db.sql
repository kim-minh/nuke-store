# ************************************************************
# SQL dump
#
# Host: 127.0.0.1 (MySQL 8.0.32)
# Database: server
# Generation Time: 2023-04-18 20:48:00 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table accounts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `customerNumber` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table brand
# ------------------------------------------------------------

DROP TABLE IF EXISTS `brand`;

CREATE TABLE `brand` (
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `establish` year DEFAULT NULL,
  `description` tinytext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;

INSERT INTO `brand` (`name`, `establish`, `description`)
VALUES
	('Adidas','1924','Adidas AG is a German multinational corporation, founded and headquartered in Herzogenaurach, Bavaria, that designs and manufactures shoes, clothing and accessories.'),
	('Air Jordan','1985','Air Jordan is a line of basketball shoes and athletic apparel produced by American corporation Nike, Inc.'),
	('Nike','1964','Nike, Inc. is an American multinational corporation that is engaged in the design, development, manufacturing, and worldwide marketing and sales of footwear, apparel, equipment, accessories, and services.'),
	('Under Armour','1996','Under Armour, Inc. is an American sportswear company that manufactures footwear and apparel. Under Armour\'s global headquarters are located in Baltimore, Maryland.');

/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table customers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customerNumber` int unsigned NOT NULL,
  `name` tinytext NOT NULL,
  `phoneNumber` varchar(12) NOT NULL,
  `address` tinytext NOT NULL,
  `creditCard` text NOT NULL,
  `supportAgent` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`customerNumber`),
  KEY `supportAgent` (`supportAgent`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `accounts` (`customerNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customers_ibfk_2` FOREIGN KEY (`supportAgent`) REFERENCES `employees` (`employeeNumber`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table employees
# ------------------------------------------------------------

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `employeeNumber` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext NOT NULL,
  `email` varchar(45) NOT NULL,
  `jobTitle` varchar(45) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;

INSERT INTO `employees` (`employeeNumber`, `name`, `email`, `jobTitle`)
VALUES
	(1,'Minh','minh@nuke.com','SalesRep'),
	(2,'Thanh','thanh@nuke.com','SalesRep'),
	(3,'Trung','trung@nuke.com','SalesRep'),
	(4,'Quyet','quyet@nuke.com','SalesRep');

/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orderdetails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `orderNumber` int unsigned NOT NULL,
  `shoesProperty` int unsigned NOT NULL,
  `discount` float NOT NULL,
  `quantityOrdered` int unsigned NOT NULL,
  `comments` tinytext,
  PRIMARY KEY (`orderNumber`),
  KEY `shoesProperty` (`shoesProperty`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`shoesProperty`) REFERENCES `properties` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table orders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `orderNumber` int unsigned NOT NULL AUTO_INCREMENT,
  `customerNumber` int unsigned NOT NULL,
  `orderedDate` date NOT NULL,
  `requiredDate` date DEFAULT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `paymentID` int unsigned NOT NULL AUTO_INCREMENT,
  `customerNumber` int unsigned NOT NULL,
  `paymentDate` date NOT NULL,
  `amount` int unsigned NOT NULL,
  PRIMARY KEY (`paymentID`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



# Dump of table properties
# ------------------------------------------------------------

DROP TABLE IF EXISTS `properties`;

CREATE TABLE `properties` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT,
  `shoesID` int unsigned NOT NULL,
  `color` varchar(45) DEFAULT NULL,
  `size` int unsigned NOT NULL,
  `edition` year DEFAULT NULL,
  `quantityInStock` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `shoesID` (`shoesID`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`shoesID`) REFERENCES `shoes` (`shoesID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;

INSERT INTO `properties` (`ID`, `shoesID`, `color`, `size`, `edition`, `quantityInStock`)
VALUES
	(1,100,'red',9,'2022',8),
	(2,100,'red',10,'2022',5),
	(3,100,'red',11,'2022',7),
	(4,99,'pink',9,'2021',6),
	(5,99,'pink',10,'2021',9),
	(6,99,'pink',11,'2021',3),
	(7,98,'blue',9,'2020',4),
	(8,98,'blue ',10,'2020',6),
	(9,98,'blue',11,'2020',5),
	(10,97,'black',9,'2021',6),
	(11,97,'black',10,'2021',7),
	(12,97,'black',11,'2021',8),
	(13,96,'yellow',9,'2020',6),
	(14,96,'yellow',10,'2020',4),
	(15,96,'yellow',11,'2020',7),
	(16,95,'green',9,'2020',6),
	(17,95,'green',10,'2020',7),
	(18,95,'green',11,'2020',3),
	(19,94,'grey',9,'2020',7),
	(20,94,'grey',10,'2020',6),
	(21,94,'grey',11,'2020',5),
	(22,94,'red',9,'2020',4),
	(23,94,'red',10,'2020',7),
	(24,94,'red',11,'2020',8),
	(25,93,'white',9,'2021',5),
	(26,93,'white',10,'2021',6),
	(27,93,'white',11,'2021',6),
	(28,92,'black',9,'2021',7),
	(29,92,'black',10,'2021',8),
	(30,92,'black',11,'2021',9),
	(31,91,'orange',9,'2021',5),
	(32,91,'orange',10,'2021',6),
	(33,91,'orange',11,'2021',6),
	(34,90,'purple',9,'2022',4),
	(35,90,'purple',10,'2022',3),
	(36,90,'purple',11,'2022',6),
	(37,89,'green',9,'2021',7),
	(38,89,'green',10,'2021',6),
	(39,89,'green',11,'2021',6),
	(40,88,'blue',9,'2022',8),
	(41,88,'blue',10,'2022',9),
	(42,88,'blue',11,'2022',6),
	(43,88,'black',9,'2022',7),
	(44,88,'black',10,'2022',8),
	(45,88,'black',11,'2022',6),
	(46,87,'white',9,'2021',8),
	(47,87,'white',10,'2021',6),
	(48,87,'white',11,'2021',7),
	(49,86,'red',9,'2021',8),
	(50,86,'red',10,'2021',7),
	(51,86,'red',11,'2021',4),
	(52,85,'black',9,'2022',6),
	(53,85,'black',10,'2022',8),
	(54,85,'black',11,'2022',9),
	(55,84,'grey',9,'2021',5),
	(56,84,'grey',10,'2021',6),
	(57,84,'grey',11,'2021',7),
	(58,83,'pink',9,'2020',6),
	(59,83,'pink',10,'2020',7),
	(60,83,'pink',11,'2020',7),
	(61,82,'white',9,'2021',5),
	(62,82,'white',10,'2021',4),
	(63,82,'white',11,'2021',4),
	(64,81,'gold',9,'2021',7),
	(65,81,'gold',10,'2021',6),
	(66,81,'gold',11,'2021',6),
	(67,80,'yellow',9,'2020',8),
	(68,80,'yellow',10,'2020',7),
	(69,80,'yellow',11,'2020',7),
	(70,80,'green',9,'2021',3),
	(71,80,'green',10,'2021',4),
	(72,80,'green',11,'2021',4),
	(73,79,'blue',9,'2021',8),
	(74,79,'blue',10,'2021',7),
	(75,79,'blue',11,'2021',6),
	(76,78,'cyan',9,'2020',7),
	(77,78,'cyan',10,'2020',6),
	(78,78,'cyan',11,'2020',6),
	(79,77,'purple',9,'2021',7),
	(80,77,'purple',10,'2021',7),
	(81,77,'purple',11,'2021',6),
	(82,76,'yellow',9,'2020',4),
	(83,76,'yellow',10,'2020',5),
	(84,76,'yellow',11,'2020',5),
	(85,75,'white',9,'2021',4),
	(86,75,'white',10,'2021',5),
	(87,75,'white',11,'2021',6),
	(88,74,'black',9,'2022',7),
	(89,74,'black',10,'2022',6),
	(90,74,'black',11,'2022',7),
	(91,73,'green',9,'2022',8),
	(92,73,'green',10,'2022',6),
	(93,73,'green',11,'2022',5),
	(94,72,'cyan',9,'2022',4),
	(95,72,'cyan',10,'2022',7),
	(96,72,'cyan',11,'2022',6),
	(97,71,'blue',9,'2021',6),
	(98,71,'blue',10,'2021',5),
	(99,71,'blue',11,'2021',5),
	(100,70,'black',9,'2020',6),
	(101,70,'black',10,'2020',5),
	(102,70,'black',11,'2020',4),
	(103,70,'white',9,'2020',5),
	(104,70,'white',10,'2020',6),
	(105,70,'white',11,'2020',4),
	(106,69,'red',9,'2021',7),
	(107,69,'red',10,'2021',6),
	(108,69,'red',11,'2021',6),
	(109,69,'orange',9,'2021',8),
	(110,69,'orange',10,'2021',7),
	(111,69,'orange',11,'2021',7),
	(112,68,'purple',9,'2020',6),
	(113,68,'purple',10,'2020',6),
	(114,68,'purple',11,'2020',5),
	(115,68,'pink',9,'2020',4),
	(116,68,'pink',10,'2020',5),
	(117,68,'pink',11,'2020',6),
	(118,67,'red',9,'2022',7),
	(119,67,'red',10,'2022',6),
	(120,67,'red',11,'2022',6),
	(121,67,'white',9,'2022',5),
	(122,67,'white',10,'2022',6),
	(123,67,'white',11,'2022',5),
	(124,66,'black',9,'2021',8),
	(125,66,'black',10,'2021',6),
	(126,66,'black',11,'2021',5),
	(127,66,'blue',9,'2021',8),
	(128,66,'blue',10,'2021',7),
	(129,66,'blue',11,'2021',6),
	(130,65,'green',9,'2020',6),
	(131,65,'green',10,'2020',3),
	(132,65,'green',11,'2020',4),
	(133,65,'yellow',9,'2020',3),
	(134,65,'yellow',10,'2020',4),
	(135,65,'yellow',11,'2020',5),
	(136,64,'cyan',9,'2022',6),
	(137,64,'cyan',10,'2022',5),
	(138,64,'cyan',11,'2022',6),
	(139,64,'grey',9,'2022',4),
	(140,64,'grey',10,'2022',5),
	(141,64,'grey',11,'2022',5),
	(142,63,'black',9,'2021',6),
	(143,63,'black',10,'2021',5),
	(144,63,'black',11,'2021',4),
	(145,63,'white',9,'2021',8),
	(146,63,'white',10,'2021',5),
	(147,63,'white',11,'2021',6),
	(148,62,'purple',9,'2020',5),
	(149,62,'purple',10,'2020',6),
	(150,62,'purple',11,'2020',8),
	(151,62,'blue',9,'2020',6),
	(152,62,'blue',10,'2020',5),
	(153,62,'blue',11,'2020',7),
	(154,61,'orange',9,'2022',6),
	(155,61,'orange',10,'2022',5),
	(156,61,'orange',11,'2022',7),
	(157,61,'gold',9,'2022',4),
	(158,61,'gold',10,'2022',5),
	(159,61,'gold',11,'2022',6);

/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table shoes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shoes`;

CREATE TABLE `shoes` (
  `shoesID` int unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `brand` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` int unsigned DEFAULT NULL,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`shoesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `shoes` WRITE;
/*!40000 ALTER TABLE `shoes` DISABLE KEYS */;

INSERT INTO `shoes` (`shoesID`, `name`, `brand`, `price`, `type`)
VALUES
	(61,'Under Armour Drive 4','Under Armour',100,'Lifestyle'),
	(62,'Nike Waffle','Nike',120,'Lifestyle'),
	(63,'Stan Smith','Adidas',100,'Lifestyle'),
	(64,'Yeezy 700','Adidas',200,'Lifestyle'),
	(65,'Yeezy 350','Adidas',200,'Lifestyle'),
	(66,'Human Race','Adidas',200,'Lifestyle'),
	(67,'Kobe 5 Protro','Nike',200,'Basketball'),
	(68,'Kobe 6 Protro','Nike',200,'Basketball'),
	(69,'Dame 7','Adidas',120,'Basketball'),
	(70,'Dame 8 ','Adidas',140,'Basketball'),
	(71,'Lebron Soldier 13','Nike',120,'Basketball'),
	(72,'Lebron Soldier 14','Nike',150,'Basketball'),
	(73,'Cosmic Unity ','Nike',150,'Basketball'),
	(74,'Cosmic Unity 2','Nike',180,'Basketball'),
	(75,'Pegasus','Nike',150,'Running'),
	(76,'Air Force 1','Nike ',150,'Lifestyle'),
	(77,'Ultraboost 21','Adidas',150,'Running'),
	(78,'Ultraboost 22','Adidas',200,'Running'),
	(79,'Freak 4','Nike',140,'Basketball'),
	(80,'Curry IX','Under Armour',120,'Basketball'),
	(81,'Curry X','Under Armour',150,'Basketball'),
	(82,'Harden Vol.6','Adidas',120,'Basketball'),
	(83,'Harden Vol.7','Adidas',140,'Basketball'),
	(84,'Jordan I ','Air Jordan',200,'Lifestyle'),
	(85,'Jordan XI','Air Jordan',120,'Basketball'),
	(86,'Jordan XII','Air Jordan',120,'Basketball'),
	(87,'Jordan XXXV','Air Jordan',130,'Basketball'),
	(88,'Jordan XXXVI','Air Jordan',150,'Basketball'),
	(89,'Jordan XXXVII','Air Jordan',180,'Basketball'),
	(90,'WNZ5','Air Jordan',130,'Basketball'),
	(91,'WNZ6','Air Jordan',150,'Basketball'),
	(92,'KD14','Nike',140,'Basketball'),
	(93,'KD15','Nike',150,'Basketball'),
	(94,'PG5','Nike ',110,'Basketball'),
	(95,'PG6','Nike',120,'Basketball'),
	(96,'Kyrie VII','Nike ',120,'Basketball'),
	(97,'Kyrie Infinity','Nike',150,'Basketball'),
	(98,'Lebron XVIII','Nike',180,'Basketball'),
	(99,'Lebron XIX','Nike',180,'Basketball'),
	(100,'Lebron XX','Nike',200,'Basketball');

/*!40000 ALTER TABLE `shoes` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
