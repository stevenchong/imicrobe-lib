-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: imicrobe
-- ------------------------------------------------------
-- Server version	5.7.22

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
-- Table structure for table `app`
--

DROP TABLE IF EXISTS `app`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app` (
  `app_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `is_maintenance` tinyint(4) DEFAULT '0',
  `provider_name` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_data_type`
--

DROP TABLE IF EXISTS `app_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_data_type` (
  `app_data_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`app_data_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_result`
--

DROP TABLE IF EXISTS `app_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_result` (
  `app_result_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(10) unsigned NOT NULL,
  `app_data_type_id` int(10) unsigned NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`app_result_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_run`
--

DROP TABLE IF EXISTS `app_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_run` (
  `app_run_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `app_ran_at` datetime DEFAULT NULL,
  `params` text,
  PRIMARY KEY (`app_run_id`),
  KEY `user_id` (`user_id`),
  KEY `app_id` (`app_id`),
  CONSTRAINT `app_run_ibfk_3` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE,
  CONSTRAINT `app_run_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_tag`
--

DROP TABLE IF EXISTS `app_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_tag` (
  `app_tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`app_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_to_app_data_type`
--

DROP TABLE IF EXISTS `app_to_app_data_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_to_app_data_type` (
  `app_to_app_data_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(10) unsigned NOT NULL,
  `app_data_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`app_to_app_data_type_id`),
  KEY `app_id` (`app_id`),
  KEY `app_data_type_id` (`app_data_type_id`),
  CONSTRAINT `app_to_app_data_type_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`),
  CONSTRAINT `app_to_app_data_type_ibfk_2` FOREIGN KEY (`app_data_type_id`) REFERENCES `app_data_type` (`app_data_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_to_app_tag`
--

DROP TABLE IF EXISTS `app_to_app_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_to_app_tag` (
  `app_to_app_tag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` int(10) unsigned NOT NULL,
  `app_tag_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`app_to_app_tag_id`),
  KEY `app_id` (`app_id`),
  KEY `app_tag_id` (`app_tag_id`),
  CONSTRAINT `app_to_app_tag_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`),
  CONSTRAINT `app_to_app_tag_ibfk_2` FOREIGN KEY (`app_tag_id`) REFERENCES `app_tag` (`app_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `assembly`
--

DROP TABLE IF EXISTS `assembly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assembly` (
  `assembly_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL,
  `assembly_code` varchar(255) DEFAULT NULL,
  `assembly_name` text,
  `organism` varchar(255) DEFAULT NULL,
  `pep_file` varchar(255) DEFAULT NULL,
  `nt_file` varchar(255) DEFAULT NULL,
  `cds_file` varchar(255) DEFAULT NULL,
  `description` text,
  `sample_id` int(10) unsigned DEFAULT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`assembly_id`),
  KEY `project_id` (`project_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `assembly_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `assembly_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1070 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `centrifuge`
--

DROP TABLE IF EXISTS `centrifuge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centrifuge` (
  `centrifuge_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tax_id` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`centrifuge_id`),
  UNIQUE KEY `tax_id` (`tax_id`),
  KEY `tax_id_2` (`tax_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=10027 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `combined_assembly`
--

DROP TABLE IF EXISTS `combined_assembly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `combined_assembly` (
  `combined_assembly_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `assembly_name` varchar(255) DEFAULT NULL,
  `phylum` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `family` varchar(255) DEFAULT NULL,
  `genus` varchar(255) DEFAULT NULL,
  `species` varchar(255) DEFAULT NULL,
  `strain` varchar(255) DEFAULT NULL,
  `pcr_amp` varchar(255) DEFAULT NULL,
  `annotations_file` varchar(255) DEFAULT NULL,
  `peptides_file` varchar(255) DEFAULT NULL,
  `nucleotides_file` varchar(255) DEFAULT NULL,
  `cds_file` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`combined_assembly_id`),
  UNIQUE KEY `assembly_name` (`assembly_name`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `combined_assembly_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `combined_assembly_to_sample`
--

DROP TABLE IF EXISTS `combined_assembly_to_sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `combined_assembly_to_sample` (
  `combined_assembly_to_sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `combined_assembly_id` int(10) unsigned NOT NULL,
  `sample_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`combined_assembly_to_sample_id`),
  KEY `combined_assembly_id` (`combined_assembly_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `combined_assembly_to_sample_ibfk_3` FOREIGN KEY (`combined_assembly_id`) REFERENCES `combined_assembly` (`combined_assembly_id`) ON DELETE CASCADE,
  CONSTRAINT `combined_assembly_to_sample_ibfk_4` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`)
) ENGINE=InnoDB AUTO_INCREMENT=377 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `domain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`domain_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ftp`
--

DROP TABLE IF EXISTS `ftp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ftp` (
  `ftp_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `size` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ftp_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `ftp_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26825 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `investigator`
--

DROP TABLE IF EXISTS `investigator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `investigator` (
  `investigator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `investigator_name` varchar(255) NOT NULL DEFAULT '',
  `institution` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) DEFAULT NULL,
  `orcid` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`investigator_id`),
  KEY `investigator_name` (`investigator_name`)
) ENGINE=InnoDB AUTO_INCREMENT=225 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `kegg_annotation`
--

DROP TABLE IF EXISTS `kegg_annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kegg_annotation` (
  `kegg_annotation_id` varchar(16) NOT NULL,
  `name` varchar(80) DEFAULT NULL,
  `definition` text,
  `pathway` text,
  `module` text,
  PRIMARY KEY (`kegg_annotation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `login`
--

DROP TABLE IF EXISTS `login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login` (
  `login_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `login_date` datetime NOT NULL,
  PRIMARY KEY (`login_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `login_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1381 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `metadata_type`
--

DROP TABLE IF EXISTS `metadata_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `metadata_type` (
  `metadata_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(64) NOT NULL DEFAULT '',
  `category_type` varchar(32) DEFAULT NULL,
  `qiime_tag` varchar(128) DEFAULT NULL,
  `mgrast_tag` varchar(128) DEFAULT NULL,
  `tag` varchar(128) NOT NULL DEFAULT '',
  `definition` text,
  `required` tinyint(4) NOT NULL DEFAULT '0',
  `mixs` tinyint(4) NOT NULL DEFAULT '0',
  `type` text,
  `fw_type` text,
  `unit` text,
  PRIMARY KEY (`metadata_type_id`),
  UNIQUE KEY `category` (`category`,`tag`)
) ENGINE=InnoDB AUTO_INCREMENT=434 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontology`
--

DROP TABLE IF EXISTS `ontology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ontology` (
  `ontology_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ontology_acc` varchar(125) NOT NULL,
  `label` varchar(125) NOT NULL,
  `ontology_type_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ontology_id`),
  KEY `ontology_acc` (`ontology_acc`),
  KEY `ontology_type_id` (`ontology_type_id`),
  CONSTRAINT `ontology_ibfk_1` FOREIGN KEY (`ontology_type_id`) REFERENCES `ontology_type` (`ontology_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ontology_type`
--

DROP TABLE IF EXISTS `ontology_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ontology_type` (
  `ontology_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `url_template` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`ontology_type_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pfam_annotation`
--

DROP TABLE IF EXISTS `pfam_annotation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pfam_annotation` (
  `uproc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `accession` varchar(16) DEFAULT NULL,
  `identifier` varchar(16) DEFAULT NULL,
  `name` varchar(80) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`uproc_id`),
  UNIQUE KEY `accession` (`accession`)
) ENGINE=InnoDB AUTO_INCREMENT=17623 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `project_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_code` varchar(255) NOT NULL DEFAULT '',
  `project_name` varchar(255) NOT NULL DEFAULT '',
  `pi` varchar(255) NOT NULL DEFAULT '',
  `institution` varchar(255) NOT NULL DEFAULT '',
  `project_type` varchar(255) NOT NULL DEFAULT '',
  `description` text,
  `url` varchar(255) NOT NULL DEFAULT '',
  `read_file` varchar(100) NOT NULL DEFAULT '',
  `meta_file` varchar(100) NOT NULL DEFAULT '',
  `assembly_file` varchar(100) NOT NULL DEFAULT '',
  `peptide_file` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(255) NOT NULL DEFAULT '',
  `read_pep_file` varchar(100) NOT NULL DEFAULT '',
  `nt_file` varchar(100) NOT NULL DEFAULT '',
  `private` tinyint(1) DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=294 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_file`
--

DROP TABLE IF EXISTS `project_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_file` (
  `project_file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `project_file_type_id` int(10) unsigned NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`project_file_id`),
  UNIQUE KEY `project_id` (`project_id`,`project_file_type_id`,`file`),
  KEY `project_id_2` (`project_id`),
  KEY `project_file_type_id` (`project_file_type_id`),
  CONSTRAINT `project_file_ibfk_1` FOREIGN KEY (`project_file_type_id`) REFERENCES `project_file_type` (`project_file_type_id`),
  CONSTRAINT `project_file_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=854 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_file_type`
--

DROP TABLE IF EXISTS `project_file_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_file_type` (
  `project_file_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`project_file_type_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_group`
--

DROP TABLE IF EXISTS `project_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_group` (
  `project_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  `description` text,
  `url` varchar(255) DEFAULT NULL,
  `private` tinyint(1) DEFAULT NULL,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`project_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_group_to_user`
--

DROP TABLE IF EXISTS `project_group_to_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_group_to_user` (
  `project_group_to_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `permission` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`project_group_to_user_id`),
  KEY `project_group_id` (`project_group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `project_group_to_user_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `project_group` (`project_group_id`) ON DELETE CASCADE,
  CONSTRAINT `project_group_to_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_page`
--

DROP TABLE IF EXISTS `project_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_page` (
  `project_page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` text,
  `display_order` int(11) DEFAULT NULL,
  `format` enum('html','markdown') DEFAULT 'html',
  PRIMARY KEY (`project_page_id`),
  UNIQUE KEY `project_id` (`project_id`,`title`),
  KEY `project_id_2` (`project_id`),
  CONSTRAINT `project_page_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_to_domain`
--

DROP TABLE IF EXISTS `project_to_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_to_domain` (
  `project_to_domain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`project_to_domain_id`),
  KEY `project_id` (`project_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `project_to_domain_ibfk_2` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain_id`),
  CONSTRAINT `project_to_domain_ibfk_3` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_to_investigator`
--

DROP TABLE IF EXISTS `project_to_investigator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_to_investigator` (
  `project_to_investigator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `investigator_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`project_to_investigator_id`),
  UNIQUE KEY `project_id` (`project_id`,`investigator_id`),
  KEY `investigator_id` (`investigator_id`),
  CONSTRAINT `project_to_investigator_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `project_to_investigator_ibfk_2` FOREIGN KEY (`investigator_id`) REFERENCES `investigator` (`investigator_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=235 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_to_project_group`
--

DROP TABLE IF EXISTS `project_to_project_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_to_project_group` (
  `project_to_project_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_group_id` int(10) unsigned NOT NULL,
  `project_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`project_to_project_group_id`),
  KEY `project_group_id` (`project_group_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `project_to_project_group_ibfk_1` FOREIGN KEY (`project_group_id`) REFERENCES `project_group` (`project_group_id`) ON DELETE CASCADE,
  CONSTRAINT `project_to_project_group_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_to_protocol`
--

DROP TABLE IF EXISTS `project_to_protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_to_protocol` (
  `project_to_protocol_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `protocol_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`project_to_protocol_id`),
  KEY `project_id` (`project_id`),
  KEY `protocol_id` (`protocol_id`),
  CONSTRAINT `project_to_protocol_ibfk_1` FOREIGN KEY (`protocol_id`) REFERENCES `protocol` (`protocol_id`) ON DELETE CASCADE,
  CONSTRAINT `project_to_protocol_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `project_to_user`
--

DROP TABLE IF EXISTS `project_to_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_to_user` (
  `project_to_user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `permission` int(4) unsigned DEFAULT NULL,
  PRIMARY KEY (`project_to_user_id`),
  KEY `project_id` (`project_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `project_to_user_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE,
  CONSTRAINT `project_to_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protein`
--

DROP TABLE IF EXISTS `protein`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protein` (
  `protein_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `protein_type_id` int(10) unsigned NOT NULL,
  `accession` varchar(100) NOT NULL,
  `description` text,
  PRIMARY KEY (`protein_id`),
  UNIQUE KEY `accession` (`accession`),
  KEY `fk_pfkpt` (`protein_type_id`),
  CONSTRAINT `fk_pfkpt` FOREIGN KEY (`protein_type_id`) REFERENCES `protein_type` (`protein_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32447 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protein_evidence_type`
--

DROP TABLE IF EXISTS `protein_evidence_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protein_evidence_type` (
  `protein_evidence_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`protein_evidence_type_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protein_type`
--

DROP TABLE IF EXISTS `protein_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protein_type` (
  `protein_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`protein_type_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `protocol`
--

DROP TABLE IF EXISTS `protocol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `protocol` (
  `protocol_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `protocol_name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`protocol_id`),
  UNIQUE KEY `protocol_name` (`protocol_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pubchase`
--

DROP TABLE IF EXISTS `pubchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubchase` (
  `pubchase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `journal_title` varchar(255) DEFAULT NULL,
  `doi` varchar(255) DEFAULT NULL,
  `authors` mediumtext,
  `article_date` date DEFAULT NULL,
  `created_on` date DEFAULT NULL,
  `url` mediumtext,
  PRIMARY KEY (`pubchase_id`),
  UNIQUE KEY `article_id` (`article_id`)
) ENGINE=InnoDB AUTO_INCREMENT=728 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pubchase_rec`
--

DROP TABLE IF EXISTS `pubchase_rec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pubchase_rec` (
  `pubchase_rec_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rec_date` datetime DEFAULT NULL,
  `checksum` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pubchase_rec_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publication`
--

DROP TABLE IF EXISTS `publication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication` (
  `publication_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL,
  `pub_code` varchar(255) DEFAULT NULL,
  `doi` text,
  `author` text,
  `title` varchar(255) DEFAULT NULL,
  `pubmed_id` int(11) DEFAULT NULL,
  `journal` text,
  `pub_date` text,
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`publication_id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `publication_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publication_to_project_file`
--

DROP TABLE IF EXISTS `publication_to_project_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publication_to_project_file` (
  `publication_to_project_file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `publication_id` int(10) unsigned NOT NULL,
  `project_file_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`publication_to_project_file_id`),
  KEY `publication_id` (`publication_id`),
  KEY `project_file_id` (`project_file_id`),
  CONSTRAINT `publication_to_project_file_ibfk_2` FOREIGN KEY (`publication_id`) REFERENCES `publication` (`publication_id`),
  CONSTRAINT `publication_to_project_file_ibfk_3` FOREIGN KEY (`project_file_id`) REFERENCES `project_file` (`project_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `query_log`
--

DROP TABLE IF EXISTS `query_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `query_log` (
  `query_log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `num_found` int(11) DEFAULT NULL,
  `query` text,
  `params` text,
  `ip` text,
  `user_id` text,
  `time` double DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`query_log_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31690 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reference`
--

DROP TABLE IF EXISTS `reference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reference` (
  `reference_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file` varchar(255) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `revision` text,
  `length` bigint(20) unsigned DEFAULT NULL,
  `seq_count` int(10) unsigned DEFAULT NULL,
  `build_date` text,
  `description` text,
  PRIMARY KEY (`reference_id`),
  UNIQUE KEY `file` (`file`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample`
--

DROP TABLE IF EXISTS `sample`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` int(10) unsigned DEFAULT NULL,
  `sample_acc` varchar(255) DEFAULT NULL,
  `sample_name` varchar(255) NOT NULL DEFAULT '',
  `sample_type` varchar(255) NOT NULL DEFAULT '',
  `sample_description` text,
  `url` varchar(255) NOT NULL DEFAULT '',
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sample_id`),
  UNIQUE KEY `project_id` (`project_id`,`sample_acc`),
  UNIQUE KEY `project_id_2` (`project_id`,`sample_name`),
  CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`project_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6383 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_attr`
--

DROP TABLE IF EXISTS `sample_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_attr` (
  `sample_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_attr_type_id` int(10) unsigned NOT NULL,
  `sample_id` int(10) unsigned NOT NULL,
  `attr_value` varchar(255) NOT NULL,
  PRIMARY KEY (`sample_attr_id`),
  UNIQUE KEY `sample_id` (`sample_id`,`sample_attr_type_id`,`attr_value`),
  KEY `sample_attr_type_id` (`sample_attr_type_id`),
  CONSTRAINT `sample_attr_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_attr_ibfk_3` FOREIGN KEY (`sample_attr_type_id`) REFERENCES `sample_attr_type` (`sample_attr_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=356132 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_attr_type`
--

DROP TABLE IF EXISTS `sample_attr_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_attr_type` (
  `sample_attr_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_attr_type_category_id` int(10) unsigned DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `url_template` varchar(255) DEFAULT NULL,
  `description` mediumtext,
  `units` varchar(50) NOT NULL DEFAULT '',
  `is_numeric` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sample_attr_type_id`),
  UNIQUE KEY `type` (`type`),
  KEY `sample_attr_type_category_id` (`sample_attr_type_category_id`),
  CONSTRAINT `sample_attr_type_ibfk_1` FOREIGN KEY (`sample_attr_type_category_id`) REFERENCES `sample_attr_type_category` (`sample_attr_type_category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=977 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_attr_type_alias`
--

DROP TABLE IF EXISTS `sample_attr_type_alias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_attr_type_alias` (
  `sample_attr_type_alias_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_attr_type_id` int(10) unsigned NOT NULL,
  `alias` varchar(200) NOT NULL,
  PRIMARY KEY (`sample_attr_type_alias_id`),
  UNIQUE KEY `sample_attr_type_id` (`sample_attr_type_id`,`alias`),
  CONSTRAINT `sample_attr_type_alias_ibfk_1` FOREIGN KEY (`sample_attr_type_id`) REFERENCES `sample_attr_type` (`sample_attr_type_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=492 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_attr_type_category`
--

DROP TABLE IF EXISTS `sample_attr_type_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_attr_type_category` (
  `sample_attr_type_category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(255) NOT NULL,
  PRIMARY KEY (`sample_attr_type_category_id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_file`
--

DROP TABLE IF EXISTS `sample_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_file` (
  `sample_file_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `sample_file_type_id` int(10) unsigned NOT NULL,
  `file` varchar(200) DEFAULT NULL,
  `num_seqs` int(11) DEFAULT NULL,
  `num_bp` bigint(20) unsigned DEFAULT NULL,
  `avg_len` int(11) DEFAULT NULL,
  `pct_gc` double DEFAULT NULL,
  PRIMARY KEY (`sample_file_id`),
  UNIQUE KEY `sample_id` (`sample_id`,`sample_file_type_id`,`file`),
  KEY `sample_id_2` (`sample_id`),
  KEY `sample_file_type_id` (`sample_file_type_id`),
  CONSTRAINT `sample_file_ibfk_1` FOREIGN KEY (`sample_file_type_id`) REFERENCES `sample_file_type` (`sample_file_type_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_file_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=89223 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_file_attr`
--

DROP TABLE IF EXISTS `sample_file_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_file_attr` (
  `sample_file_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `file_attr` varchar(50) NOT NULL,
  PRIMARY KEY (`sample_file_attr_id`),
  UNIQUE KEY `file_attr` (`file_attr`)
) ENGINE=InnoDB AUTO_INCREMENT=702 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_file_type`
--

DROP TABLE IF EXISTS `sample_file_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_file_type` (
  `sample_file_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`sample_file_type_id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_group`
--

DROP TABLE IF EXISTS `sample_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_group` (
  `sample_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) DEFAULT NULL,
  `description` text,
  `url` varchar(255) DEFAULT NULL,
  `user_id` int(10) unsigned DEFAULT NULL,
  `private` tinyint(1) NOT NULL DEFAULT '1',
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sample_group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `sample_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_centrifuge`
--

DROP TABLE IF EXISTS `sample_to_centrifuge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_centrifuge` (
  `sample_to_centrifuge_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL DEFAULT '0',
  `centrifuge_id` int(10) unsigned NOT NULL DEFAULT '0',
  `num_reads` int(10) unsigned NOT NULL DEFAULT '0',
  `num_unique_reads` int(10) unsigned NOT NULL DEFAULT '0',
  `abundance` double unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`sample_to_centrifuge_id`),
  UNIQUE KEY `sample_id` (`sample_id`,`centrifuge_id`),
  KEY `centrifuge_id` (`centrifuge_id`),
  CONSTRAINT `sample_to_centrifuge_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_to_centrifuge_ibfk_2` FOREIGN KEY (`centrifuge_id`) REFERENCES `centrifuge` (`centrifuge_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7586838 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_domain`
--

DROP TABLE IF EXISTS `sample_to_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_domain` (
  `sample_to_domain_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `domain_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_to_domain_id`),
  KEY `sample_id` (`sample_id`),
  KEY `domain_id` (`domain_id`),
  CONSTRAINT `sample_to_domain_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain_id`),
  CONSTRAINT `sample_to_domain_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6737 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_investigator`
--

DROP TABLE IF EXISTS `sample_to_investigator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_investigator` (
  `sample_to_investigator_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `investigator_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_to_investigator_id`),
  UNIQUE KEY `sample_id` (`sample_id`,`investigator_id`),
  KEY `investigator_id` (`investigator_id`),
  CONSTRAINT `sample_to_investigator_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_to_investigator_ibfk_2` FOREIGN KEY (`investigator_id`) REFERENCES `investigator` (`investigator_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2362 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_ontology`
--

DROP TABLE IF EXISTS `sample_to_ontology`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_ontology` (
  `sample_to_ontology_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned DEFAULT NULL,
  `ontology_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`sample_to_ontology_id`),
  KEY `sample_id` (`sample_id`),
  KEY `ontology_id` (`ontology_id`),
  CONSTRAINT `sample_to_ontology_ibfk_2` FOREIGN KEY (`ontology_id`) REFERENCES `ontology` (`ontology_id`),
  CONSTRAINT `sample_to_ontology_ibfk_3` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_protein`
--

DROP TABLE IF EXISTS `sample_to_protein`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_protein` (
  `sample_to_protein_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `protein_id` int(10) unsigned NOT NULL,
  `protein_evidence_type_id` int(10) unsigned NOT NULL,
  `read_count` int(11) NOT NULL,
  PRIMARY KEY (`sample_to_protein_id`),
  KEY `fk_stpfks` (`sample_id`),
  KEY `fk_stpfkp` (`protein_id`),
  KEY `fk_stpfkpet` (`protein_evidence_type_id`),
  CONSTRAINT `fk_stpfkp` FOREIGN KEY (`protein_id`) REFERENCES `protein` (`protein_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_stpfkpet` FOREIGN KEY (`protein_evidence_type_id`) REFERENCES `protein_evidence_type` (`protein_evidence_type_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_stpfks` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17596452 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_sample_file_attr`
--

DROP TABLE IF EXISTS `sample_to_sample_file_attr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_sample_file_attr` (
  `sample_to_sample_file_attr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `sample_file_attr_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_to_sample_file_attr_id`),
  UNIQUE KEY `type` (`sample_id`,`sample_file_attr_id`),
  KEY `sample_file_attr_id` (`sample_file_attr_id`),
  CONSTRAINT `sample_to_sample_file_attr_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_to_sample_file_attr_ibfk_2` FOREIGN KEY (`sample_file_attr_id`) REFERENCES `sample_file_attr` (`sample_file_attr_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16576 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sample_to_sample_group`
--

DROP TABLE IF EXISTS `sample_to_sample_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_to_sample_group` (
  `sample_to_sample_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_group_id` int(10) unsigned NOT NULL,
  `sample_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_to_sample_group_id`),
  KEY `sample_group_id` (`sample_group_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `sample_to_sample_group_ibfk_1` FOREIGN KEY (`sample_group_id`) REFERENCES `sample_group` (`sample_group_id`) ON DELETE CASCADE,
  CONSTRAINT `sample_to_sample_group_ibfk_2` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search` (
  `search_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) DEFAULT NULL,
  `primary_key` int(10) unsigned DEFAULT NULL,
  `object_name` varchar(255) DEFAULT NULL,
  `search_text` longtext,
  PRIMARY KEY (`search_id`),
  FULLTEXT KEY `search_text` (`search_text`)
) ENGINE=MyISAM AUTO_INCREMENT=916934 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uproc_kegg_result`
--

DROP TABLE IF EXISTS `uproc_kegg_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uproc_kegg_result` (
  `uproc_kegg_result_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `kegg_annotation_id` varchar(16) NOT NULL,
  `read_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`uproc_kegg_result_id`),
  UNIQUE KEY `kegg_annotation_id` (`kegg_annotation_id`,`sample_id`),
  KEY `sample_id` (`sample_id`),
  CONSTRAINT `uproc_kegg_result_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `uproc_kegg_result_ibfk_2` FOREIGN KEY (`kegg_annotation_id`) REFERENCES `kegg_annotation` (`kegg_annotation_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9615907 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uproc_pfam_result`
--

DROP TABLE IF EXISTS `uproc_pfam_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uproc_pfam_result` (
  `sample_to_uproc_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `uproc_id` int(10) unsigned NOT NULL,
  `read_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`sample_to_uproc_id`),
  UNIQUE KEY `sample_id` (`sample_id`,`uproc_id`),
  KEY `uproc_id` (`uproc_id`),
  CONSTRAINT `uproc_pfam_result_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`) ON DELETE CASCADE,
  CONSTRAINT `uproc_pfam_result_ibfk_2` FOREIGN KEY (`uproc_id`) REFERENCES `pfam_annotation` (`uproc_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7888929 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(50) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orcid` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=149 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-21 10:12:12
