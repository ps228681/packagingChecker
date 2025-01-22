/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.6.2-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: hcgroup
-- ------------------------------------------------------
-- Server version	11.6.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `OrderItems_Orders_FK` (`order_id`),
  KEY `OrderItems_Products_FK` (`product_id`),
  CONSTRAINT `OrderItems_Orders_FK` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `OrderItems_Products_FK` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES
(1,1,3,2),
(2,1,16,8),
(3,1,12,3),
(4,2,22,5),
(5,27,42,2),
(6,10,17,5),
(7,50,36,9),
(8,47,4,9),
(9,19,31,4),
(10,8,37,4),
(11,29,42,5),
(12,69,36,12),
(13,65,11,11),
(14,36,42,7),
(15,58,40,7),
(16,13,41,6),
(17,63,25,10),
(18,32,8,3),
(19,47,46,3),
(20,4,9,7),
(21,47,18,2),
(22,26,35,9),
(23,25,8,4),
(24,64,47,1),
(25,21,33,3),
(26,51,32,4),
(27,46,32,1),
(28,21,21,5),
(29,44,29,3),
(30,65,45,1),
(31,65,46,9),
(32,54,16,1),
(33,63,12,11),
(34,10,47,10),
(35,53,39,6),
(36,32,5,10),
(37,31,1,8),
(38,39,32,5),
(39,55,13,4),
(40,13,8,9),
(41,61,44,4),
(42,47,48,5),
(43,63,28,1),
(44,9,4,1),
(45,24,10,7),
(46,38,30,9),
(47,30,10,2),
(48,7,16,3),
(49,39,50,2),
(50,18,41,7),
(51,8,31,11),
(52,36,2,12),
(53,22,21,1),
(54,59,38,5),
(55,18,15,2),
(56,66,9,5),
(57,66,40,11),
(58,23,13,4),
(59,45,29,10),
(60,46,36,10),
(61,63,15,5),
(62,45,18,7),
(63,62,11,8),
(64,61,35,5),
(65,52,29,7),
(66,11,49,4),
(67,51,14,10),
(68,25,25,3),
(69,54,21,3),
(70,9,38,1),
(71,67,2,10),
(72,21,18,8);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_time` datetime DEFAULT NULL,
  `customer_name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES
(1,'2023-10-05 14:30:00','TestUser'),
(2,'2025-01-15 21:39:00','TestUser1'),
(3,'2024-01-01 12:00:00','Customer0'),
(4,'2024-01-01 12:00:00','Customer1'),
(5,'2024-01-01 12:00:00','Customer2'),
(6,'2024-01-01 12:00:00','Customer3'),
(7,'2024-01-01 12:00:00','Customer4'),
(8,'2024-01-01 12:00:00','Customer5'),
(9,'2024-01-01 12:00:00','Customer6'),
(10,'2024-01-01 12:00:00','Customer7'),
(11,'2024-01-01 12:00:00','Customer8'),
(12,'2024-01-01 12:00:00','Customer9'),
(13,'2024-01-01 12:00:00','Customer10'),
(14,'2024-01-01 12:00:00','Customer11'),
(15,'2024-01-01 12:00:00','Customer12'),
(16,'2024-01-01 12:00:00','Customer13'),
(17,'2024-01-01 12:00:00','Customer14'),
(18,'2024-01-01 12:00:00','Customer15'),
(19,'2024-01-01 12:00:00','Customer16'),
(20,'2024-01-01 12:00:00','Customer17'),
(21,'2024-01-01 12:00:00','Customer18'),
(22,'2024-01-01 12:00:00','Customer19'),
(23,'2024-01-01 12:00:00','Customer20'),
(24,'2024-01-01 12:00:00','Customer21'),
(25,'2024-01-01 12:00:00','Customer22'),
(26,'2024-01-01 12:00:00','Customer23'),
(27,'2024-01-01 12:00:00','Customer24'),
(28,'2024-01-01 12:00:00','Customer25'),
(29,'2024-01-01 12:00:00','Customer26'),
(30,'2024-01-01 12:00:00','Customer27'),
(31,'2024-01-01 12:00:00','Customer28'),
(32,'2024-01-01 12:00:00','Customer29'),
(33,'2024-01-01 12:00:00','Customer30'),
(34,'2024-01-01 12:00:00','Customer31'),
(35,'2024-01-01 12:00:00','Customer32'),
(36,'2024-01-01 12:00:00','Customer33'),
(37,'2024-01-01 12:00:00','Customer0'),
(38,'2024-01-01 12:00:00','Customer1'),
(39,'2024-01-01 12:00:00','Customer2'),
(40,'2024-01-01 12:00:00','Customer3'),
(41,'2024-01-01 12:00:00','Customer4'),
(42,'2024-01-01 12:00:00','Customer5'),
(43,'2024-01-01 12:00:00','Customer6'),
(44,'2024-01-01 12:00:00','Customer7'),
(45,'2024-01-01 12:00:00','Customer8'),
(46,'2024-01-01 12:00:00','Customer9'),
(47,'2024-01-01 12:00:00','Customer10'),
(48,'2024-01-01 12:00:00','Customer11'),
(49,'2024-01-01 12:00:00','Customer12'),
(50,'2024-01-01 12:00:00','Customer13'),
(51,'2024-01-01 12:00:00','Customer14'),
(52,'2024-01-01 12:00:00','Customer15'),
(53,'2024-01-01 12:00:00','Customer16'),
(54,'2024-01-01 12:00:00','Customer17'),
(55,'2024-01-01 12:00:00','Customer18'),
(56,'2024-01-01 12:00:00','Customer19'),
(57,'2024-01-01 12:00:00','Customer20'),
(58,'2024-01-01 12:00:00','Customer21'),
(59,'2024-01-01 12:00:00','Customer22'),
(60,'2024-01-01 12:00:00','Customer23'),
(61,'2024-01-01 12:00:00','Customer24'),
(62,'2024-01-01 12:00:00','Customer25'),
(63,'2024-01-01 12:00:00','Customer26'),
(64,'2024-01-01 12:00:00','Customer27'),
(65,'2024-01-01 12:00:00','Customer28'),
(66,'2024-01-01 12:00:00','Customer29'),
(67,'2024-01-01 12:00:00','Customer30'),
(68,'2024-01-01 12:00:00','Customer31'),
(69,'2024-01-01 12:00:00','Customer32'),
(70,'2024-01-01 12:00:00','Customer33');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `packagings`
--

DROP TABLE IF EXISTS `packagings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `packagings` (
  `name` varchar(100) NOT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) NOT NULL,
  `length` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `purchase_price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `packagings`
--

LOCK TABLES `packagings` WRITE;
/*!40000 ALTER TABLE `packagings` DISABLE KEYS */;
INSERT INTO `packagings` VALUES
('A',100,180,250,1,6),
('B',150,230,710,2,10),
('C',180,240,1600,3,23);
/*!40000 ALTER TABLE `packagings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `name` varchar(100) NOT NULL,
  `height` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `width` int(11) DEFAULT NULL,
  `length` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES
('Smartphone',150,1,75,8),
('Bluetooth Speaker',100,2,200,80),
('Wireless Mouse',40,3,60,100),
('USB Flash Drive',10,4,20,60),
('Power Bank',100,5,70,15),
('Headphones',150,6,200,50),
('Smartwatch',40,7,40,10),
('Portable Charger',90,8,60,20),
('External Hard Drive',20,9,80,120),
('Digital Camera',100,10,120,60),
('Action Camera',60,11,40,30),
('Tablet',250,12,180,8),
('E-Reader',200,13,140,8),
('Fitness Tracker',20,14,20,10),
('VR Headset',200,15,250,100),
('Laptop Stand',30,16,300,200),
('Webcam',50,17,100,50),
('Microphone',150,18,50,50),
('Laptop Sleeve',10,19,400,300),
('Phone Case',10,20,80,160),
('Screen Protector',1,21,80,160),
('Cable Organizer',100,22,50,50),
('Wireless Charger',10,23,100,100),
('HDMI Cable',5,24,20,2000),
('Ethernet Cable',5,25,20,2000),
('Phone Stand',100,26,80,80),
('Camera Lens',70,27,70,70),
('Tripod',1000,28,100,100),
('Laptop Charger',30,29,100,200),
('Portable Hard Drive',20,30,80,120),
('SD Card',2,31,24,32),
('Smart Home Hub',30,32,100,100),
('LED Desk Lamp',400,33,150,150),
('Digital Thermometer',150,34,40,20),
('Kitchen Scale',20,35,300,200),
('Measuring Tape',25,36,50,50),
('Screwdriver Set',200,37,50,200),
('Toolbox',200,38,300,150),
('First Aid Kit',100,39,200,150),
('Travel Mug',200,40,80,80),
('Water Bottle',250,41,70,70),
('Lunch Box',100,42,200,150),
('Umbrella',800,43,100,100),
('Keychain',5,44,30,10),
('Flashlight',150,45,40,40),
('Pocket Knife',20,46,50,100),
('Sunglasses',50,47,150,50),
('Wallet',20,48,100,150),
('Business Card Holder',10,49,100,60),
('Notebook',200,50,150,10),
('Pen',15,51,15,150);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hcgroup'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-01-22  3:36:44
