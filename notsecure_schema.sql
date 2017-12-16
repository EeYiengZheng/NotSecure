-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.1.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win32
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for notsecure_eezheng
DROP DATABASE IF EXISTS `notsecure_eezheng`;
CREATE DATABASE IF NOT EXISTS `notsecure_eezheng` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `notsecure_eezheng`;

-- Dumping structure for table notsecure_eezheng.blogs
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE IF NOT EXISTS `blogs` (
  `blog_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `author` varchar(64) NOT NULL,
  `title` varchar(256) NOT NULL DEFAULT 'My blog',
  `content` text NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`blog_id`),
  KEY `username` (`author`),
  FULLTEXT KEY `articles` (`title`,`content`),
  CONSTRAINT `FK_blogs_users` FOREIGN KEY (`author`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Dumping data for table notsecure_eezheng.blogs: ~0 rows (approximately)
/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` (`blog_id`, `author`, `title`, `content`, `created`, `updated`) VALUES
	(1, 'admin', 'My blog', 'asdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceascasdfsfsdfsdfsdfsdfsdfsdfsdfsadfasdfasdfsadfsadfsadfsadfasfsdafasdfsecesaccaseceasc', '2017-12-15 23:38:40', '2017-12-15 23:38:40');
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;

-- Dumping structure for table notsecure_eezheng.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `username` varchar(64) NOT NULL,
  `password` char(64) NOT NULL,
  `display_name` varchar(32) NOT NULL,
  `salt` varchar(16) NOT NULL DEFAULT 'defaults',
  `admin` enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table notsecure_eezheng.users: ~1 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`, `password`, `display_name`, `salt`, `admin`) VALUES
	('admin', '76caa20111c77c13c5d3be80f46a8722fbed84ce1e403e6fe08b81ad4219d5f3', 'The_admin', 'a8ef57f753171bf9', 'y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
