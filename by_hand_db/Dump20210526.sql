-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: by_hand
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'VIP','https://img.freepik.com/free-vector/vip-golden-logo_1115-667.jpg?size=338&ext=jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(2,'wooden_work','https://image.freepik.com/free-photo/handsome-carpenter-working-with-wood_1157-26133.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(3,'wool','https://image.freepik.com/free-photo/cozy-background-wallpaper-with-yarn-knitting_169016-6305.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(4,'Origami','https://image.freepik.com/free-photo/high-angle-view-origami-paper-art-craft-orange-surface_23-2148188338.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(5,'Accessories','https://image.freepik.com/free-photo/women-s-fashion-outfit-accessory-flatlay_9515-94.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(6,'Artistic','https://image.freepik.com/free-photo/artist-props-table_23-2148929905.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(7,'Decor','https://image.freepik.com/free-photo/modern-living-room-interior-with-sofa-green-plants-lamp-table-dark-wall-background_41470-1528.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(8,'Covers','https://image.freepik.com/free-psd/smartphone-cover-case-mockup_358694-188.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(9,'Foods','https://image.freepik.com/free-photo/chicken-wings-barbecue-sweetly-sour-sauce-picnic-summer-menu-tasty-food-top-view-flat-lay_2829-6471.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL),(10,'Other','https://image.freepik.com/free-photo/top-view-solidarity-concept_23-2148829192.jpg','2021-04-15 15:19:16','2021-04-15 15:19:16',NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_idx` (`user_id`),
  KEY `fk_product_idx` (`product_id`),
  CONSTRAINT `fk_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
INSERT INTO `favorite` VALUES (96,19,37,'2021-05-23 06:48:24','2021-05-23 06:48:24','2021-05-23 06:48:33');
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `details` varchar(255) NOT NULL,
  `account_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (3,'اضافة فئة جديدة','اضاقة فئة الجلود متجري يعتمد عليها',19,'2021-05-23 06:50:26','2021-05-23 06:50:26',NULL);
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `body` varchar(1000) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (6,'discount','Discount 10%','2021-05-23 06:59:01','2021-05-23 06:59:01',NULL);
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package`
--

DROP TABLE IF EXISTS `package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package` (
  `id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `description` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package`
--

LOCK TABLES `package` WRITE;
/*!40000 ALTER TABLE `package` DISABLE KEYS */;
INSERT INTO `package` VALUES (1,'VIP','9.99/month',' Vip Account \\n Vip category \\n +100 ads to your products \\n ','2021-05-20 22:34:04','2021-05-20 22:34:04',NULL),(2,'VIP','9.99/month',' Vip Account \\n Vip category \\n +100 ads to your products \\n ','2021-05-20 22:34:04','2021-05-22 12:53:47',NULL);
/*!40000 ALTER TABLE `package` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `available` tinyint DEFAULT NULL,
  `image1_url` varchar(255) DEFAULT NULL,
  `image2_url` varchar(255) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `sub_name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_idx` (`user_id`),
  KEY `fk_category_idx` (`category_id`),
  CONSTRAINT `fk_category_pro` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_user_pro` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (37,6,2,NULL,'uploads/image1621318753066.octet-stream',NULL,'Wooden Chair','Chair with armrests','24.99','Hand-woven rattan and sturdy bamboo make each armchair unique and stable. The armrest helps you sit comfortably close to the table – ideal for long dinners. A great way to invite nature into your home.','2021-05-18 06:19:13','2021-05-18 06:19:13',NULL),(39,6,5,NULL,'uploads/image1621327228035.octet-stream',NULL,'beads Chain','peace Chain','15','Spring & Summer collection of charms are already here. New handmade tessal pendents summer necklace. Best gift to keep or to give, choice is yours Boho long statement Necklaces Rainbow colored beads chain Handmade','2021-05-18 08:40:28','2021-05-18 11:19:37',NULL),(45,19,10,NULL,'uploads/image1621752707810.octet-stream',NULL,'candle','bute colors','15.55','descriptions prudcts','2021-05-23 06:51:47','2021-05-23 06:51:47','2021-05-23 06:53:18');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate`
--

DROP TABLE IF EXISTS `rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `value_rate` double DEFAULT '0',
  `user_product` varchar(45) DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_prod_rate_idx` (`product_id`),
  CONSTRAINT `fk_prod_rate` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate`
--

LOCK TABLES `rate` WRITE;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` VALUES (24,37,3,'1937','2021-05-23 06:47:40','2021-05-23 06:47:40',NULL);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_user`
--

DROP TABLE IF EXISTS `type_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL DEFAULT 'user',
  `count_posts` int NOT NULL DEFAULT '3',
  `vip_account` tinyint NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_user`
--

LOCK TABLES `type_user` WRITE;
/*!40000 ALTER TABLE `type_user` DISABLE KEYS */;
INSERT INTO `type_user` VALUES (1,'admin',9999,1,'2021-04-15 14:38:09','2021-04-15 14:38:09',NULL),(2,'super_user',99,1,'2021-04-15 14:38:09','2021-04-15 14:38:09',NULL),(3,'user',3,0,'2021-04-15 14:38:09','2021-04-15 14:38:09',NULL);
/*!40000 ALTER TABLE `type_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_id` int NOT NULL DEFAULT '3',
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `fname` varchar(255) DEFAULT NULL,
  `lname` varchar(255) DEFAULT NULL,
  `jop` varchar(255) DEFAULT NULL,
  `hobe` varchar(255) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `updatedAt` timestamp NOT NULL,
  `deletedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `usfk_idx` (`type_id`),
  CONSTRAINT `usfk` FOREIGN KEY (`type_id`) REFERENCES `type_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,1,'irbid','070999666','asmar@a.com','$2b$10$EIv56PfAKGAVuWkVauukLe5XHmF3wx02ElExKuELWE7QcGi9dwmI6','Mohammad','asmar','developer','art','uploads/image1621336188768.octet-stream','2021-04-15 14:38:09','2021-05-21 18:45:14',NULL),(6,3,'irbid','0785384521','user@user.com','$2b$10$EIv56PfAKGAVuWkVauukLe5XHmF3wx02ElExKuELWE7QcGi9dwmI6','Mohammad','Alasmar','developer','art','uploads/image1621336188768.octet-stream','2021-04-15 14:38:09','2021-04-15 14:38:09',NULL),(19,2,'irbid','0785384521','asmar@gmail.com','$2b$10$wSE.D6KZKqmSQqravu7bLuRA98q.kC83QK.V981bGe1ZqOkDAplc.','mohammad','alasmar',NULL,NULL,'uploads/image1621767017179.octet-stream','2021-05-23 06:46:26','2021-05-23 10:50:17',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-26 10:18:57
