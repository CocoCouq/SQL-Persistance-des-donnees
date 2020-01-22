-- MySQL dump 10.13  Distrib 5.7.26, for osx10.9 (x86_64)
--
-- Host: localhost    Database: papyrus
-- ------------------------------------------------------
-- Server version	5.7.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `entcom`
--

DROP TABLE IF EXISTS `entcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entcom` (
  `NUMCOM` int(11) NOT NULL,
  `OBSCOM` varchar(50) DEFAULT NULL,
  `DATCOM` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NUMFOU` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMCOM`),
  KEY `NUMFOU` (`NUMFOU`),
  CONSTRAINT `entcom_ibfk_1` FOREIGN KEY (`NUMFOU`) REFERENCES `fournis` (`NUMFOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entcom`
--

LOCK TABLES `entcom` WRITE;
/*!40000 ALTER TABLE `entcom` DISABLE KEYS */;
INSERT INTO `entcom` VALUES (70010,'','2007-02-10 11:58:47',120),(70011,'Commande Urgente','2007-03-01 12:10:40',540),(70020,'','2007-04-25 08:45:11',9180),(70025,'Commande Urgente','2007-04-30 19:00:01',9150),(70210,'Commande Condencée','2007-05-05 06:24:50',120),(70250,'Commande Condencée','2007-10-02 14:06:20',8700),(70300,'','2007-06-06 07:53:47',9120),(70620,'','2007-10-02 10:00:15',540),(70625,'','2007-10-17 12:41:00',120),(70629,'','2007-10-12 17:31:19',9180);
/*!40000 ALTER TABLE `entcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fournis`
--

DROP TABLE IF EXISTS `fournis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fournis` (
  `NUMFOU` int(11) NOT NULL,
  `NOMFOU` varchar(25) NOT NULL,
  `RUEFOU` varchar(50) NOT NULL,
  `POSFOU` char(5) NOT NULL,
  `VILFOU` varchar(30) NOT NULL,
  `CONFOU` varchar(15) NOT NULL,
  `SATISF` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`NUMFOU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fournis`
--

LOCK TABLES `fournis` WRITE;
/*!40000 ALTER TABLE `fournis` DISABLE KEYS */;
INSERT INTO `fournis` VALUES (120,'GROBRIGAN','20 rue du papier','92200','Papercity','Georges',8),(540,'ECLIPSE','53 rue Laisse Flotter les rubans','78250','Bugbug-Ville','Nestor',7),(8700,'MEDICIS','120 rue des Plantes','75014','Paris','Lison',0),(9120,'DISCOBOL','11 rue des Sports','85100','La Roche sur Yon','Hercule',8),(9150,'DEPANPAP','26 avenue des Locomotives','59987','Corocountry','Pollux',5),(9180,'HURRYTAPE','68 boulevard des Octets','04044','Dumpville','Track',0);
/*!40000 ALTER TABLE `fournis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ligcom`
--

DROP TABLE IF EXISTS `ligcom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ligcom` (
  `NUMLIG` tinyint(3) NOT NULL,
  `QTECDE` int(10) NOT NULL,
  `PRIUNI` decimal(9,2) NOT NULL,
  `QTELIV` int(10) DEFAULT NULL,
  `DERLIV` date NOT NULL,
  `NUMCOM` int(11) NOT NULL,
  `CODART` char(4) NOT NULL,
  PRIMARY KEY (`NUMLIG`,`NUMCOM`),
  KEY `NUMCOM` (`NUMCOM`),
  KEY `CODART` (`CODART`),
  CONSTRAINT `ligcom_ibfk_1` FOREIGN KEY (`NUMCOM`) REFERENCES `entcom` (`NUMCOM`),
  CONSTRAINT `ligcom_ibfk_2` FOREIGN KEY (`CODART`) REFERENCES `produit` (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ligcom`
--

LOCK TABLES `ligcom` WRITE;
/*!40000 ALTER TABLE `ligcom` DISABLE KEYS */;
INSERT INTO `ligcom` VALUES (1,3000,470.00,3000,'2007-03-15',70010,'I100'),(1,1000,600.00,1000,'2007-05-16',70011,'I105'),(1,200,140.00,0,'2007-12-31',70020,'B001'),(1,1000,590.00,1000,'2007-05-15',70025,'I100'),(1,1000,470.00,1000,'2007-07-15',70210,'I100'),(1,15000,4900.00,12000,'2007-12-15',70250,'P230'),(1,50,790.00,50,'2007-10-31',70300,'I110'),(1,200,600.00,200,'2007-11-01',70620,'I105'),(1,1000,470.00,1000,'2007-10-15',70625,'I100'),(1,200,140.00,0,'2007-12-31',70629,'B001'),(2,2000,485.00,2000,'2007-07-05',70010,'I105'),(2,200,140.00,0,'2007-12-31',70020,'B002'),(2,500,590.00,500,'2007-05-15',70025,'I105'),(2,10000,3500.00,10000,'2007-08-31',70210,'P220'),(2,10000,3350.00,10000,'2007-11-10',70250,'P220'),(2,10000,3500.00,10000,'2007-10-31',70625,'P220'),(2,200,140.00,0,'2007-12-31',70629,'B002'),(3,1000,680.00,1000,'2007-08-20',70010,'I108'),(4,200,40.00,250,'2007-02-20',70010,'D035'),(5,6000,3500.00,6000,'2007-03-31',70010,'P220'),(6,6000,2000.00,2000,'2007-03-31',70010,'P240');
/*!40000 ALTER TABLE `ligcom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produit`
--

DROP TABLE IF EXISTS `produit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produit` (
  `CODART` char(4) NOT NULL,
  `LIBART` varchar(30) NOT NULL,
  `STKALE` int(11) NOT NULL,
  `STKPHY` int(11) NOT NULL,
  `QTEANN` int(11) NOT NULL,
  `UNIMES` char(5) NOT NULL,
  PRIMARY KEY (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produit`
--

LOCK TABLES `produit` WRITE;
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
INSERT INTO `produit` VALUES ('B001','Bande manétiques 1200',20,12,410,'unité'),('B002','Bande manétiques 6250',20,12,410,'unité'),('D035','CD R slim 80 mm',40,42,150,'B010'),('D050','CD R-W 80 mm',50,4,0,'B010'),('I100','Papier 1 ex continu',100,557,3500,'B1000'),('I105','Papier 2 ex continu',75,5,2300,'B1000'),('I108','Papier 3 ex continu',200,557,3500,'B500'),('I110','Papier 4 ex continu',10,12,63,'B400'),('P220','Pré imprimé commande',500,2500,24500,'B500'),('P230','Pré imprimé facture',500,250,12500,'B500'),('P240','Pré imprimé bulletin paie',500,3000,6250,'B500'),('P250','Pré imprimé bon livraison',500,2500,24500,'B500'),('P270','Pré imprimé bon fabrication',500,2500,24500,'B500'),('R080','Ruban Epson 850',10,2,120,'unité'),('R132','Ruban imp 1200 lignes',25,200,182,'unité');
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vente`
--

DROP TABLE IF EXISTS `vente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vente` (
  `NUMFOU` int(11) NOT NULL,
  `CODART` char(4) NOT NULL,
  `DELLIV` int(11) NOT NULL,
  `QTE1` int(11) NOT NULL,
  `PRIX1` decimal(9,2) NOT NULL,
  `QTE2` int(11) DEFAULT NULL,
  `PRIX2` decimal(9,2) DEFAULT NULL,
  `QTE3` int(11) DEFAULT NULL,
  `PRIX3` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`NUMFOU`,`CODART`),
  KEY `CODART` (`CODART`),
  CONSTRAINT `vente_ibfk_1` FOREIGN KEY (`NUMFOU`) REFERENCES `fournis` (`NUMFOU`),
  CONSTRAINT `vente_ibfk_2` FOREIGN KEY (`CODART`) REFERENCES `produit` (`CODART`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vente`
--

LOCK TABLES `vente` WRITE;
/*!40000 ALTER TABLE `vente` DISABLE KEYS */;
INSERT INTO `vente` VALUES (120,'D035',0,0,40.00,NULL,NULL,NULL,NULL),(120,'I100',90,0,700.00,50,600.00,120,500.00),(120,'I105',90,10,705.00,50,630.00,120,500.00),(120,'I108',90,5,795.00,30,720.00,100,680.00),(120,'P220',15,0,3700.00,100,3500.00,NULL,NULL),(120,'P230',30,0,5200.00,100,5000.00,NULL,NULL),(120,'P240',15,0,2200.00,100,2000.00,NULL,NULL),(540,'I100',70,0,710.00,60,630.00,100,600.00),(540,'I105',70,0,810.00,60,645.00,100,600.00),(8700,'B001',15,0,150.00,50,145.00,100,140.00),(8700,'B002',15,0,210.00,50,200.00,100,185.00),(8700,'I105',30,0,720.00,50,670.00,100,510.00),(8700,'P220',20,50,3500.00,100,3350.00,NULL,NULL),(8700,'P230',60,0,5000.00,50,4900.00,NULL,NULL),(9120,'D035',5,0,40.00,100,30.00,5,0.00),(9120,'I100',60,0,800.00,70,600.00,90,500.00),(9120,'I105',8,0,37.00,NULL,NULL,NULL,NULL),(9120,'I108',60,0,920.00,70,820.00,100,780.00),(9120,'I110',60,0,950.00,70,850.00,90,790.00),(9120,'P250',30,0,1500.00,100,1400.00,500,1200.00),(9120,'R080',10,0,120.00,100,100.00,NULL,NULL),(9120,'R132',5,0,275.00,NULL,NULL,NULL,NULL),(9150,'I100',90,0,650.00,90,600.00,200,590.00),(9150,'I105',90,0,685.00,90,600.00,200,590.00),(9180,'I100',30,0,720.00,50,670.00,100,490.00),(9180,'I110',90,0,9000.00,70,870.00,90,835.00);
/*!40000 ALTER TABLE `vente` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-22 19:26:01
