CREATE DATABASE  IF NOT EXISTS `uberfortutor` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `uberfortutor`;
-- MySQL dump 10.13  Distrib 5.6.22, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: uberfortutor
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.8-MariaDB

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
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `teacherid` int(11) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `complain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contractid` int(11) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `ishandled` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contractid` (`contractid`),
  CONSTRAINT `FK_contractid` FOREIGN KEY (`contractid`) REFERENCES `contract` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complain`
--

LOCK TABLES `complain` WRITE;
/*!40000 ALTER TABLE `complain` DISABLE KEYS */;
INSERT INTO `complain` VALUES (1,5,'Thầy dám chửi bố mẹ học sinh',1),(2,5,'Đây là khiếu nại lần thứ 2',1),(3,12,'Giáo viên thường xuyên đến muộn',1),(4,13,'Giáo viên dạy khó hiểu, không phù hợp với cấp độ học hỏi của học viên',0),(5,14,'Thầy dạy thiếu thời gian so với hợp đồng',0),(6,15,'Cô không dễ thương như lúc giới thiệu',0),(7,16,'Thầy dám chửi bố mẹ học sinh',1);
/*!40000 ALTER TABLE `complain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contract`
--

DROP TABLE IF EXISTS `contract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `teacherid` int(11) DEFAULT NULL,
  `studentid` int(11) DEFAULT NULL,
  `skillid` int(11) DEFAULT NULL,
  `revenue` int(11) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `state` int(11) DEFAULT 0,
  `signeddate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacherid` (`teacherid`),
  KEY `studentid` (`studentid`),
  KEY `skillid_idx` (`skillid`),
  CONSTRAINT `mainskill` FOREIGN KEY (`skillid`) REFERENCES `skill` (`id`),
  CONSTRAINT `studentid` FOREIGN KEY (`studentid`) REFERENCES `user` (`id`),
  CONSTRAINT `teacherid` FOREIGN KEY (`teacherid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract`
--

LOCK TABLES `contract` WRITE;
/*!40000 ALTER TABLE `contract` DISABLE KEYS */;
INSERT INTO `contract` VALUES (5,3,2,1,16800000,'OOP nâng cao','2020-01-04','2020-01-04',4,0,'2020-01-05'),(7,3,2,2,1300000,NULL,'2020-01-04','2020-04-04',5,2,'2020-01-05'),(8,3,2,1,16800000,'','2020-01-04','2020-01-23',3,2,'2020-01-04'),(9,3,14,2,1270000,'','2020-01-03','2020-01-24',5,2,'2020-01-03'),(10,4,16,4,2000000,'','2020-01-01','2020-01-24',3,2,'2020-01-01'),(11,4,15,6,3000000,'','2019-01-18','2019-02-23',4,2,'2019-01-18'),(12,5,15,4,4200000,'','2019-01-18','2019-03-03',4,2,'2019-01-18'),(13,6,17,13,5100000,'','2019-06-10','2019-07-18',5,1,'2019-06-10'),(14,10,18,13,1000000,'','2019-05-10','2019-07-18',4,1,'2019-05-10'),(15,12,19,10,2500000,'','2019-08-10','2019-10-10',3,1,'2019-08-10'),(16,7,20,10,3500000,'','2019-08-10','2019-10-10',5,2,'2019-08-10'),(19,10,14,10,123123,NULL,'2019-08-10','2019-10-10',5,2,'2019-08-10');
/*!40000 ALTER TABLE `contract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request`
--

DROP TABLE IF EXISTS `request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request`
--

LOCK TABLES `request` WRITE;
/*!40000 ALTER TABLE `request` DISABLE KEYS */;
INSERT INTO `request` VALUES (8,2,3,1,2,7,'2020-01-04','2020-01-23',8),(11,14,3,2,2,5,'2020-01-04','2020-01-24',5),(12,16,4,4,2,3,'2020-01-04','2020-01-24',3),(13,15,4,6,2,2,'2019-02-03','2019-02-23',2),(14,15,5,4,2,2,'2019-02-03','2019-03-03',2),(15,17,6,13,2,2,'2019-06-18','2019-07-18',2),(16,18,10,13,2,3,'2019-06-18','2019-07-18',2),(17,19,12,10,2,4,'2019-09-10','2019-10-10',2),(18,20,7,10,2,4,'2019-09-10','2019-10-10',2);
/*!40000 ALTER TABLE `request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skill`
--

DROP TABLE IF EXISTS `skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `skill` varchar(45) DEFAULT NULL,
  `state` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skill`
--

LOCK TABLES `skill` WRITE;
/*!40000 ALTER TABLE `skill` DISABLE KEYS */;
INSERT INTO `skill` VALUES (1,'Hướng đối tượng',1),(2,'Toán học tổ hợp',1),(3,'Vật lý đại cương',1),(4,'Hệ điều hành',1),(5,'Xác suất thống kê',1),(6,'Nhập môn lập trình',1),(7,'Thể dục nhịp điệu',1),(8,'Lập trình java',1),(9,'Lập trình ứng dụng web',1),(10,'Phương pháp tính [Toán]',1),(11,'Cơ sở dữ liệu',1),(12,'Hoá học căn bản',1),(13,'Vật lý căn bản',1),(14,'Giải tích căn bản',1);
/*!40000 ALTER TABLE `skill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(45) DEFAULT NULL,
  `password` longtext DEFAULT NULL,
  `role` varchar(45) DEFAULT NULL,
  `fullname` varchar(45) DEFAULT NULL,
  `avatar` longtext DEFAULT NULL COMMENT '\n',
  `address` varchar(45) DEFAULT NULL,
  `major` longtext DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `introduction` longtext DEFAULT NULL,
  `lostpasstoken` longtext DEFAULT NULL,
  `degree` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `verified` int(11) DEFAULT NULL,
  `state` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'tbngoc.khtn@gmail.com','1','admin','Trần Bá Ngọc','https://firebasestorage.googleapis.com/v0/b/caroimagecdn.appspot.com/o/2264b8a159e8a1b6f8f9.jpg1578488834918?alt=media&token=5fb711cd-519b-4157-a106-1c6ae680144a','Sông Cầu, Phú Yên','it',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.',NULL,NULL,NULL,NULL,1),(2,'tonys_trinh@outlook.com','$2b$10$3Qhs2Bp0qb7sSgcSv7VjfeX8ef9Aca06NrFpNHuxQD5Cvmlagv.KS','student','Trịnh Quang Nghĩa','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Sông Cầu, Phú Yên','literature',200000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(3,'nghiatq1@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Đặng Hoài Nam','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Bắc Giang','it',100000,'My Name is Đang Hoai Nam\nCopywriter and professional translator (English to Arabic and vice versa). Over the last fours years, I have provided great content and translations for a large number of websites and publishing houses.\n\nPassed Upwork’s English to Arabic translation test and got the top rank (All time first place!)\n\nThe field of translation that I am most experienced with is that of the Financial Markets, and I feel honored to have worked as a leader for the Arabic translation team at 24option.com, the leading binary options website, for more than three years. My accomplishments and responsibilities included:\n- Provided more than 2000 daily and weekly reports for financial markets in general, and for binary options in particular;\n- As a Team Leader, I was responsible for proofreading and editing the Arabic content provided by many Arabic translators around the world;\n- Translated many sections on their website such as the “Accounts” section, the “Terms and Conditions” as well as the “ Privacy Policy”.\n- I was also responsible for translating all promotional material.','','master','1998-07-08',1,1),(4,'nghiatq2@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Xuân Nghiêm','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Phú Yên','physics',10000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(5,'nghiatq3@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Hữu Cảnh','https://znews-photo.zadn.vn/w660/Uploaded/uqvpyciv/2019_11_12/PRI_90103786.jpg','Hà Nội','literature',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,0),(6,'nghiatq4@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Tấn Sang','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Phú Yên','chemistry',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(7,'nghiatq5@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Hồ Hoàng Hiếu','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Sao Hỏa','literature',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(8,'nghiatq6@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Bùi Thanh Tùng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Đồng Tháp','english',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(9,'nghiatq7@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Minh Nhựt','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Thanh Hóa','literature',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(10,'nghiatq8@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Phạm Thái Nghị','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Nghệ An','geography',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(11,'nghiatq9@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Bửu Lộc','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Hà Giang','history',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(12,'alotinhban@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','teacher','Nguyễn Trung Hưng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=eb70fbcf-5cd6-4548-8783-38e9ce912390','Bắc Ninh','math',100000,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.','','master','1998-07-08',1,1),(13,'1@1.1','1','admin','Trần Bá Ngọc','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Duong Ba Trac, Phuong 2, Quan 8',NULL,NULL,'Trong một bài tiểu luận, bài báo hoặc cuốn sách, phần giới thiệu là phần bắt đầu trong đó nêu mục đích và mục tiêu của bài viết sau. Điều này thường được theo sau bởi cơ thể và kết luận. Phần giới thiệu thường mô tả phạm vi của tài liệu và đưa ra lời giải thích hoặc tóm tắt ngắn gọn về tài liệu.',NULL,NULL,NULL,1,1),(14,'tbngoc1@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Trần Việt Nam','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Duong Ba Trac, Phuong 2, Quan 8',NULL,NULL,'',NULL,NULL,'1998-10-10',1,1),(15,'tbngoc2@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Trần Hải Quân','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','125 Võ Thị Sáu, Hồ Chí Minh',NULL,NULL,'',NULL,NULL,'1998-10-10',1,1),(16,'tbngoc3@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Trần Hải Quân','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','125 Võ Thị Sáu, Hồ Chí Minh',NULL,NULL,'',NULL,NULL,'1998-10-10',1,1),(17,'tbngoc4@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Nguyễn Cao Bằng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Hồ Chí Minh',NULL,NULL,'',NULL,NULL,'1998-10-10',1,1),(18,'tbngoc5@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Cao Bá Quát','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Cao Bằng',NULL,NULL,'',NULL,NULL,'2002-10-01',1,1),(19,'tbngoc6@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Nguyễn Xuân Quỳnh','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Hưng Yên',NULL,NULL,'',NULL,NULL,'2002-10-01',1,1),(20,'tbngoc7@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Nguyễn Xuân Diệu','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Hưng Yên',NULL,NULL,'',NULL,NULL,'2002-10-11',1,1),(21,'tbngoc8@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Vũ Trọng Phụng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Vũng Tàu',NULL,NULL,'',NULL,NULL,'2002-10-11',1,1),(22,'tbngoc9@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Nam Cao','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Bà Rịa',NULL,NULL,'',NULL,NULL,'2002-12-12',1,1),(23,'tbngoc10@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Nguyên Hồng','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Trường Sa',NULL,NULL,'',NULL,NULL,'2002-12-12',1,1),(24,'tbngoc11@gmail.com','$2b$10$akrWEpbz4RpUATnRvs6u8u/oNILvAh92GWPnbjlM9wiaowAhQkI9m','student','Cao Trường Sa','https://firebasestorage.googleapis.com/v0/b/webnc-1612422.appspot.com/o/tonys_trinh@outlook.com.png?alt=media&token=337876d5-db96-42b5-9f7e-e2e850b6d61a','Hoàng Sa',NULL,NULL,'',NULL,NULL,'2000-12-12',1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_skill`
--

DROP TABLE IF EXISTS `user_skill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_skill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `skillid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`),
  KEY `skillid` (`skillid`),
  CONSTRAINT `skillid` FOREIGN KEY (`skillid`) REFERENCES `skill` (`id`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_skill`
--

LOCK TABLES `user_skill` WRITE;
/*!40000 ALTER TABLE `user_skill` DISABLE KEYS */;
INSERT INTO `user_skill` VALUES (1,3,1),(2,3,2),(3,3,3),(4,11,1),(5,11,7),(6,11,9),(7,4,4),(8,4,8),(9,4,6),(10,5,4),(11,9,1),(12,10,11),(13,10,12),(14,10,13),(15,12,10),(16,6,14),(17,6,13),(18,7,10),(19,7,9),(20,8,11);
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

-- Dump completed on 2020-01-09  0:56:50
