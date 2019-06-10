-- Rotterdam Metro (RET) script
--    NAME
--     ret.sql - Create data objects for Assignment 2 INFO20003
--
--    DESCRIPTION
--    This creates the Rotterdam Metro tables and data


-- BYOD INSTALL SECTION
-- remove the comments -- from the following 3 lines for BYOD installs
-- DROP SCHEMA IF EXISTS `ret` ;
-- CREATE SCHEMA IF NOT EXISTS `ret` DEFAULT CHARACTER SET utf8 ;
-- USE `ret` ;

-- END BYOD INSTALL SECTION

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `customerID` int(10) unsigned NOT NULL,
  `username` char(20) NOT NULL,
  `faretype` tinyint(1) NOT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'alice','1'),(2,'bob','1'),(3,'carol','1'),(4,'dan','0'),(5,'eve','1'),(6,'franco', '0');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Table structure for table `journey`
--

DROP TABLE IF EXISTS `journey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journey` (
  `journeyID` bigint(20) unsigned NOT NULL,
  `customerID` int(10) unsigned NOT NULL,
  `startStationID` tinyint(3) unsigned NOT NULL,
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endStationID` tinyint(3) unsigned NOT NULL,
  `endTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`journeyID`),
  KEY `fk_Journey_Station2_idx` (`startStationID`),
  KEY `fk_journey_station1_idx` (`endStationID`),
  KEY `fk_journey_Customer1` (`customerID`),
  CONSTRAINT `fk_Journey_Station2` FOREIGN KEY (`startStationID`) REFERENCES `station` (`stationID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_Customer1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_journey_station1` FOREIGN KEY (`endStationID`) REFERENCES `station` (`stationID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journey`
--

LOCK TABLES `journey` WRITE;
/*!40000 ALTER TABLE `journey` DISABLE KEYS */;
INSERT INTO `journey` VALUES 
(1,1,4,'2018-01-31 14:01:00',3,'2018-01-31 14:03:00'),
(2,2,4,'2018-01-31 15:02:00',2,'2018-01-31 15:06:00'),
(3,3,4,'2018-01-31 16:03:00',1,'2018-01-31 16:08:00'),
(4,4,3,'2018-01-31 17:04:00',2,'2018-01-31 17:05:00'),
(5,5,3,'2018-01-31 18:05:00',1,'2018-01-31 18:09:00'),
(6,1,2,'2018-01-31 19:06:00',1,'2018-01-31 19:08:00'),
(7,2,1,'2018-01-31 20:07:00',11,'2018-01-31 20:14:00'),
(8,3,4,'2018-01-31 21:08:00',9,'2018-01-31 21:14:00'),
(9,4,4,'2018-01-31 22:09:00',10,'2018-01-31 22:17:00'),
(10,5,4,'2018-02-01 23:10:00',11,'2018-02-01 23:22:00'),
(11,1,8,'2018-02-02 00:11:00',7,'2018-02-02 00:13:00'),
(12,2,8,'2018-02-02 01:12:00',7,'2018-02-02 01:14:00'),
(13,3,8,'2018-02-02 02:13:00',7,'2018-02-02 02:16:00'),
(14,4,7,'2018-02-02 03:14:00',8,'2018-02-02 03:16:00'),
(15,1,7,'2018-02-02 04:15:00',8,'2018-02-02 04:16:00'),
(16,2,8,'2018-02-02 05:16:00',5,'2018-02-02 05:20:00'),
(17,3,8,'2018-02-03 06:17:00',1,'2018-02-03 06:23:00'),
(18,1,8,'2018-02-03 07:18:00',10,'2018-02-03 07:31:00'),
(19,2,8,'2018-02-03 08:19:00',11,'2018-02-03 08:33:00'),
(20,1,1,'2018-02-03 09:20:00',11,'2018-02-03 09:26:00');
/*!40000 ALTER TABLE `journey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `line`
--

DROP TABLE IF EXISTS `line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line` (
  `lineID` tinyint(3) unsigned NOT NULL,
  `lineName` varchar(50) NOT NULL,
  PRIMARY KEY (`lineID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `line`
--

LOCK TABLES `line` WRITE;
/*!40000 ALTER TABLE `line` DISABLE KEYS */;
INSERT INTO `line` VALUES (0,'Centraal'),(1,'Northern'),(2,'Western'),(3,'Eastern');
/*!40000 ALTER TABLE `line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station` (
  `stationID` tinyint(3) unsigned NOT NULL,
  `stationName` varchar(50) NOT NULL,
  `lineID` tinyint(3) unsigned NOT NULL,
  `sequence` tinyint(3) NOT NULL,
  `zone` char(1) NOT NULL,
  PRIMARY KEY (`stationID`),
  KEY `fk_Station_Line1_idx` (`lineID`),
  CONSTRAINT `fk_Station_Line1` FOREIGN KEY (`lineID`) REFERENCES `line` (`lineID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'Centraal',0,0,'1'),(2,'Blijdorp',1,1,'1'),(3,'Meijersplein',1,2,'2'),(4,'Rodenrijs',1,3,'2'),(5,'Coolhaven',2,1,'1'),(6,'Marconiplein',2,2,'1'),(7,'Parkweg',2,3,'2'),(8,'Tussenwater',2,4,'2'),(9,'Blaak',3,1,'1'),(10,'Oostplein',3,2,'1'),(11,'Capelsebrug',3,3,'2');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

