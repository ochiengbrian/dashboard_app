-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: dashboard_db
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--
USE dashboard_db;

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'John Doe','johndoe@example.com','Active','USA'),(2,'Sophia Williams','sophia.williams@corporation.com','Active','UK'),(3,'Liam Johnson','liam.johnson@globaltech.com','Active','Czech Republic'),(4,'Oliver Brown','oliver.brown@enterprisesolutions.com','Inactive','USA'),(5,'Emma Taylor','emma.taylor@abcindustries.com','Active','Germany'),(6,'Noah Anderson','noah.anderson@greenfieldcorp.com','Active','Canada'),(7,'Ava Martinez','ava.martinez@techsolutions.com','Inactive','France'),(8,'William Harris','william.harris@innovativegroup.com','Active','Italy'),(9,'Isabella Clark','isabella.clark@financialservices.com','Active','Spain'),(10,'James Lewis','james.lewis@medicalliance.com','Inactive','Australia'),(11,'Mason Walker','mason.walker@sysdevsolutions.com','Active','India'),(12,'Lily Perez','lily.perez@nextgenbusiness.com','Inactive','Brazil'),(13,'Ethan King','ethan.king@techprosystems.com','Active','South Korea'),(14,'Mila Wright','mila.wright@globalpartners.com','Active','Japan'),(15,'Jacob Robinson','jacob.robinson@earthsolutions.com','Inactive','Germany'),(16,'Amelia Lopez','amelia.lopez@worldwideenterprises.com','Active','Netherlands'),(17,'Lucas Young','lucas.young@dataanalyticscorp.com','Inactive','Mexico'),(18,'Harper Adams','harper.adams@innovationsolutions.com','Active','Italy'),(19,'Henry Carter','henry.carter@buildingtomorrow.com','Active','USA'),(20,'Ella Mitchell','ella.mitchell@techsystems.com','Inactive','UK'),(21,'Sebastian Perez','sebastian.perez@hitechcorp.com','Active','France'),(22,'Jackson Hall','jackson.hall@financedynamics.com','Active','Spain'),(24,'Jack Moore','jack.moore@blueoceanventures.com','Active','Australia'),(25,'Charlotte Nelson','charlotte.nelson@webservices.com','Active','South Korea'),(26,'Logan Carter','logan.carter@nextleveltech.com','Inactive','USA'),(27,'Madison White','madison.white@financialgroup.com','Active','Canada'),(28,'Aiden King','aiden.king@globalmarketsolutions.com','Inactive','Mexico'),(31,'ochieng brian','acemcfumble25@gmail.com','Active','USA'),(32,'test test 10.04 am','gradea.tutors5@gmail.com','Inactive','USA');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-23  2:55:35
