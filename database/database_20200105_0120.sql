CREATE DATABASE  IF NOT EXISTS `uberfortutor` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `uberfortutor`;
-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: uberfortutor
-- ------------------------------------------------------
-- Server version	8.0.17

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `teacherid` int(11) DEFAULT NULL,
  `content` longtext,
  PRIMARY KEY (`id`),
  KEY `FK_comment_user_user` (`userid`),
  KEY `FK_comment_user_teacher` (`teacherid`),
  CONSTRAINT `FK_comment_user_teacher` FOREIGN KEY (`teacherid`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_comment_user_user` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,2,3,'Thầy giáo dạy rất hay quá ạ'),(2,5,3,'Thầy khá là nghiêm túc nhưng dạy rất hay nhé'),(3,4,3,'Thầy rất đẹp trai'),(4,2,3,'Thầy hơi nghiêm túc một tí'),(5,2,3,'Kiến thức của thầy rất rộng lớn'),(6,2,3,'Mình tự nhận xét mình'),(7,2,3,'Thầy dạy khá hay nha');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complain`
--

DROP TABLE IF EXISTS `complain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contractid` int(11) DEFAULT NULL,
  `content` longtext,
  `ishandled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contractid` (`contractid`),
  CONSTRAINT `FK_contractid` FOREIGN KEY (`contractid`) REFERENCES `contract` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complain`
--

LOCK TABLES `complain` WRITE;
/*!40000 ALTER TABLE `complain` DISABLE KEYS */;
INSERT INTO `complain` VALUES (1,5,'Thầy dám chửi bố mẹ học sinh',0),(2,5,'Đây là khiếu nại lần thứ 2',1);
/*!40000 ALTER TABLE `complain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacherid` int(11) DEFAULT NULL,
  `studentid` int(11) DEFAULT NULL,
  `skillid` int(11) DEFAULT NULL,
  `revenue` int(11) DEFAULT NULL,
  `description` longtext,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `state` int(11) DEFAULT '0',
  `signeddate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacherid` (`teacherid`),
  KEY `studentid` (`studentid`),
  KEY `skillid_idx` (`skillid`),
  CONSTRAINT `mainskill` FOREIGN KEY (`skillid`) REFERENCES `skill` (`id`),
  CONSTRAINT `studentid` FOREIGN KEY (`studentid`) REFERENCES `user` (`id`),
  CONSTRAINT `teacherid` FOREIGN KEY (`teacherid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (5,3,2,1,16800000,'OOP nâng cao','2020-01-04','2020-01-04',4,0,'2020-01-05'),(7,3,2,2,1300000,NULL,'2020-01-04','2020-04-04',5,2,'2020-01-05');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `studentid` int(11) DEFAULT NULL,
  `teacherid` int(11) DEFAULT NULL,
  `skill` int(11) DEFAULT NULL,
  `isaccept` tinyint(4) DEFAULT NULL,
  `dayperweek` int(11) DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `hourperday` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_request_skill` (`skill`),
  KEY `FK_request_user_teacher` (`teacherid`),
  KEY `FK_request_user_student` (`studentid`),
  CONSTRAINT `FK_request_skill` FOREIGN KEY (`skill`) REFERENCES `skill` (`id`),
  CONSTRAINT `FK_request_user_student` FOREIGN KEY (`studentid`) REFERENCES `user` (`id`),
  CONSTRAINT `FK_request_user_teacher` FOREIGN KEY (`teacherid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (8,2,3,1,2,7,'2020-01-04','2020-01-23',8);
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill` varchar(45) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (1,'Phương pháp lập trình hướng',NULL),(2,'Toán học tổ hợp',NULL),(3,'Vật lý đại cương',NULL),(4,'Hệ điều hành',NULL);
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `password` longtext,
  `role` varchar(45) DEFAULT NULL,
  `fullname` varchar(45) DEFAULT NULL,
  `avatar` longtext COMMENT '\n',
  `address` varchar(45) DEFAULT NULL,
  `major` longtext,
  `price` int(11) DEFAULT NULL,
  `introduction` longtext,
  `lostpasstoken` longtext,
  `degree` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `verified` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'tbngoc.khtn@gmail.com','1','admin','Trần Bá Ngọc','null','null','it',10,'null',NULL,NULL,NULL,NULL),(2,'tonys_trinh@outlook.com','$2b$10$3Qhs2Bp0qb7sSgcSv7VjfeX8ef9Aca06NrFpNHuxQD5Cvmlagv.KS','student','Trịnh Quang Nghĩa','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Sông Cầu, Phú Yên','literature',200000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1),(3,'nghiatq1@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Đặng Hoài Nam','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Bắc Giang','it',100000,'My Name is Đang Hoai Nam\nCopywriter and professional translator (English to Arabic and vice versa). Over the last fours years, I have provided great content and translations for a large number of websites and publishing houses.\n\nPassed Upwork’s English to Arabic translation test and got the top rank (All time first place!)\n\nThe field of translation that I am most experienced with is that of the Financial Markets, and I feel honored to have worked as a leader for the Arabic translation team at 24option.com, the leading binary options website, for more than three years. My accomplishments and responsibilities included:\n- Provided more than 2000 daily and weekly reports for financial markets in general, and for binary options in particular;\n- As a Team Leader, I was responsible for proofreading and editing the Arabic content provided by many Arabic translators around the world;\n- Translated many sections on their website such as the “Accounts” section, the “Terms and Conditions” as well as the “ Privacy Policy”.\n- I was also responsible for translating all promotional material.','','master','1998-07-08',1),(4,'nghiatq2@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Xuân Nghiêm','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Phú Yên','physics',10000,NULL,'','master','1998-07-08',1),(5,'nghiatq3@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Hữu Cảnh','https://znews-photo.zadn.vn/w660/Uploaded/uqvpyciv/2019_11_12/PRI_90103786.jpg','Hà Nội','literature',0,NULL,'','master','1998-07-08',1),(6,'nghiatq4@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Tấn Sang','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Phú Yên','chemistry',0,NULL,'','master','1998-07-08',1),(7,'nghiatq5@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Hồ Hoàng Hiếu','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Sao Hỏa','literature',0,NULL,'','master','1998-07-08',1),(8,'nghiatq6@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Bùi Thanh Tùng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Đồng Tháp','english',0,NULL,'','master','1998-07-08',1),(9,'nghiatq7@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Minh Nhựt','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Thanh Hóa','literature',0,NULL,'','master','1998-07-08',1),(10,'nghiatq8@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Phạm Thái Nghị','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Nghệ An','geography',0,NULL,'','master','1998-07-08',1),(11,'nghiatq9@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Bửu Lộc','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Hà Giang','history',0,NULL,'','master','1998-07-08',1),(12,'alotinhban@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Trung Hưng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Bắc Ninh','math',0,NULL,'','master','1998-07-08',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_skill`
--

DROP TABLE IF EXISTS `user_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `skillid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `skillid` (`skillid`),
  CONSTRAINT `skillid` FOREIGN KEY (`skillid`) REFERENCES `skill` (`id`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_skill`
--

LOCK TABLES `user_skill` WRITE;
/*!40000 ALTER TABLE `user_skill` DISABLE KEYS */;
INSERT INTO `user_skill` VALUES (1,3,1),(2,3,2),(3,3,3);
/*!40000 ALTER TABLE `user_skill` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-05  1:21:05
