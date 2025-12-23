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
-- Table structure for table `payments`
--
USE dashboard_db;

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client_id` int DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `status` enum('Approved','Pending') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,9903.00,'Approved','2025-12-03 09:56:55'),(2,2,1196.00,'Pending','2025-12-03 09:56:55'),(3,3,300.00,'Approved','2025-12-03 09:56:55'),(4,4,207.00,'Approved','2025-12-03 09:58:56'),(5,1,5000.00,'Approved','2025-12-03 11:56:42'),(6,1,6000.00,'Approved','2025-12-03 11:57:25'),(7,31,130000.00,'Approved','2025-10-03 07:00:00'),(8,3,7000.00,'Pending','2025-09-02 07:00:00'),(9,4,8000.00,'Approved','2025-08-16 07:00:00'),(10,4,90000.00,'Approved','2025-07-24 07:00:00'),(11,10,6543.00,'Approved','2025-01-22 07:00:00'),(12,2,67450.00,'Approved','2025-02-12 07:00:00'),(13,8,89786.00,'Approved','2025-04-18 07:00:00'),(14,10,89954.00,'Approved','2025-10-03 07:00:00'),(15,20,90876.00,'Approved','2025-10-09 07:00:00'),(16,5,110000.00,'Approved','2025-09-12 07:00:00'),(17,9,214567.00,'Approved','2025-11-12 07:00:00'),(18,3,10000.00,'Approved','2025-12-02 07:00:00'),(19,5,23000.00,'Pending','2025-11-28 07:00:00'),(20,32,3000.00,'Pending','2025-12-04 07:00:00');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-23  2:55:34
