SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL';

CREATE DATABASE IF NOT EXISTS notsecure_eezheng -- new name. drop cs157a database if exist
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
USE notsecure_eezheng;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  username varchar(64) NOT NULL,
  password varchar(64) NOT NULL,
  display_name varchar(255) NOT NULL,
  salt varchar(16) NOT NULL DEFAULT 'defaults',
  admin enum('y','n') NOT NULL DEFAULT 'n',
  PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

