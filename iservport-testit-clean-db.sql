-- MySQL dump 10.13  Distrib 5.6.19, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: phase23
-- ------------------------------------------------------
-- Server version	5.6.19-0ubuntu0.14.04.1

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
-- Table structure for table `core_UserConnection`
--

DROP TABLE IF EXISTS `core_UserConnection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_UserConnection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accessToken` varchar(255) NOT NULL,
  `displayName` varchar(128) DEFAULT NULL,
  `expireTime` bigint(20) NOT NULL,
  `imageUrl` varchar(512) DEFAULT NULL,
  `profileUrl` varchar(512) DEFAULT NULL,
  `providerId` varchar(255) NOT NULL,
  `providerUserId` varchar(255) DEFAULT NULL,
  `rank` int(11) NOT NULL,
  `refreshToken` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL,
  `version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`providerId`,`providerUserId`),
  UNIQUE KEY `userId_2` (`userId`,`providerId`,`rank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_UserConnection`
--

LOCK TABLES `core_UserConnection` WRITE;
/*!40000 ALTER TABLE `core_UserConnection` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_UserConnection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_address`
--

DROP TABLE IF EXISTS `core_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(32) DEFAULT NULL,
  `address3` varchar(32) DEFAULT NULL,
  `addressClassifier` varchar(10) DEFAULT NULL,
  `addressDetail` varchar(24) DEFAULT NULL,
  `addressNumber` varchar(8) DEFAULT NULL,
  `cityName` varchar(64) DEFAULT NULL,
  `postOfficeBox` varchar(10) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `addressType` char(1) NOT NULL,
  `version` int(11) NOT NULL,
  `cityId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identityId` (`identityId`,`addressType`),
  KEY `FK18B7E3547D7E1414` (`identityId`),
  KEY `FK18B7E3545434C220` (`stateId`),
  KEY `FK18B7E354522AF4AE` (`cityId`),
  CONSTRAINT `FK18B7E354522AF4AE` FOREIGN KEY (`cityId`) REFERENCES `core_city` (`id`),
  CONSTRAINT `FK18B7E3545434C220` FOREIGN KEY (`stateId`) REFERENCES `core_state` (`id`),
  CONSTRAINT `FK18B7E3547D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_address`
--

LOCK TABLES `core_address` WRITE;
/*!40000 ALTER TABLE `core_address` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_authority`
--

DROP TABLE IF EXISTS `core_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorityState` varchar(20) DEFAULT NULL,
  `serviceCode` varchar(20) DEFAULT NULL,
  `serviceExtension` varchar(128) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `userGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userGroupId` (`userGroupId`,`serviceCode`),
  KEY `FKEE1FF6A394FFCF1A` (`userGroupId`),
  CONSTRAINT `FKEE1FF6A394FFCF1A` FOREIGN KEY (`userGroupId`) REFERENCES `core_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_authority`
--

LOCK TABLES `core_authority` WRITE;
/*!40000 ALTER TABLE `core_authority` DISABLE KEYS */;
INSERT INTO `core_authority` VALUES (1,'ACTIVE','ADMIN','READ,WRITE,MANAGER',0,1),(2,'ACTIVE','USER','READ,WRITE',0,1);
/*!40000 ALTER TABLE `core_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_calendar`
--

DROP TABLE IF EXISTS `core_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_calendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calendarCode` varchar(12) DEFAULT NULL,
  `calendarName` varchar(64) DEFAULT NULL,
  `calendarType` char(1) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `contextId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`calendarCode`),
  KEY `FK3C479FDEAFF118AB` (`contextId`),
  CONSTRAINT `FK3C479FDEAFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_calendar`
--

LOCK TABLES `core_calendar` WRITE;
/*!40000 ALTER TABLE `core_calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_category`
--

DROP TABLE IF EXISTS `core_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longblob,
  `encoding` varchar(32) DEFAULT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `activityCode` char(1) DEFAULT NULL,
  `categoryCode` varchar(20) DEFAULT NULL,
  `categoryGroup` char(1) NOT NULL,
  `categoryGroupType` varchar(255) DEFAULT NULL,
  `categoryIcon` varchar(64) DEFAULT NULL,
  `categoryLabel` varchar(32) DEFAULT NULL,
  `categoryName` varchar(64) DEFAULT NULL,
  `customNumberPattern` varchar(12) DEFAULT NULL,
  `customProperties` varchar(512) DEFAULT NULL,
  `customStyle` varchar(255) DEFAULT NULL,
  `customWorkflowRoles` varchar(255) DEFAULT NULL,
  `numberOfDigits` int(11) NOT NULL,
  `partnerFilterPattern` varchar(20) DEFAULT NULL,
  `patternPrefix` varchar(64) DEFAULT NULL,
  `patternSuffix` varchar(64) DEFAULT NULL,
  `priority` char(1) NOT NULL,
  `referenceList` varchar(1024) DEFAULT NULL,
  `scriptItems` varchar(255) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`categoryGroup`,`categoryCode`),
  KEY `FK49EB619E4E55E05E` (`entityId`),
  CONSTRAINT `FK49EB619E4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_category`
--

LOCK TABLES `core_category` WRITE;
/*!40000 ALTER TABLE `core_category` DISABLE KEYS */;
INSERT INTO `core_category` VALUES (1,'','iso_88591','text/plain','A','ALL','S',NULL,'','','Produtos e serviços','','','','',2,'','','','0','','',1);
/*!40000 ALTER TABLE `core_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_city`
--

DROP TABLE IF EXISTS `core_city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `capital` bit(1) NOT NULL,
  `cityCode` varchar(12) DEFAULT NULL,
  `cityName` varchar(64) DEFAULT NULL,
  `priority` char(1) NOT NULL,
  `version` int(11) NOT NULL,
  `contextId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`cityCode`),
  UNIQUE KEY `stateId` (`stateId`,`cityCode`),
  KEY `FKA1628E0B5434C220` (`stateId`),
  KEY `FKA1628E0BAFF118AB` (`contextId`),
  CONSTRAINT `FKA1628E0BAFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FKA1628E0B5434C220` FOREIGN KEY (`stateId`) REFERENCES `core_state` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5565 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_city`
--

LOCK TABLES `core_city` WRITE;
/*!40000 ALTER TABLE `core_city` DISABLE KEYS */;
INSERT INTO `core_city` VALUES (1,'\0','1200203','Cruzeiro do Sul','0',0,1,1),(2,'\0','1200336','Mâncio Lima','0',0,1,1),(3,'\0','1200351','Marechal Thaumaturgo','0',0,1,1),(4,'\0','1200393','Porto Walter','0',0,1,1),(5,'\0','1200427','Rodrigues Alves','0',0,1,1),(6,'\0','1200302','Feijó','0',0,1,1),(7,'\0','1200328','Jordão','0',0,1,1),(8,'\0','1200609','Tarauacá','0',0,1,1),(9,'\0','1200344','Manoel Urbano','0',0,1,1),(10,'\0','1200435','Santa Rosa do Purus','0',0,1,1),(11,'\0','1200500','Sena Madureira','0',0,1,1),(12,'\0','1200013','Acrelândia','0',0,1,1),(13,'\0','1200138','Bujari','0',0,1,1),(14,'\0','1200179','Capixaba','0',0,1,1),(15,'\0','1200385','Plácido de Castro','0',0,1,1),(16,'\0','1200401','Rio Branco','0',0,1,1),(17,'\0','1200450','Senador Guiomard','0',0,1,1),(18,'\0','1200807','Porto Acre','0',0,1,1),(19,'\0','1200054','Assis Brasil','0',0,1,1),(20,'\0','1200104','Brasiléia','0',0,1,1),(21,'\0','1200252','Epitaciolândia','0',0,1,1),(22,'\0','1200708','Xapuri','0',0,1,1),(23,'\0','2700102','Água Branca','0',0,1,2),(24,'\0','2701605','Canapi','0',0,1,2),(25,'\0','2703304','Inhapi','0',0,1,2),(26,'\0','2705002','Mata Grande','0',0,1,2),(27,'\0','2706422','Pariconha','0',0,1,2),(28,'\0','2702405','Delmiro Gouveia','0',0,1,2),(29,'\0','2705804','Olho d\'Água do Casado','0',0,1,2),(30,'\0','2707107','Piranhas','0',0,1,2),(31,'\0','2701803','Carneiros','0',0,1,2),(32,'\0','2702504','Dois Riachos','0',0,1,2),(33,'\0','2704609','Maravilha','0',0,1,2),(34,'\0','2706109','Ouro Branco','0',0,1,2),(35,'\0','2706208','Palestina','0',0,1,2),(36,'\0','2706406','Pão de Açúcar','0',0,1,2),(37,'\0','2707206','Poço das Trincheiras','0',0,1,2),(38,'\0','2708006','Santana do Ipanema','0',0,1,2),(39,'\0','2708402','São José da Tapera','0',0,1,2),(40,'\0','2708956','Senador Rui Palmeira','0',0,1,2),(41,'\0','2700706','Batalha','0',0,1,2),(42,'\0','2700904','Belo Monte','0',0,1,2),(43,'\0','2703403','Jacaré dos Homens','0',0,1,2),(44,'\0','2703700','Jaramataia','0',0,1,2),(45,'\0','2704401','Major Isidoro','0',0,1,2),(46,'\0','2705408','Monteirópolis','0',0,1,2),(47,'\0','2705705','Olho d\'Água das Flores','0',0,1,2),(48,'\0','2706000','Olivença','0',0,1,2),(49,'\0','2700805','Belém','0',0,1,2),(50,'\0','2701209','Cacimbinhas','0',0,1,2),(51,'\0','2702553','Estrela de Alagoas','0',0,1,2),(52,'\0','2703106','Igaci','0',0,1,2),(53,'\0','2704807','Maribondo','0',0,1,2),(54,'\0','2704906','Mar Vermelho','0',0,1,2),(55,'\0','2705309','Minador do Negrão','0',0,1,2),(56,'\0','2706307','Palmeira dos Índios','0',0,1,2),(57,'\0','2706604','Paulo Jacinto','0',0,1,2),(58,'\0','2707602','Quebrangulo','0',0,1,2),(59,'\0','2709004','Tanque d\'Arca','0',0,1,2),(60,'\0','2700300','Arapiraca','0',0,1,2),(61,'\0','2701506','Campo Grande','0',0,1,2),(62,'\0','2702009','Coité do Nóia','0',0,1,2),(63,'\0','2702355','Craíbas','0',0,1,2),(64,'\0','2702603','Feira Grande','0',0,1,2),(65,'\0','2702900','Girau do Ponciano','0',0,1,2),(66,'\0','2704104','Lagoa da Canoa','0',0,1,2),(67,'\0','2704203','Limoeiro de Anadia','0',0,1,2),(68,'\0','2708808','São Sebastião','0',0,1,2),(69,'\0','2709103','Taquarana','0',0,1,2),(70,'\0','2705903','Olho d\'Água Grande','0',0,1,2),(71,'\0','2708204','São Brás','0',0,1,2),(72,'\0','2709202','Traipu','0',0,1,2),(73,'\0','2701902','Chã Preta','0',0,1,2),(74,'\0','2703007','Ibateguara','0',0,1,2),(75,'\0','2707008','Pindoba','0',0,1,2),(76,'\0','2708105','Santana do Mundaú','0',0,1,2),(77,'\0','2708303','São José da Laje','0',0,1,2),(78,'\0','2709301','União dos Palmares','0',0,1,2),(79,'\0','2709400','Viçosa','0',0,1,2),(80,'\0','2700409','Atalaia','0',0,1,2),(81,'\0','2701100','Branquinha','0',0,1,2),(82,'\0','2701308','Cajueiro','0',0,1,2),(83,'\0','2701357','Campestre','0',0,1,2),(84,'\0','2701704','Capela','0',0,1,2),(85,'\0','2702108','Colônia Leopoldina','0',0,1,2),(86,'\0','2702801','Flexeiras','0',0,1,2),(87,'\0','2703502','Jacuípe','0',0,1,2),(88,'\0','2703809','Joaquim Gomes','0',0,1,2),(89,'\0','2703908','Jundiá','0',0,1,2),(90,'\0','2705101','Matriz de Camaragibe','0',0,1,2),(91,'\0','2705200','Messias','0',0,1,2),(92,'\0','2705507','Murici','0',0,1,2),(93,'\0','2705606','Novo Lino','0',0,1,2),(94,'\0','2707305','Porto Calvo','0',0,1,2),(95,'\0','2708501','São Luís do Quitunde','0',0,1,2),(96,'\0','2703601','Japaratinga','0',0,1,2),(97,'\0','2704500','Maragogi','0',0,1,2),(98,'\0','2706505','Passo de Camaragibe','0',0,1,2),(99,'\0','2707404','Porto de Pedras','0',0,1,2),(100,'\0','2708709','São Miguel dos Milagres','0',0,1,2),(101,'\0','2700508','Barra de Santo Antônio','0',0,1,2),(102,'\0','2700607','Barra de São Miguel','0',0,1,2),(103,'\0','2702207','Coqueiro Seco','0',0,1,2),(104,'\0','2704302','Maceió','0',0,1,2),(105,'\0','2704708','Marechal Deodoro','0',0,1,2),(106,'\0','2706448','Paripueira','0',0,1,2),(107,'\0','2706901','Pilar','0',0,1,2),(108,'\0','2707701','Rio Largo','0',0,1,2),(109,'\0','2707909','Santa Luzia do Norte','0',0,1,2),(110,'\0','2708907','Satuba','0',0,1,2),(111,'\0','2700201','Anadia','0',0,1,2),(112,'\0','2701001','Boca da Mata','0',0,1,2),(113,'\0','2701407','Campo Alegre','0',0,1,2),(114,'\0','2702306','Coruripe','0',0,1,2),(115,'\0','2703759','Jequiá da Praia','0',0,1,2),(116,'\0','2704005','Junqueiro','0',0,1,2),(117,'\0','2707800','Roteiro','0',0,1,2),(118,'\0','2708600','São Miguel dos Campos','0',0,1,2),(119,'\0','2709152','Teotônio Vilela','0',0,1,2),(120,'\0','2702702','Feliz Deserto','0',0,1,2),(121,'\0','2703205','Igreja Nova','0',0,1,2),(122,'\0','2706703','Penedo','0',0,1,2),(123,'\0','2706802','Piaçabuçu','0',0,1,2),(124,'\0','2707503','Porto Real do Colégio','0',0,1,2),(125,'\0','1300409','Barcelos','0',0,1,3),(126,'\0','1303205','Novo Airão','0',0,1,3),(127,'\0','1303601','Santa Isabel do Rio Negro','0',0,1,3),(128,'\0','1303809','São Gabriel da Cachoeira','0',0,1,3),(129,'\0','1302108','Japurá','0',0,1,3),(130,'\0','1302801','Maraã','0',0,1,3),(131,'\0','1300060','Amaturá','0',0,1,3),(132,'\0','1300201','Atalaia do Norte','0',0,1,3),(133,'\0','1300607','Benjamin Constant','0',0,1,3),(134,'\0','1301605','Fonte Boa','0',0,1,3),(135,'\0','1302306','Jutaí','0',0,1,3),(136,'\0','1303700','Santo Antônio do Içá','0',0,1,3),(137,'\0','1303908','São Paulo de Olivença','0',0,1,3),(138,'\0','1304062','Tabatinga','0',0,1,3),(139,'\0','1304237','Tonantins','0',0,1,3),(140,'\0','1301001','Carauari','0',0,1,3),(141,'\0','1301407','Eirunepé','0',0,1,3),(142,'\0','1301506','Envira','0',0,1,3),(143,'\0','1301654','Guajará','0',0,1,3),(144,'\0','1301803','Ipixuna','0',0,1,3),(145,'\0','1301951','Itamarati','0',0,1,3),(146,'\0','1302207','Juruá','0',0,1,3),(147,'\0','1300029','Alvarães','0',0,1,3),(148,'\0','1304203','Tefé','0',0,1,3),(149,'\0','1304260','Uarini','0',0,1,3),(150,'\0','1300086','Anamã','0',0,1,3),(151,'\0','1300102','Anori','0',0,1,3),(152,'\0','1300631','Beruri','0',0,1,3),(153,'\0','1300839','Caapiranga','0',0,1,3),(154,'\0','1301209','Coari','0',0,1,3),(155,'\0','1301308','Codajás','0',0,1,3),(156,'\0','1300300','Autazes','0',0,1,3),(157,'\0','1301100','Careiro','0',0,1,3),(158,'\0','1301159','Careiro da Várzea','0',0,1,3),(159,'\0','1301852','Iranduba','0',0,1,3),(160,'\0','1302504','Manacapuru','0',0,1,3),(161,'\0','1302553','Manaquiri','0',0,1,3),(162,'\0','1302603','Manaus','0',0,1,3),(163,'\0','1303536','Presidente Figueiredo','0',0,1,3),(164,'\0','1303569','Rio Preto da Eva','0',0,1,3),(165,'\0','1301902','Itacoatiara','0',0,1,3),(166,'\0','1302009','Itapiranga','0',0,1,3),(167,'\0','1303106','Nova Olinda do Norte','0',0,1,3),(168,'\0','1304005','Silves','0',0,1,3),(169,'\0','1304401','Urucurituba','0',0,1,3),(170,'\0','1300508','Barreirinha','0',0,1,3),(171,'\0','1300680','Boa Vista do Ramos','0',0,1,3),(172,'\0','1302900','Maués','0',0,1,3),(173,'\0','1303007','Nhamundá','0',0,1,3),(174,'\0','1303403','Parintins','0',0,1,3),(175,'\0','1303957','São Sebastião do Uatumã','0',0,1,3),(176,'\0','1304302','Urucará','0',0,1,3),(177,'\0','1300706','Boca do Acre','0',0,1,3),(178,'\0','1303502','Pauini','0',0,1,3),(179,'\0','1300904','Canutama','0',0,1,3),(180,'\0','1302405','Lábrea','0',0,1,3),(181,'\0','1304104','Tapauá','0',0,1,3),(182,'\0','1300144','Apuí','0',0,1,3),(183,'\0','1300805','Borba','0',0,1,3),(184,'\0','1301704','Humaitá','0',0,1,3),(185,'\0','1302702','Manicoré','0',0,1,3),(186,'\0','1303304','Novo Aripuanã','0',0,1,3),(187,'\0','1600204','Calçoene','0',0,1,4),(188,'\0','1600501','Oiapoque','0',0,1,4),(189,'\0','1600105','Amapá','0',0,1,4),(190,'\0','1600550','Pracuúba','0',0,1,4),(191,'\0','1600709','Tartarugalzinho','0',0,1,4),(192,'\0','1600055','Serra do Navio','0',0,1,4),(193,'\0','1600154','Pedra Branca do Amapari','0',0,1,4),(194,'\0','1600212','Cutias','0',0,1,4),(195,'\0','1600238','Ferreira Gomes','0',0,1,4),(196,'\0','1600253','Itaubal','0',0,1,4),(197,'\0','1600303','Macapá','0',0,1,4),(198,'\0','1600535','Porto Grande','0',0,1,4),(199,'\0','1600600','Santana','0',0,1,4),(200,'\0','1600279','Laranjal do Jari','0',0,1,4),(201,'\0','1600402','Mazagão','0',0,1,4),(202,'\0','1600808','Vitória do Jari','0',0,1,4),(203,'\0','2902500','Baianópolis','0',0,1,5),(204,'\0','2903201','Barreiras','0',0,1,5),(205,'\0','2907400','Catolândia','0',0,1,5),(206,'\0','2911105','Formosa do Rio Preto','0',0,1,5),(207,'\0','2919553','Luís Eduardo Magalhães','0',0,1,5),(208,'\0','2926202','Riachão das Neves','0',0,1,5),(209,'\0','2928901','São Desidério','0',0,1,5),(210,'\0','2901403','Angical','0',0,1,5),(211,'\0','2904407','Brejolândia','0',0,1,5),(212,'\0','2909406','Cotegipe','0',0,1,5),(213,'\0','2909703','Cristópolis','0',0,1,5),(214,'\0','2920452','Mansidão','0',0,1,5),(215,'\0','2928406','Santa Rita de Cássia','0',0,1,5),(216,'\0','2930907','Tabocas do Brejo Velho','0',0,1,5),(217,'\0','2933455','Wanderley','0',0,1,5),(218,'\0','2906105','Canápolis','0',0,1,5),(219,'\0','2908101','Cocos','0',0,1,5),(220,'\0','2909109','Coribe','0',0,1,5),(221,'\0','2909307','Correntina','0',0,1,5),(222,'\0','2917359','Jaborandi','0',0,1,5),(223,'\0','2928109','Santa Maria da Vitória','0',0,1,5),(224,'\0','2928208','Santana','0',0,1,5),(225,'\0','2929057','São Félix do Coribe','0',0,1,5),(226,'\0','2930303','Serra Dourada','0',0,1,5),(227,'\0','2905909','Campo Alegre de Lourdes','0',0,1,5),(228,'\0','2907202','Casa Nova','0',0,1,5),(229,'\0','2909901','Curaçá','0',0,1,5),(230,'\0','2918407','Juazeiro','0',0,1,5),(231,'\0','2924405','Pilão Arcado','0',0,1,5),(232,'\0','2926004','Remanso','0',0,1,5),(233,'\0','2930204','Sento Sé','0',0,1,5),(234,'\0','2930774','Sobradinho','0',0,1,5),(235,'\0','2900207','Abaré','0',0,1,5),(236,'\0','2907707','Chorrochó','0',0,1,5),(237,'\0','2911402','Glória','0',0,1,5),(238,'\0','2919900','Macururé','0',0,1,5),(239,'\0','2924009','Paulo Afonso','0',0,1,5),(240,'\0','2927101','Rodelas','0',0,1,5),(241,'\0','2902708','Barra','0',0,1,5),(242,'\0','2904753','Buritirama','0',0,1,5),(243,'\0','2913200','Ibotirama','0',0,1,5),(244,'\0','2915353','Itaguaçu da Bahia','0',0,1,5),(245,'\0','2921609','Morpará','0',0,1,5),(246,'\0','2922250','Muquém de São Francisco','0',0,1,5),(247,'\0','2933604','Xique-Xique','0',0,1,5),(248,'\0','2903904','Bom Jesus da Lapa','0',0,1,5),(249,'\0','2907103','Carinhanha','0',0,1,5),(250,'\0','2910776','Feira da Mata','0',0,1,5),(251,'\0','2923704','Paratinga','0',0,1,5),(252,'\0','2930154','Serra do Ramalho','0',0,1,5),(253,'\0','2930758','Sítio do Mato','0',0,1,5),(254,'\0','2901353','Andorinha','0',0,1,5),(255,'\0','2901809','Antônio Gonçalves','0',0,1,5),(256,'\0','2906006','Campo Formoso','0',0,1,5),(257,'\0','2910859','Filadélfia','0',0,1,5),(258,'\0','2917003','Itiúba','0',0,1,5),(259,'\0','2917706','Jaguarari','0',0,1,5),(260,'\0','2924603','Pindobaçu','0',0,1,5),(261,'\0','2930105','Senhor do Bonfim','0',0,1,5),(262,'\0','2932457','Umburanas','0',0,1,5),(263,'\0','2901155','América Dourada','0',0,1,5),(264,'\0','2903003','Barra do Mendes','0',0,1,5),(265,'\0','2903235','Barro Alto','0',0,1,5),(266,'\0','2905305','Cafarnaum','0',0,1,5),(267,'\0','2906204','Canarana','0',0,1,5),(268,'\0','2907608','Central','0',0,1,5),(269,'\0','2911303','Gentio do Ouro','0',0,1,5),(270,'\0','2912400','Ibipeba','0',0,1,5),(271,'\0','2913101','Ibititá','0',0,1,5),(272,'\0','2914406','Iraquara','0',0,1,5),(273,'\0','2914604','Irecê','0',0,1,5),(274,'\0','2918357','João Dourado','0',0,1,5),(275,'\0','2918506','Jussara','0',0,1,5),(276,'\0','2919157','Lapão','0',0,1,5),(277,'\0','2922052','Mulungu do Morro','0',0,1,5),(278,'\0','2925600','Presidente Dutra','0',0,1,5),(279,'\0','2929255','São Gabriel','0',0,1,5),(280,'\0','2930808','Souto Soares','0',0,1,5),(281,'\0','2932408','Uibaí','0',0,1,5),(282,'\0','2905107','Caém','0',0,1,5),(283,'\0','2905503','Caldeirão Grande','0',0,1,5),(284,'\0','2906873','Capim Grosso','0',0,1,5),(285,'\0','2917508','Jacobina','0',0,1,5),(286,'\0','2921203','Miguel Calmon','0',0,1,5),(287,'\0','2921401','Mirangaba','0',0,1,5),(288,'\0','2921708','Morro do Chapéu','0',0,1,5),(289,'\0','2923357','Ourolândia','0',0,1,5),(290,'\0','2924801','Piritiba','0',0,1,5),(291,'\0','2925253','Ponto Novo','0',0,1,5),(292,'\0','2925931','Quixabeira','0',0,1,5),(293,'\0','2929370','São José do Jacuípe','0',0,1,5),(294,'\0','2929800','Saúde','0',0,1,5),(295,'\0','2930600','Serrolândia','0',0,1,5),(296,'\0','2933109','Várzea do Poço','0',0,1,5),(297,'\0','2933158','Várzea Nova','0',0,1,5),(298,'\0','2902609','Baixa Grande','0',0,1,5),(299,'\0','2903805','Boa Vista do Tupim','0',0,1,5),(300,'\0','2911907','Iaçu','0',0,1,5),(301,'\0','2912608','Ibiquera','0',0,1,5),(302,'\0','2914703','Itaberaba','0',0,1,5),(303,'\0','2919009','Lajedinho','0',0,1,5),(304,'\0','2919603','Macajuba','0',0,1,5),(305,'\0','2920106','Mairi','0',0,1,5),(306,'\0','2922102','Mundo Novo','0',0,1,5),(307,'\0','2927200','Ruy Barbosa','0',0,1,5),(308,'\0','2931301','Tapiramutá','0',0,1,5),(309,'\0','2933059','Várzea da Roça','0',0,1,5),(310,'\0','2900405','Água Fria','0',0,1,5),(311,'\0','2901502','Anguera','0',0,1,5),(312,'\0','2901700','Antônio Cardoso','0',0,1,5),(313,'\0','2908200','Conceição da Feira','0',0,1,5),(314,'\0','2908507','Conceição do Jacuípe','0',0,1,5),(315,'\0','2908903','Coração de Maria','0',0,1,5),(316,'\0','2910305','Elísio Medrado','0',0,1,5),(317,'\0','2910800','Feira de Santana','0',0,1,5),(318,'\0','2913804','Ipecaetá','0',0,1,5),(319,'\0','2914000','Ipirá','0',0,1,5),(320,'\0','2914505','Irará','0',0,1,5),(321,'\0','2916856','Itatim','0',0,1,5),(322,'\0','2923308','Ouriçangas','0',0,1,5),(323,'\0','2924108','Pedrão','0',0,1,5),(324,'\0','2924652','Pintadas','0',0,1,5),(325,'\0','2925956','Rafael Jambeiro','0',0,1,5),(326,'\0','2927507','Santa Bárbara','0',0,1,5),(327,'\0','2928307','Santanópolis','0',0,1,5),(328,'\0','2928505','Santa Teresinha','0',0,1,5),(329,'\0','2928802','Santo Estêvão','0',0,1,5),(330,'\0','2929305','São Gonçalo dos Campos','0',0,1,5),(331,'\0','2930402','Serra Preta','0',0,1,5),(332,'\0','2931103','Tanquinho','0',0,1,5),(333,'\0','2931400','Teodoro Sampaio','0',0,1,5),(334,'\0','2909208','Coronel João Sá','0',0,1,5),(335,'\0','2918100','Jeremoabo','0',0,1,5),(336,'\0','2924207','Pedro Alexandre','0',0,1,5),(337,'\0','2927606','Santa Brígida','0',0,1,5),(338,'\0','2930766','Sítio do Quinto','0',0,1,5),(339,'\0','2906808','Cansanção','0',0,1,5),(340,'\0','2906824','Canudos','0',0,1,5),(341,'\0','2910701','Euclides da Cunha','0',0,1,5),(342,'\0','2921500','Monte Santo','0',0,1,5),(343,'\0','2922656','Nordestina','0',0,1,5),(344,'\0','2925808','Queimadas','0',0,1,5),(345,'\0','2925907','Quijingue','0',0,1,5),(346,'\0','2931905','Tucano','0',0,1,5),(347,'\0','2932002','Uauá','0',0,1,5),(348,'\0','2900355','Adustina','0',0,1,5),(349,'\0','2901601','Antas','0',0,1,5),(350,'\0','2902658','Banzaê','0',0,1,5),(351,'\0','2907806','Cícero Dantas','0',0,1,5),(352,'\0','2907905','Cipó','0',0,1,5),(353,'\0','2910750','Fátima','0',0,1,5),(354,'\0','2911857','Heliópolis','0',0,1,5),(355,'\0','2916500','Itapicuru','0',0,1,5),(356,'\0','2922904','Nova Soure','0',0,1,5),(357,'\0','2923050','Novo Triunfo','0',0,1,5),(358,'\0','2923100','Olindina','0',0,1,5),(359,'\0','2923803','Paripiranga','0',0,1,5),(360,'\0','2926509','Ribeira do Amparo','0',0,1,5),(361,'\0','2926608','Ribeira do Pombal','0',0,1,5),(362,'\0','2902104','Araci','0',0,1,5),(363,'\0','2903276','Barrocas','0',0,1,5),(364,'\0','2903607','Biritinga','0',0,1,5),(365,'\0','2906402','Candeal','0',0,1,5),(366,'\0','2906857','Capela do Alto Alegre','0',0,1,5),(367,'\0','2908408','Conceição do Coité','0',0,1,5),(368,'\0','2911253','Gavião','0',0,1,5),(369,'\0','2913309','Ichu','0',0,1,5),(370,'\0','2919108','Lamarão','0',0,1,5),(371,'\0','2922730','Nova Fátima','0',0,1,5),(372,'\0','2924058','Pé de Serra','0',0,1,5),(373,'\0','2926103','Retirolândia','0',0,1,5),(374,'\0','2926301','Riachão do Jacuípe','0',0,1,5),(375,'\0','2928000','Santaluz','0',0,1,5),(376,'\0','2928950','São Domingos','0',0,1,5),(377,'\0','2930501','Serrinha','0',0,1,5),(378,'\0','2931509','Teofilândia','0',0,1,5),(379,'\0','2933000','Valente','0',0,1,5),(380,'\0','2900306','Acajutiba','0',0,1,5),(381,'\0','2900702','Alagoinhas','0',0,1,5),(382,'\0','2901908','Aporá','0',0,1,5),(383,'\0','2902054','Araças','0',0,1,5),(384,'\0','2902203','Aramari','0',0,1,5),(385,'\0','2909604','Crisópolis','0',0,1,5),(386,'\0','2913705','Inhambupe','0',0,1,5),(387,'\0','2927002','Rio Real','0',0,1,5),(388,'\0','2929701','Sátiro Dias','0',0,1,5),(389,'\0','2907004','Cardeal da Silva','0',0,1,5),(390,'\0','2908606','Conde','0',0,1,5),(391,'\0','2910503','Entre Rios','0',0,1,5),(392,'\0','2910602','Esplanada','0',0,1,5),(393,'\0','2917904','Jandaíra','0',0,1,5),(394,'\0','2901106','Amélia Rodrigues','0',0,1,5),(395,'\0','2907509','Catu','0',0,1,5),(396,'\0','2915908','Itanagra','0',0,1,5),(397,'\0','2921005','Mata de São João','0',0,1,5),(398,'\0','2925204','Pojuca','0',0,1,5),(399,'\0','2929503','São Sebastião do Passé','0',0,1,5),(400,'\0','2931707','Terra Nova','0',0,1,5),(401,'\0','2902302','Aratuípe','0',0,1,5),(402,'\0','2904852','Cabaceiras do Paraguaçu','0',0,1,5),(403,'\0','2904902','Cachoeira','0',0,1,5),(404,'\0','2907301','Castro Alves','0',0,1,5),(405,'\0','2908309','Conceição do Almeida','0',0,1,5),(406,'\0','2909802','Cruz das Almas','0',0,1,5),(407,'\0','2910206','Dom Macedo Costa','0',0,1,5),(408,'\0','2911600','Governador Mangabeira','0',0,1,5),(409,'\0','2917805','Jaguaripe','0',0,1,5),(410,'\0','2920601','Maragogipe','0',0,1,5),(411,'\0','2922201','Muniz Ferreira','0',0,1,5),(412,'\0','2922300','Muritiba','0',0,1,5),(413,'\0','2922508','Nazaré','0',0,1,5),(414,'\0','2927309','Salinas da Margarida','0',0,1,5),(415,'\0','2928604','Santo Amaro','0',0,1,5),(416,'\0','2928703','Santo Antônio de Jesus','0',0,1,5),(417,'\0','2929008','São Félix','0',0,1,5),(418,'\0','2929107','São Felipe','0',0,1,5),(419,'\0','2929602','Sapeaçu','0',0,1,5),(420,'\0','2929750','Saubara','0',0,1,5),(421,'\0','2933174','Varzedo','0',0,1,5),(422,'\0','2905701','Camaçari','0',0,1,5),(423,'\0','2906501','Candeias','0',0,1,5),(424,'\0','2910057','Dias d\'Ávila','0',0,1,5),(425,'\0','2916104','Itaparica','0',0,1,5),(426,'\0','2919207','Lauro de Freitas','0',0,1,5),(427,'\0','2919926','Madre de Deus','0',0,1,5),(428,'\0','2927408','Salvador','0',0,1,5),(429,'\0','2929206','São Francisco do Conde','0',0,1,5),(430,'\0','2930709','Simões Filho','0',0,1,5),(431,'\0','2933208','Vera Cruz','0',0,1,5),(432,'\0','2904100','Boquira','0',0,1,5),(433,'\0','2904209','Botuporã','0',0,1,5),(434,'\0','2904506','Brotas de Macaúbas','0',0,1,5),(435,'\0','2907558','Caturama','0',0,1,5),(436,'\0','2912509','Ibipitanga','0',0,1,5),(437,'\0','2913002','Ibitiara','0',0,1,5),(438,'\0','2914109','Ipupiara','0',0,1,5),(439,'\0','2919801','Macaúbas','0',0,1,5),(440,'\0','2923035','Novo Horizonte','0',0,1,5),(441,'\0','2923209','Oliveira dos Brejinhos','0',0,1,5),(442,'\0','2931053','Tanque Novo','0',0,1,5),(443,'\0','2900108','Abaíra','0',0,1,5),(444,'\0','2901304','Andaraí','0',0,1,5),(445,'\0','2902807','Barra da Estiva','0',0,1,5),(446,'\0','2904001','Boninal','0',0,1,5),(447,'\0','2904050','Bonito','0',0,1,5),(448,'\0','2908804','Contendas do Sincorá','0',0,1,5),(449,'\0','2912202','Ibicoara','0',0,1,5),(450,'\0','2915007','Itaeté','0',0,1,5),(451,'\0','2918605','Jussiape','0',0,1,5),(452,'\0','2919306','Lençóis','0',0,1,5),(453,'\0','2921906','Mucugê','0',0,1,5),(454,'\0','2922854','Nova Redenção','0',0,1,5),(455,'\0','2923506','Palmeiras','0',0,1,5),(456,'\0','2924306','Piatã','0',0,1,5),(457,'\0','2926707','Rio de Contas','0',0,1,5),(458,'\0','2929909','Seabra','0',0,1,5),(459,'\0','2932804','Utinga','0',0,1,5),(460,'\0','2933406','Wagner','0',0,1,5),(461,'\0','2900603','Aiquara','0',0,1,5),(462,'\0','2901007','Amargosa','0',0,1,5),(463,'\0','2901957','Apuarema','0',0,1,5),(464,'\0','2904308','Brejões','0',0,1,5),(465,'\0','2909505','Cravolândia','0',0,1,5),(466,'\0','2914208','Irajuba','0',0,1,5),(467,'\0','2914307','Iramaia','0',0,1,5),(468,'\0','2915106','Itagi','0',0,1,5),(469,'\0','2916708','Itaquara','0',0,1,5),(470,'\0','2916906','Itiruçu','0',0,1,5),(471,'\0','2917607','Jaguaquara','0',0,1,5),(472,'\0','2918001','Jequié','0',0,1,5),(473,'\0','2918209','Jiquiriçá','0',0,1,5),(474,'\0','2918308','Jitaúna','0',0,1,5),(475,'\0','2918704','Lafaiete Coutinho','0',0,1,5),(476,'\0','2918803','Laje','0',0,1,5),(477,'\0','2919058','Lajedo do Tabocal','0',0,1,5),(478,'\0','2920502','Maracás','0',0,1,5),(479,'\0','2920809','Marcionílio Souza','0',0,1,5),(480,'\0','2921302','Milagres','0',0,1,5),(481,'\0','2922409','Mutuípe','0',0,1,5),(482,'\0','2922805','Nova Itarana','0',0,1,5),(483,'\0','2924900','Planaltino','0',0,1,5),(484,'\0','2927903','Santa Inês','0',0,1,5),(485,'\0','2929404','São Miguel das Matas','0',0,1,5),(486,'\0','2932101','Ubaíra','0',0,1,5),(487,'\0','2900504','Érico Cardoso','0',0,1,5),(488,'\0','2910107','Dom Basílio','0',0,1,5),(489,'\0','2919504','Livramento de Nossa Senhora','0',0,1,5),(490,'\0','2923605','Paramirim','0',0,1,5),(491,'\0','2926905','Rio do Pires','0',0,1,5),(492,'\0','2905008','Caculé','0',0,1,5),(493,'\0','2905206','Caetité','0',0,1,5),(494,'\0','2906600','Candiba','0',0,1,5),(495,'\0','2911709','Guanambi','0',0,1,5),(496,'\0','2912004','Ibiassucê','0',0,1,5),(497,'\0','2913408','Igaporã','0',0,1,5),(498,'\0','2917334','Iuiú','0',0,1,5),(499,'\0','2917409','Jacaraci','0',0,1,5),(500,'\0','2918753','Lagoa Real','0',0,1,5),(501,'\0','2919405','Licínio de Almeida','0',0,1,5),(502,'\0','2920205','Malhada','0',0,1,5),(503,'\0','2921054','Matina','0',0,1,5),(504,'\0','2921807','Mortugaba','0',0,1,5),(505,'\0','2923407','Palmas de Monte Alto','0',0,1,5),(506,'\0','2924504','Pindaí','0',0,1,5),(507,'\0','2926400','Riacho de Santana','0',0,1,5),(508,'\0','2930006','Sebastião Laranjeiras','0',0,1,5),(509,'\0','2932606','Urandi','0',0,1,5),(510,'\0','2902005','Aracatu','0',0,1,5),(511,'\0','2904605','Brumado','0',0,1,5),(512,'\0','2906899','Caraíbas','0',0,1,5),(513,'\0','2908705','Condeúba','0',0,1,5),(514,'\0','2909000','Cordeiros','0',0,1,5),(515,'\0','2911659','Guajeru','0',0,1,5),(516,'\0','2917201','Ituaçu','0',0,1,5),(517,'\0','2919959','Maetinga','0',0,1,5),(518,'\0','2920304','Malhada de Pedras','0',0,1,5),(519,'\0','2924702','Piripá','0',0,1,5),(520,'\0','2925709','Presidente Jânio Quadros','0',0,1,5),(521,'\0','2926806','Rio do Antônio','0',0,1,5),(522,'\0','2931004','Tanhaçu','0',0,1,5),(523,'\0','2931806','Tremedal','0',0,1,5),(524,'\0','2901205','Anagé','0',0,1,5),(525,'\0','2902906','Barra do Choça','0',0,1,5),(526,'\0','2903508','Belo Campo','0',0,1,5),(527,'\0','2903706','Boa Nova','0',0,1,5),(528,'\0','2903953','Bom Jesus da Serra','0',0,1,5),(529,'\0','2904803','Caatiba','0',0,1,5),(530,'\0','2905156','Caetanos','0',0,1,5),(531,'\0','2906709','Cândido Sales','0',0,1,5),(532,'\0','2910008','Dário Meira','0',0,1,5),(533,'\0','2912301','Ibicuí','0',0,1,5),(534,'\0','2913507','Iguaí','0',0,1,5),(535,'\0','2920403','Manoel Vitorino','0',0,1,5),(536,'\0','2921450','Mirante','0',0,1,5),(537,'\0','2922706','Nova Canaã','0',0,1,5),(538,'\0','2925006','Planalto','0',0,1,5),(539,'\0','2925105','Poções','0',0,1,5),(540,'\0','2933307','Vitória da Conquista','0',0,1,5),(541,'\0','2910404','Encruzilhada','0',0,1,5),(542,'\0','2915809','Itambé','0',0,1,5),(543,'\0','2916401','Itapetinga','0',0,1,5),(544,'\0','2916807','Itarantim','0',0,1,5),(545,'\0','2917102','Itororó','0',0,1,5),(546,'\0','2919702','Macarani','0',0,1,5),(547,'\0','2920007','Maiquinique','0',0,1,5),(548,'\0','2925402','Potiraguá','0',0,1,5),(549,'\0','2926657','Ribeirão do Largo','0',0,1,5),(550,'\0','2905404','Cairu','0',0,1,5),(551,'\0','2905800','Camamu','0',0,1,5),(552,'\0','2913457','Igrapiúna','0',0,1,5),(553,'\0','2917300','Ituberá','0',0,1,5),(554,'\0','2920700','Maraú','0',0,1,5),(555,'\0','2922607','Nilo Peçanha','0',0,1,5),(556,'\0','2924678','Piraí do Norte','0',0,1,5),(557,'\0','2925758','Presidente Tancredo Neves','0',0,1,5),(558,'\0','2931202','Taperoá','0',0,1,5),(559,'\0','2932903','Valença','0',0,1,5),(560,'\0','2900900','Almadina','0',0,1,5),(561,'\0','2902252','Arataca','0',0,1,5),(562,'\0','2902401','Aurelino Leal','0',0,1,5),(563,'\0','2903102','Barra do Rocha','0',0,1,5),(564,'\0','2903300','Barro Preto','0',0,1,5),(565,'\0','2903409','Belmonte','0',0,1,5),(566,'\0','2904704','Buerarema','0',0,1,5),(567,'\0','2905602','Camacan','0',0,1,5),(568,'\0','2906303','Canavieiras','0',0,1,5),(569,'\0','2908002','Coaraci','0',0,1,5),(570,'\0','2910909','Firmino Alves','0',0,1,5),(571,'\0','2911006','Floresta Azul','0',0,1,5),(572,'\0','2911204','Gandu','0',0,1,5),(573,'\0','2911501','Gongogi','0',0,1,5),(574,'\0','2912103','Ibicaraí','0',0,1,5),(575,'\0','2912707','Ibirapitanga','0',0,1,5),(576,'\0','2912905','Ibirataia','0',0,1,5),(577,'\0','2913606','Ilhéus','0',0,1,5),(578,'\0','2913903','Ipiaú','0',0,1,5),(579,'\0','2914802','Itabuna','0',0,1,5),(580,'\0','2914901','Itacaré','0',0,1,5),(581,'\0','2915205','Itagibá','0',0,1,5),(582,'\0','2915403','Itaju do Colônia','0',0,1,5),(583,'\0','2915502','Itajuípe','0',0,1,5),(584,'\0','2915700','Itamari','0',0,1,5),(585,'\0','2916203','Itapé','0',0,1,5),(586,'\0','2916302','Itapebi','0',0,1,5),(587,'\0','2916609','Itapitanga','0',0,1,5),(588,'\0','2918555','Jussari','0',0,1,5),(589,'\0','2920908','Mascote','0',0,1,5),(590,'\0','2922755','Nova Ibiá','0',0,1,5),(591,'\0','2923902','Pau Brasil','0',0,1,5),(592,'\0','2927804','Santa Cruz da Vitória','0',0,1,5),(593,'\0','2928059','Santa Luzia','0',0,1,5),(594,'\0','2929354','São José da Vitória','0',0,1,5),(595,'\0','2931608','Teolândia','0',0,1,5),(596,'\0','2932200','Ubaitaba','0',0,1,5),(597,'\0','2932309','Ubatã','0',0,1,5),(598,'\0','2932507','Una','0',0,1,5),(599,'\0','2932705','Uruçuca','0',0,1,5),(600,'\0','2933505','Wenceslau Guimarães','0',0,1,5),(601,'\0','2900801','Alcobaça','0',0,1,5),(602,'\0','2906907','Caravelas','0',0,1,5),(603,'\0','2910727','Eunápolis','0',0,1,5),(604,'\0','2911808','Guaratinga','0',0,1,5),(605,'\0','2912806','Ibirapuã','0',0,1,5),(606,'\0','2914653','Itabela','0',0,1,5),(607,'\0','2915304','Itagimirim','0',0,1,5),(608,'\0','2915601','Itamaraju','0',0,1,5),(609,'\0','2916005','Itanhém','0',0,1,5),(610,'\0','2918456','Jucuruçu','0',0,1,5),(611,'\0','2918902','Lajedão','0',0,1,5),(612,'\0','2921104','Medeiros Neto','0',0,1,5),(613,'\0','2922003','Mucuri','0',0,1,5),(614,'\0','2923001','Nova Viçosa','0',0,1,5),(615,'\0','2925303','Porto Seguro','0',0,1,5),(616,'\0','2925501','Prado','0',0,1,5),(617,'\0','2927705','Santa Cruz Cabrália','0',0,1,5),(618,'\0','2931350','Teixeira de Freitas','0',0,1,5),(619,'\0','2933257','Vereda','0',0,1,5),(620,'\0','2300200','Acaraú','0',0,1,6),(621,'\0','2302057','Barroquinha','0',0,1,6),(622,'\0','2302305','Bela Cruz','0',0,1,6),(623,'\0','2302602','Camocim','0',0,1,6),(624,'\0','2303907','Chaval','0',0,1,6),(625,'\0','2304251','Cruz','0',0,1,6),(626,'\0','2304707','Granja','0',0,1,6),(627,'\0','2306553','Itarema','0',0,1,6),(628,'\0','2307254','Jijoca de Jericoacoara','0',0,1,6),(629,'\0','2307809','Marco','0',0,1,6),(630,'\0','2307908','Martinópole','0',0,1,6),(631,'\0','2308906','Morrinhos','0',0,1,6),(632,'\0','2303402','Carnaubal','0',0,1,6),(633,'\0','2304236','Croatá','0',0,1,6),(634,'\0','2305001','Guaraciaba do Norte','0',0,1,6),(635,'\0','2305308','Ibiapina','0',0,1,6),(636,'\0','2312304','São Benedito','0',0,1,6),(637,'\0','2313401','Tianguá','0',0,1,6),(638,'\0','2313609','Ubajara','0',0,1,6),(639,'\0','2314102','Viçosa do Ceará','0',0,1,6),(640,'\0','2304004','Coreaú','0',0,1,6),(641,'\0','2304509','Frecheirinha','0',0,1,6),(642,'\0','2308807','Moraújo','0',0,1,6),(643,'\0','2313906','Uruoca','0',0,1,6),(644,'\0','2300507','Alcântaras','0',0,1,6),(645,'\0','2308203','Meruoca','0',0,1,6),(646,'\0','2303105','Cariré','0',0,1,6),(647,'\0','2304350','Forquilha','0',0,1,6),(648,'\0','2304657','Graça','0',0,1,6),(649,'\0','2304905','Groaíras','0',0,1,6),(650,'\0','2306108','Irauçuba','0',0,1,6),(651,'\0','2308005','Massapê','0',0,1,6),(652,'\0','2308377','Miraíma','0',0,1,6),(653,'\0','2309003','Mucambo','0',0,1,6),(654,'\0','2309904','Pacujá','0',0,1,6),(655,'\0','2312007','Santana do Acaraú','0',0,1,6),(656,'\0','2312809','Senador Sá','0',0,1,6),(657,'\0','2312908','Sobral','0',0,1,6),(658,'\0','2305803','Ipu','0',0,1,6),(659,'\0','2305902','Ipueiras','0',0,1,6),(660,'\0','2310951','Pires Ferreira','0',0,1,6),(661,'\0','2311009','Poranga','0',0,1,6),(662,'\0','2311702','Reriutaba','0',0,1,6),(663,'\0','2313955','Varjota','0',0,1,6),(664,'\0','2303659','Catunda','0',0,1,6),(665,'\0','2305209','Hidrolândia','0',0,1,6),(666,'\0','2312205','Santa Quitéria','0',0,1,6),(667,'\0','2300754','Amontada','0',0,1,6),(668,'\0','2306405','Itapipoca','0',0,1,6),(669,'\0','2313500','Trairi','0',0,1,6),(670,'\0','2310209','Paracuru','0',0,1,6),(671,'\0','2310258','Paraipaba','0',0,1,6),(672,'\0','2312403','São Gonçalo do Amarante','0',0,1,6),(673,'\0','2306306','Itapagé','0',0,1,6),(674,'\0','2313559','Tururu','0',0,1,6),(675,'\0','2313757','Umirim','0',0,1,6),(676,'\0','2313807','Uruburetama','0',0,1,6),(677,'\0','2300903','Apuiarés','0',0,1,6),(678,'\0','2304608','General Sampaio','0',0,1,6),(679,'\0','2310704','Pentecoste','0',0,1,6),(680,'\0','2312601','São Luís do Curu','0',0,1,6),(681,'\0','2313351','Tejuçuoca','0',0,1,6),(682,'\0','2302800','Canindé','0',0,1,6),(683,'\0','2303006','Caridade','0',0,1,6),(684,'\0','2306603','Itatira','0',0,1,6),(685,'\0','2310407','Paramoti','0',0,1,6),(686,'\0','2300150','Acarape','0',0,1,6),(687,'\0','2301208','Aracoiaba','0',0,1,6),(688,'\0','2301406','Aratuba','0',0,1,6),(689,'\0','2302107','Baturité','0',0,1,6),(690,'\0','2302909','Capistrano','0',0,1,6),(691,'\0','2305100','Guaramiranga','0',0,1,6),(692,'\0','2306504','Itapiúna','0',0,1,6),(693,'\0','2309102','Mulungu','0',0,1,6),(694,'\0','2309805','Pacoti','0',0,1,6),(695,'\0','2310100','Palmácia','0',0,1,6),(696,'\0','2311603','Redenção','0',0,1,6),(697,'\0','2301950','Barreira','0',0,1,6),(698,'\0','2303956','Chorozinho','0',0,1,6),(699,'\0','2309458','Ocara','0',0,1,6),(700,'\0','2302206','Beberibe','0',0,1,6),(701,'\0','2303501','Cascavel','0',0,1,6),(702,'\0','2310852','Pindoretama','0',0,1,6),(703,'\0','2301000','Aquiraz','0',0,1,6),(704,'\0','2303709','Caucaia','0',0,1,6),(705,'\0','2304285','Eusébio','0',0,1,6),(706,'\0','2304400','Fortaleza','0',0,1,6),(707,'\0','2304954','Guaiúba','0',0,1,6),(708,'\0','2306256','Itaitinga','0',0,1,6),(709,'\0','2307650','Maracanaú','0',0,1,6),(710,'\0','2307700','Maranguape','0',0,1,6),(711,'\0','2309706','Pacatuba','0',0,1,6),(712,'\0','2305233','Horizonte','0',0,1,6),(713,'\0','2309607','Pacajus','0',0,1,6),(714,'\0','2301257','Ararendá','0',0,1,6),(715,'\0','2304103','Crateús','0',0,1,6),(716,'\0','2305605','Independência','0',0,1,6),(717,'\0','2305654','Ipaporanga','0',0,1,6),(718,'\0','2308609','Monsenhor Tabosa','0',0,1,6),(719,'\0','2309300','Nova Russas','0',0,1,6),(720,'\0','2309409','Novo Oriente','0',0,1,6),(721,'\0','2311264','Quiterianópolis','0',0,1,6),(722,'\0','2313203','Tamboril','0',0,1,6),(723,'\0','2301851','Banabuiú','0',0,1,6),(724,'\0','2302404','Boa Viagem','0',0,1,6),(725,'\0','2303931','Choró','0',0,1,6),(726,'\0','2305266','Ibaretama','0',0,1,6),(727,'\0','2307635','Madalena','0',0,1,6),(728,'\0','2311306','Quixadá','0',0,1,6),(729,'\0','2311405','Quixeramobim','0',0,1,6),(730,'\0','2300408','Aiuaba','0',0,1,6),(731,'\0','2301505','Arneiroz','0',0,1,6),(732,'\0','2303600','Catarina','0',0,1,6),(733,'\0','2310308','Parambu','0',0,1,6),(734,'\0','2311900','Saboeiro','0',0,1,6),(735,'\0','2313302','Tauá','0',0,1,6),(736,'\0','2300309','Acopiara','0',0,1,6),(737,'\0','2304269','Deputado Irapuan Pinheiro','0',0,1,6),(738,'\0','2308351','Milhã','0',0,1,6),(739,'\0','2308500','Mombaça','0',0,1,6),(740,'\0','2310506','Pedra Branca','0',0,1,6),(741,'\0','2310902','Piquet Carneiro','0',0,1,6),(742,'\0','2312700','Senador Pompeu','0',0,1,6),(743,'\0','2313005','Solonópole','0',0,1,6),(744,'\0','2301109','Aracati','0',0,1,6),(745,'\0','2304459','Fortim','0',0,1,6),(746,'\0','2305357','Icapuí','0',0,1,6),(747,'\0','2306207','Itaiçaba','0',0,1,6),(748,'\0','2300705','Alto Santo','0',0,1,6),(749,'\0','2305332','Ibicuitinga','0',0,1,6),(750,'\0','2307007','Jaguaruana','0',0,1,6),(751,'\0','2307601','Limoeiro do Norte','0',0,1,6),(752,'\0','2308708','Morada Nova','0',0,1,6),(753,'\0','2310001','Palhano','0',0,1,6),(754,'\0','2311504','Quixeré','0',0,1,6),(755,'\0','2311801','Russas','0',0,1,6),(756,'\0','2312502','São João do Jaguaribe','0',0,1,6),(757,'\0','2313104','Tabuleiro do Norte','0',0,1,6),(758,'\0','2306702','Jaguaretama','0',0,1,6),(759,'\0','2306801','Jaguaribara','0',0,1,6),(760,'\0','2306900','Jaguaribe','0',0,1,6),(761,'\0','2304277','Ererê','0',0,1,6),(762,'\0','2306009','Iracema','0',0,1,6),(763,'\0','2310803','Pereiro','0',0,1,6),(764,'\0','2311231','Potiretama','0',0,1,6),(765,'\0','2303808','Cedro','0',0,1,6),(766,'\0','2305407','Icó','0',0,1,6),(767,'\0','2305506','Iguatu','0',0,1,6),(768,'\0','2309508','Orós','0',0,1,6),(769,'\0','2311355','Quixelô','0',0,1,6),(770,'\0','2300804','Antonina do Norte','0',0,1,6),(771,'\0','2303303','Cariús','0',0,1,6),(772,'\0','2307403','Jucás','0',0,1,6),(773,'\0','2313252','Tarrafas','0',0,1,6),(774,'\0','2314003','Várzea Alegre','0',0,1,6),(775,'\0','2301802','Baixio','0',0,1,6),(776,'\0','2305704','Ipaumirim','0',0,1,6),(777,'\0','2307502','Lavras da Mangabeira','0',0,1,6),(778,'\0','2313708','Umari','0',0,1,6),(779,'\0','2301307','Araripe','0',0,1,6),(780,'\0','2301604','Assaré','0',0,1,6),(781,'\0','2302701','Campos Sales','0',0,1,6),(782,'\0','2311207','Potengi','0',0,1,6),(783,'\0','2311959','Salitre','0',0,1,6),(784,'\0','2300606','Altaneira','0',0,1,6),(785,'\0','2303204','Caririaçu','0',0,1,6),(786,'\0','2304301','Farias Brito','0',0,1,6),(787,'\0','2304806','Granjeiro','0',0,1,6),(788,'\0','2301703','Aurora','0',0,1,6),(789,'\0','2302008','Barro','0',0,1,6),(790,'\0','2308104','Mauriti','0',0,1,6),(791,'\0','2301901','Barbalha','0',0,1,6),(792,'\0','2304202','Crato','0',0,1,6),(793,'\0','2307106','Jardim','0',0,1,6),(794,'\0','2307304','Juazeiro do Norte','0',0,1,6),(795,'\0','2308401','Missão Velha','0',0,1,6),(796,'\0','2309201','Nova Olinda','0',0,1,6),(797,'\0','2311108','Porteiras','0',0,1,6),(798,'\0','2312106','Santana do Cariri','0',0,1,6),(799,'\0','2300101','Abaiara','0',0,1,6),(800,'\0','2302503','Brejo Santo','0',0,1,6),(801,'\0','2307205','Jati','0',0,1,6),(802,'\0','2308302','Milagres','0',0,1,6),(803,'\0','2310605','Penaforte','0',0,1,6),(804,'\0','5300108','Brasília','0',0,1,7),(805,'\0','3200169','Água Doce do Norte','0',0,1,8),(806,'\0','3200904','Barra de São Francisco','0',0,1,8),(807,'\0','3202108','Ecoporanga','0',0,1,8),(808,'\0','3203304','Mantenópolis','0',0,1,8),(809,'\0','3200136','Águia Branca','0',0,1,8),(810,'\0','3201001','Boa Esperança','0',0,1,8),(811,'\0','3203908','Nova Venécia','0',0,1,8),(812,'\0','3204708','São Gabriel da Palha','0',0,1,8),(813,'\0','3205150','Vila Pavão','0',0,1,8),(814,'\0','3205176','Vila Valério','0',0,1,8),(815,'\0','3200359','Alto Rio Novo','0',0,1,8),(816,'\0','3200805','Baixo Guandu','0',0,1,8),(817,'\0','3201506','Colatina','0',0,1,8),(818,'\0','3202256','Governador Lindenberg','0',0,1,8),(819,'\0','3203353','Marilândia','0',0,1,8),(820,'\0','3204005','Pancas','0',0,1,8),(821,'\0','3204658','São Domingos do Norte','0',0,1,8),(822,'\0','3203502','Montanha','0',0,1,8),(823,'\0','3203601','Mucurici','0',0,1,8),(824,'\0','3204104','Pinheiros','0',0,1,8),(825,'\0','3204252','Ponto Belo','0',0,1,8),(826,'\0','3201605','Conceição da Barra','0',0,1,8),(827,'\0','3203056','Jaguaré','0',0,1,8),(828,'\0','3204054','Pedro Canário','0',0,1,8),(829,'\0','3204906','São Mateus','0',0,1,8),(830,'\0','3200607','Aracruz','0',0,1,8),(831,'\0','3202207','Fundão','0',0,1,8),(832,'\0','3202504','Ibiraçu','0',0,1,8),(833,'\0','3203130','João Neiva','0',0,1,8),(834,'\0','3203205','Linhares','0',0,1,8),(835,'\0','3204351','Rio Bananal','0',0,1,8),(836,'\0','3205010','Sooretama','0',0,1,8),(837,'\0','3200102','Afonso Cláudio','0',0,1,8),(838,'\0','3201159','Brejetuba','0',0,1,8),(839,'\0','3201704','Conceição do Castelo','0',0,1,8),(840,'\0','3201902','Domingos Martins','0',0,1,8),(841,'\0','3203163','Laranja da Terra','0',0,1,8),(842,'\0','3203346','Marechal Floriano','0',0,1,8),(843,'\0','3205069','Venda Nova do Imigrante','0',0,1,8),(844,'\0','3202702','Itaguaçu','0',0,1,8),(845,'\0','3202900','Itarana','0',0,1,8),(846,'\0','3204500','Santa Leopoldina','0',0,1,8),(847,'\0','3204559','Santa Maria de Jetibá','0',0,1,8),(848,'\0','3204609','Santa Teresa','0',0,1,8),(849,'\0','3204955','São Roque do Canaã','0',0,1,8),(850,'\0','3201308','Cariacica','0',0,1,8),(851,'\0','3205002','Serra','0',0,1,8),(852,'\0','3205101','Viana','0',0,1,8),(853,'\0','3205200','Vila Velha','0',0,1,8),(854,'\0','3205309','Vitória','0',0,1,8),(855,'\0','3200300','Alfredo Chaves','0',0,1,8),(856,'\0','3200409','Anchieta','0',0,1,8),(857,'\0','3202405','Guarapari','0',0,1,8),(858,'\0','3202603','Iconha','0',0,1,8),(859,'\0','3204203','Piúma','0',0,1,8),(860,'\0','3204401','Rio Novo do Sul','0',0,1,8),(861,'\0','3200201','Alegre','0',0,1,8),(862,'\0','3201803','Divino de São Lourenço','0',0,1,8),(863,'\0','3202009','Dores do Rio Preto','0',0,1,8),(864,'\0','3202306','Guaçuí','0',0,1,8),(865,'\0','3202454','Ibatiba','0',0,1,8),(866,'\0','3202553','Ibitirama','0',0,1,8),(867,'\0','3202652','Irupi','0',0,1,8),(868,'\0','3203007','Iúna','0',0,1,8),(869,'\0','3203700','Muniz Freire','0',0,1,8),(870,'\0','3200508','Apiacá','0',0,1,8),(871,'\0','3200706','Atilio Vivacqua','0',0,1,8),(872,'\0','3201100','Bom Jesus do Norte','0',0,1,8),(873,'\0','3201209','Cachoeiro de Itapemirim','0',0,1,8),(874,'\0','3201407','Castelo','0',0,1,8),(875,'\0','3203106','Jerônimo Monteiro','0',0,1,8),(876,'\0','3203403','Mimoso do Sul','0',0,1,8),(877,'\0','3203809','Muqui','0',0,1,8),(878,'\0','3204807','São José do Calçado','0',0,1,8),(879,'\0','3205036','Vargem Alta','0',0,1,8),(880,'\0','3202801','Itapemirim','0',0,1,8),(881,'\0','3203320','Marataízes','0',0,1,8),(882,'\0','3204302','Presidente Kennedy','0',0,1,8),(883,'\0','5206404','Crixás','0',0,1,9),(884,'\0','5214002','Mozarlândia','0',0,1,9),(885,'\0','5214051','Mundo Novo','0',0,1,9),(886,'\0','5214838','Nova Crixás','0',0,1,9),(887,'\0','5215256','Novo Planalto','0',0,1,9),(888,'\0','5220207','São Miguel do Araguaia','0',0,1,9),(889,'\0','5221577','Uirapuru','0',0,1,9),(890,'\0','5202155','Araguapaz','0',0,1,9),(891,'\0','5202502','Aruanã','0',0,1,9),(892,'\0','5203807','Britânia','0',0,1,9),(893,'\0','5207535','Faina','0',0,1,9),(894,'\0','5208905','Goiás','0',0,1,9),(895,'\0','5211008','Itapirapuã','0',0,1,9),(896,'\0','5212204','Jussara','0',0,1,9),(897,'\0','5212956','Matrinchã','0',0,1,9),(898,'\0','5219258','Santa Fé de Goiás','0',0,1,9),(899,'\0','5201702','Aragarças','0',0,1,9),(900,'\0','5202353','Arenópolis','0',0,1,9),(901,'\0','5203104','Baliza','0',0,1,9),(902,'\0','5203401','Bom Jardim de Goiás','0',0,1,9),(903,'\0','5207105','Diorama','0',0,1,9),(904,'\0','5213707','Montes Claros de Goiás','0',0,1,9),(905,'\0','5217203','Piranhas','0',0,1,9),(906,'\0','5200555','Alto Horizonte','0',0,1,9),(907,'\0','5200829','Amaralina','0',0,1,9),(908,'\0','5203575','Bonópolis','0',0,1,9),(909,'\0','5204656','Campinaçu','0',0,1,9),(910,'\0','5204706','Campinorte','0',0,1,9),(911,'\0','5204953','Campos Verdes','0',0,1,9),(912,'\0','5207501','Estrela do Norte','0',0,1,9),(913,'\0','5208103','Formoso','0',0,1,9),(914,'\0','5212808','Mara Rosa','0',0,1,9),(915,'\0','5213087','Minaçu','0',0,1,9),(916,'\0','5213772','Montividiu do Norte','0',0,1,9),(917,'\0','5214101','Mutunópolis','0',0,1,9),(918,'\0','5214606','Niquelândia','0',0,1,9),(919,'\0','5214879','Nova Iguaçu de Goiás','0',0,1,9),(920,'\0','5218003','Porangatu','0',0,1,9),(921,'\0','5219605','Santa Tereza de Goiás','0',0,1,9),(922,'\0','5219704','Santa Terezinha de Goiás','0',0,1,9),(923,'\0','5221452','Trombas','0',0,1,9),(924,'\0','5221601','Uruaçu','0',0,1,9),(925,'\0','5200605','Alto Paraíso de Goiás','0',0,1,9),(926,'\0','5204904','Campos Belos','0',0,1,9),(927,'\0','5205307','Cavalcante','0',0,1,9),(928,'\0','5205521','Colinas do Sul','0',0,1,9),(929,'\0','5213509','Monte Alegre de Goiás','0',0,1,9),(930,'\0','5214903','Nova Roma','0',0,1,9),(931,'\0','5220009','São João d\'Aliança','0',0,1,9),(932,'\0','5221080','Teresina de Goiás','0',0,1,9),(933,'\0','5203203','Barro Alto','0',0,1,9),(934,'\0','5205000','Carmo do Rio Verde','0',0,1,9),(935,'\0','5205406','Ceres','0',0,1,9),(936,'\0','5208608','Goianésia','0',0,1,9),(937,'\0','5209291','Guaraíta','0',0,1,9),(938,'\0','5209457','Guarinos','0',0,1,9),(939,'\0','5209804','Hidrolina','0',0,1,9),(940,'\0','5210158','Ipiranga de Goiás','0',0,1,9),(941,'\0','5210901','Itapaci','0',0,1,9),(942,'\0','5211206','Itapuranga','0',0,1,9),(943,'\0','5213855','Morro Agudo de Goiás','0',0,1,9),(944,'\0','5214705','Nova América','0',0,1,9),(945,'\0','5214861','Nova Glória','0',0,1,9),(946,'\0','5216908','Pilar de Goiás','0',0,1,9),(947,'\0','5218607','Rialma','0',0,1,9),(948,'\0','5218706','Rianápolis','0',0,1,9),(949,'\0','5218904','Rubiataba','0',0,1,9),(950,'\0','5219357','Santa Isabel','0',0,1,9),(951,'\0','5219456','Santa Rita do Novo Destino','0',0,1,9),(952,'\0','5220157','São Luíz do Norte','0',0,1,9),(953,'\0','5220280','São Patrício','0',0,1,9),(954,'\0','5221700','Uruana','0',0,1,9),(955,'\0','5201108','Anápolis','0',0,1,9),(956,'\0','5201603','Araçu','0',0,1,9),(957,'\0','5203609','Brazabrantes','0',0,1,9),(958,'\0','5204854','Campo Limpo de Goiás','0',0,1,9),(959,'\0','5205208','Caturaí','0',0,1,9),(960,'\0','5206800','Damolândia','0',0,1,9),(961,'\0','5209606','Heitoraí','0',0,1,9),(962,'\0','5210000','Inhumas','0',0,1,9),(963,'\0','5210406','Itaberaí','0',0,1,9),(964,'\0','5210562','Itaguari','0',0,1,9),(965,'\0','5210604','Itaguaru','0',0,1,9),(966,'\0','5211404','Itauçu','0',0,1,9),(967,'\0','5211800','Jaraguá','0',0,1,9),(968,'\0','5212055','Jesúpolis','0',0,1,9),(969,'\0','5215009','Nova Veneza','0',0,1,9),(970,'\0','5215405','Ouro Verde de Goiás','0',0,1,9),(971,'\0','5216809','Petrolina de Goiás','0',0,1,9),(972,'\0','5219506','Santa Rosa de Goiás','0',0,1,9),(973,'\0','5219902','São Francisco de Goiás','0',0,1,9),(974,'\0','5221007','Taquaral de Goiás','0',0,1,9),(975,'\0','5200902','Amorinópolis','0',0,1,9),(976,'\0','5204201','Cachoeira de Goiás','0',0,1,9),(977,'\0','5205703','Córrego do Ouro','0',0,1,9),(978,'\0','5207600','Fazenda Nova','0',0,1,9),(979,'\0','5210208','Iporá','0',0,1,9),(980,'\0','5210307','Israelândia','0',0,1,9),(981,'\0','5211602','Ivolândia','0',0,1,9),(982,'\0','5212006','Jaupaci','0',0,1,9),(983,'\0','5213400','Moiporá','0',0,1,9),(984,'\0','5215207','Novo Brasil','0',0,1,9),(985,'\0','5200159','Adelândia','0',0,1,9),(986,'\0','5200852','Americano do Brasil','0',0,1,9),(987,'\0','5201306','Anicuns','0',0,1,9),(988,'\0','5202601','Aurilândia','0',0,1,9),(989,'\0','5202809','Avelinópolis','0',0,1,9),(990,'\0','5203939','Buriti de Goiás','0',0,1,9),(991,'\0','5207808','Firminópolis','0',0,1,9),(992,'\0','5213905','Mossâmedes','0',0,1,9),(993,'\0','5214408','Nazário','0',0,1,9),(994,'\0','5219001','Sanclerlândia','0',0,1,9),(995,'\0','5219100','Santa Bárbara de Goiás','0',0,1,9),(996,'\0','5220108','São Luís de Montes Belos','0',0,1,9),(997,'\0','5221502','Turvânia','0',0,1,9),(998,'\0','5200050','Abadia de Goiás','0',0,1,9),(999,'\0','5201405','Aparecida de Goiânia','0',0,1,9),(1000,'\0','5201801','Aragoiânia','0',0,1,9),(1001,'\0','5203302','Bela Vista de Goiás','0',0,1,9),(1002,'\0','5203559','Bonfinópolis','0',0,1,9),(1003,'\0','5204557','Caldazinha','0',0,1,9),(1004,'\0','5208400','Goianápolis','0',0,1,9),(1005,'\0','5208707','Goiânia','0',0,1,9),(1006,'\0','5208806','Goianira','0',0,1,9),(1007,'\0','5209200','Guapó','0',0,1,9),(1008,'\0','5209705','Hidrolândia','0',0,1,9),(1009,'\0','5212303','Leopoldo de Bulhões','0',0,1,9),(1010,'\0','5214507','Nerópolis','0',0,1,9),(1011,'\0','5219738','Santo Antônio de Goiás','0',0,1,9),(1012,'\0','5220454','Senador Canedo','0',0,1,9),(1013,'\0','5221197','Terezópolis de Goiás','0',0,1,9),(1014,'\0','5221403','Trindade','0',0,1,9),(1015,'\0','5200803','Alvorada do Norte','0',0,1,9),(1016,'\0','5203962','Buritinópolis','0',0,1,9),(1017,'\0','5206701','Damianópolis','0',0,1,9),(1018,'\0','5207907','Flores de Goiás','0',0,1,9),(1019,'\0','5208301','Divinópolis de Goiás','0',0,1,9),(1020,'\0','5209408','Guarani de Goiás','0',0,1,9),(1021,'\0','5209903','Iaciara','0',0,1,9),(1022,'\0','5212709','Mambaí','0',0,1,9),(1023,'\0','5218300','Posse','0',0,1,9),(1024,'\0','5219803','São Domingos','0',0,1,9),(1025,'\0','5220686','Simolândia','0',0,1,9),(1026,'\0','5220702','Sítio d\'Abadia','0',0,1,9),(1027,'\0','5200100','Abadiânia','0',0,1,9),(1028,'\0','5200175','Água Fria de Goiás','0',0,1,9),(1029,'\0','5200258','Águas Lindas de Goiás','0',0,1,9),(1030,'\0','5200308','Alexânia','0',0,1,9),(1031,'\0','5204003','Cabeceiras','0',0,1,9),(1032,'\0','5205497','Cidade Ocidental','0',0,1,9),(1033,'\0','5205513','Cocalzinho de Goiás','0',0,1,9),(1034,'\0','5205802','Corumbá de Goiás','0',0,1,9),(1035,'\0','5206206','Cristalina','0',0,1,9),(1036,'\0','5208004','Formosa','0',0,1,9),(1037,'\0','5212501','Luziânia','0',0,1,9),(1038,'\0','5213053','Mimoso de Goiás','0',0,1,9),(1039,'\0','5215231','Novo Gama','0',0,1,9),(1040,'\0','5215603','Padre Bernardo','0',0,1,9),(1041,'\0','5217302','Pirenópolis','0',0,1,9),(1042,'\0','5217609','Planaltina','0',0,1,9),(1043,'\0','5219753','Santo Antônio do Descoberto','0',0,1,9),(1044,'\0','5221858','Valparaíso de Goiás','0',0,1,9),(1045,'\0','5222203','Vila Boa','0',0,1,9),(1046,'\0','5222302','Vila Propício','0',0,1,9),(1047,'\0','5201454','Aparecida do Rio Doce','0',0,1,9),(1048,'\0','5201504','Aporé','0',0,1,9),(1049,'\0','5204409','Caiapônia','0',0,1,9),(1050,'\0','5205059','Castelândia','0',0,1,9),(1051,'\0','5205471','Chapadão do Céu','0',0,1,9),(1052,'\0','5207253','Doverlândia','0',0,1,9),(1053,'\0','5211909','Jataí','0',0,1,9),(1054,'\0','5213004','Maurilândia','0',0,1,9),(1055,'\0','5213103','Mineiros','0',0,1,9),(1056,'\0','5213756','Montividiu','0',0,1,9),(1057,'\0','5215652','Palestina de Goiás','0',0,1,9),(1058,'\0','5216452','Perolândia','0',0,1,9),(1059,'\0','5218102','Portelândia','0',0,1,9),(1060,'\0','5218805','Rio Verde','0',0,1,9),(1061,'\0','5219308','Santa Helena de Goiás','0',0,1,9),(1062,'\0','5219407','Santa Rita do Araguaia','0',0,1,9),(1063,'\0','5219712','Santo Antônio da Barra','0',0,1,9),(1064,'\0','5220504','Serranópolis','0',0,1,9),(1065,'\0','5200134','Acreúna','0',0,1,9),(1066,'\0','5204607','Campestre de Goiás','0',0,1,9),(1067,'\0','5205455','Cezarina','0',0,1,9),(1068,'\0','5207352','Edealina','0',0,1,9),(1069,'\0','5207402','Edéia','0',0,1,9),(1070,'\0','5209952','Indiara','0',0,1,9),(1071,'\0','5211701','Jandaia','0',0,1,9),(1072,'\0','5215702','Palmeiras de Goiás','0',0,1,9),(1073,'\0','5215900','Palminópolis','0',0,1,9),(1074,'\0','5216403','Paraúna','0',0,1,9),(1075,'\0','5220058','São João da Paraúna','0',0,1,9),(1076,'\0','5221551','Turvelândia','0',0,1,9),(1077,'\0','5221908','Varjão','0',0,1,9),(1078,'\0','5200209','Água Limpa','0',0,1,9),(1079,'\0','5200506','Aloândia','0',0,1,9),(1080,'\0','5203500','Bom Jesus de Goiás','0',0,1,9),(1081,'\0','5203906','Buriti Alegre','0',0,1,9),(1082,'\0','5204250','Cachoeira Dourada','0',0,1,9),(1083,'\0','5204508','Caldas Novas','0',0,1,9),(1084,'\0','5206503','Cromínia','0',0,1,9),(1085,'\0','5209101','Goiatuba','0',0,1,9),(1086,'\0','5209937','Inaciolândia','0',0,1,9),(1087,'\0','5211503','Itumbiara','0',0,1,9),(1088,'\0','5212105','Joviânia','0',0,1,9),(1089,'\0','5212600','Mairipotaba','0',0,1,9),(1090,'\0','5212907','Marzagão','0',0,1,9),(1091,'\0','5213806','Morrinhos','0',0,1,9),(1092,'\0','5216007','Panamá','0',0,1,9),(1093,'\0','5217104','Piracanjuba','0',0,1,9),(1094,'\0','5217708','Pontalina','0',0,1,9),(1095,'\0','5218052','Porteirão','0',0,1,9),(1096,'\0','5218391','Professor Jamil','0',0,1,9),(1097,'\0','5218789','Rio Quente','0',0,1,9),(1098,'\0','5222054','Vicentinópolis','0',0,1,9),(1099,'\0','5206305','Cristianópolis','0',0,1,9),(1100,'\0','5208152','Gameleira de Goiás','0',0,1,9),(1101,'\0','5215306','Orizona','0',0,1,9),(1102,'\0','5215801','Palmelo','0',0,1,9),(1103,'\0','5217401','Pires do Rio','0',0,1,9),(1104,'\0','5219209','Santa Cruz de Goiás','0',0,1,9),(1105,'\0','5220264','São Miguel do Passa Quatro','0',0,1,9),(1106,'\0','5220603','Silvânia','0',0,1,9),(1107,'\0','5221809','Urutaí','0',0,1,9),(1108,'\0','5222005','Vianópolis','0',0,1,9),(1109,'\0','5201207','Anhanguera','0',0,1,9),(1110,'\0','5204805','Campo Alegre de Goiás','0',0,1,9),(1111,'\0','5205109','Catalão','0',0,1,9),(1112,'\0','5205901','Corumbaíba','0',0,1,9),(1113,'\0','5206602','Cumari','0',0,1,9),(1114,'\0','5206909','Davinópolis','0',0,1,9),(1115,'\0','5208509','Goiandira','0',0,1,9),(1116,'\0','5210109','Ipameri','0',0,1,9),(1117,'\0','5214804','Nova Aurora','0',0,1,9),(1118,'\0','5215504','Ouvidor','0',0,1,9),(1119,'\0','5221304','Três Ranchos','0',0,1,9),(1120,'\0','5204102','Cachoeira Alta','0',0,1,9),(1121,'\0','5204300','Caçu','0',0,1,9),(1122,'\0','5209150','Gouvelândia','0',0,1,9),(1123,'\0','5210802','Itajá','0',0,1,9),(1124,'\0','5211305','Itarumã','0',0,1,9),(1125,'\0','5212253','Lagoa Santa','0',0,1,9),(1126,'\0','5216304','Paranaiguara','0',0,1,9),(1127,'\0','5218508','Quirinópolis','0',0,1,9),(1128,'\0','5220405','São Simão','0',0,1,9),(1129,'\0','2100204','Alcântara','0',0,1,10),(1130,'\0','2100832','Apicum-Açu','0',0,1,10),(1131,'\0','2101301','Bacuri','0',0,1,10),(1132,'\0','2101350','Bacurituba','0',0,1,10),(1133,'\0','2101905','Bequimão','0',0,1,10),(1134,'\0','2102408','Cajapió','0',0,1,10),(1135,'\0','2103109','Cedral','0',0,1,10),(1136,'\0','2103125','Central do Maranhão','0',0,1,10),(1137,'\0','2103703','Cururupu','0',0,1,10),(1138,'\0','2104909','Guimarães','0',0,1,10),(1139,'\0','2106805','Mirinzal','0',0,1,10),(1140,'\0','2109056','Porto Rico do Maranhão','0',0,1,10),(1141,'\0','2111789','Serrano do Maranhão','0',0,1,10),(1142,'\0','2107506','Paço do Lumiar','0',0,1,10),(1143,'\0','2109452','Raposa','0',0,1,10),(1144,'\0','2111201','São José de Ribamar','0',0,1,10),(1145,'\0','2111300','São Luís','0',0,1,10),(1146,'\0','2101103','Axixá','0',0,1,10),(1147,'\0','2101251','Bacabeira','0',0,1,10),(1148,'\0','2102374','Cachoeira Grande','0',0,1,10),(1149,'\0','2105104','Icatu','0',0,1,10),(1150,'\0','2107100','Morros','0',0,1,10),(1151,'\0','2109205','Presidente Juscelino','0',0,1,10),(1152,'\0','2109601','Rosário','0',0,1,10),(1153,'\0','2110203','Santa Rita','0',0,1,10),(1154,'\0','2101707','Barreirinhas','0',0,1,10),(1155,'\0','2105005','Humberto de Campos','0',0,1,10),(1156,'\0','2108058','Paulino Neves','0',0,1,10),(1157,'\0','2109403','Primeira Cruz','0',0,1,10),(1158,'\0','2110278','Santo Amaro do Maranhão','0',0,1,10),(1159,'\0','2112506','Tutóia','0',0,1,10),(1160,'\0','2100709','Anajatuba','0',0,1,10),(1161,'\0','2101004','Arari','0',0,1,10),(1162,'\0','2101772','Bela Vista do Maranhão','0',0,1,10),(1163,'\0','2102507','Cajari','0',0,1,10),(1164,'\0','2103554','Conceição do Lago-Açu','0',0,1,10),(1165,'\0','2105153','Igarapé do Meio','0',0,1,10),(1166,'\0','2106508','Matinha','0',0,1,10),(1167,'\0','2106904','Monção','0',0,1,10),(1168,'\0','2107456','Olinda Nova do Maranhão','0',0,1,10),(1169,'\0','2107605','Palmeirândia','0',0,1,10),(1170,'\0','2108256','Pedro do Rosário','0',0,1,10),(1171,'\0','2108306','Penalva','0',0,1,10),(1172,'\0','2108405','Peri Mirim','0',0,1,10),(1173,'\0','2108603','Pinheiro','0',0,1,10),(1174,'\0','2109270','Presidente Sarney','0',0,1,10),(1175,'\0','2109809','Santa Helena','0',0,1,10),(1176,'\0','2110500','São Bento','0',0,1,10),(1177,'\0','2111003','São João Batista','0',0,1,10),(1178,'\0','2111706','São Vicente Ferrer','0',0,1,10),(1179,'\0','2112803','Viana','0',0,1,10),(1180,'\0','2112902','Vitória do Mearim','0',0,1,10),(1181,'\0','2102705','Cantanhede','0',0,1,10),(1182,'\0','2105401','Itapecuru Mirim','0',0,1,10),(1183,'\0','2106631','Matões do Norte','0',0,1,10),(1184,'\0','2106755','Miranda do Norte','0',0,1,10),(1185,'\0','2107209','Nina Rodrigues','0',0,1,10),(1186,'\0','2108801','Pirapemas','0',0,1,10),(1187,'\0','2109304','Presidente Vargas','0',0,1,10),(1188,'\0','2112704','Vargem Grande','0',0,1,10),(1189,'\0','2100550','Amapá do Maranhão','0',0,1,10),(1190,'\0','2101970','Boa Vista do Gurupi','0',0,1,10),(1191,'\0','2102606','Cândido Mendes','0',0,1,10),(1192,'\0','2102903','Carutapera','0',0,1,10),(1193,'\0','2103158','Centro do Guilherme','0',0,1,10),(1194,'\0','2103174','Centro Novo do Maranhão','0',0,1,10),(1195,'\0','2104305','Godofredo Viana','0',0,1,10),(1196,'\0','2104677','Governador Nunes Freire','0',0,1,10),(1197,'\0','2105658','Junco do Maranhão','0',0,1,10),(1198,'\0','2106201','Luís Domingues','0',0,1,10),(1199,'\0','2106326','Maracaçumé','0',0,1,10),(1200,'\0','2106375','Maranhãozinho','0',0,1,10),(1201,'\0','2112407','Turiaçu','0',0,1,10),(1202,'\0','2112456','Turilândia','0',0,1,10),(1203,'\0','2100402','Altamira do Maranhão','0',0,1,10),(1204,'\0','2100477','Alto Alegre do Pindaré','0',0,1,10),(1205,'\0','2100873','Araguanã','0',0,1,10),(1206,'\0','2102002','Bom Jardim','0',0,1,10),(1207,'\0','2102036','Bom Jesus das Selvas','0',0,1,10),(1208,'\0','2102150','Brejo de Areia','0',0,1,10),(1209,'\0','2102325','Buriticupu','0',0,1,10),(1210,'\0','2104651','Governador Newton Bello','0',0,1,10),(1211,'\0','2105708','Lago da Pedra','0',0,1,10),(1212,'\0','2105963','Lagoa Grande do Maranhão','0',0,1,10),(1213,'\0','2106359','Marajá do Sena','0',0,1,10),(1214,'\0','2107357','Nova Olinda do Maranhão','0',0,1,10),(1215,'\0','2108108','Paulo Ramos','0',0,1,10),(1216,'\0','2108504','Pindaré-Mirim','0',0,1,10),(1217,'\0','2109239','Presidente Médici','0',0,1,10),(1218,'\0','2109908','Santa Inês','0',0,1,10),(1219,'\0','2110005','Santa Luzia','0',0,1,10),(1220,'\0','2110039','Santa Luzia do Paruá','0',0,1,10),(1221,'\0','2111029','São João do Carú','0',0,1,10),(1222,'\0','2112274','Tufilândia','0',0,1,10),(1223,'\0','2113009','Vitorino Freire','0',0,1,10),(1224,'\0','2114007','Zé Doca','0',0,1,10),(1225,'\0','2100055','Açailândia','0',0,1,10),(1226,'\0','2100600','Amarante do Maranhão','0',0,1,10),(1227,'\0','2102358','Buritirana','0',0,1,10),(1228,'\0','2103257','Cidelândia','0',0,1,10),(1229,'\0','2103752','Davinópolis','0',0,1,10),(1230,'\0','2104552','Governador Edison Lobão','0',0,1,10),(1231,'\0','2105302','Imperatriz','0',0,1,10),(1232,'\0','2105427','Itinga do Maranhão','0',0,1,10),(1233,'\0','2105500','João Lisboa','0',0,1,10),(1234,'\0','2105989','Lajeado Novo','0',0,1,10),(1235,'\0','2107001','Montes Altos','0',0,1,10),(1236,'\0','2109551','Ribamar Fiquene','0',0,1,10),(1237,'\0','2110856','São Francisco do Brejão','0',0,1,10),(1238,'\0','2111532','São Pedro da Água Branca','0',0,1,10),(1239,'\0','2111763','Senador La Rocque','0',0,1,10),(1240,'\0','2112852','Vila Nova dos Martírios','0',0,1,10),(1241,'\0','2101202','Bacabal','0',0,1,10),(1242,'\0','2101939','Bernardo do Mearim','0',0,1,10),(1243,'\0','2102077','Bom Lugar','0',0,1,10),(1244,'\0','2104008','Esperantinópolis','0',0,1,10),(1245,'\0','2105203','Igarapé Grande','0',0,1,10),(1246,'\0','2105807','Lago do Junco','0',0,1,10),(1247,'\0','2105906','Lago Verde','0',0,1,10),(1248,'\0','2105948','Lago dos Rodrigues','0',0,1,10),(1249,'\0','2106003','Lima Campos','0',0,1,10),(1250,'\0','2107407','Olho d\'Água das Cunhãs','0',0,1,10),(1251,'\0','2108207','Pedreiras','0',0,1,10),(1252,'\0','2108702','Pio XII','0',0,1,10),(1253,'\0','2108900','Poção de Pedras','0',0,1,10),(1254,'\0','2110302','Santo Antônio dos Lopes','0',0,1,10),(1255,'\0','2111409','São Luís Gonzaga do Maranhão','0',0,1,10),(1256,'\0','2111508','São Mateus do Maranhão','0',0,1,10),(1257,'\0','2111631','São Raimundo do Doca Bezerra','0',0,1,10),(1258,'\0','2111672','São Roberto','0',0,1,10),(1259,'\0','2111722','Satubinha','0',0,1,10),(1260,'\0','2112233','Trizidela do Vale','0',0,1,10),(1261,'\0','2100956','Arame','0',0,1,10),(1262,'\0','2101608','Barra do Corda','0',0,1,10),(1263,'\0','2104081','Fernando Falcão','0',0,1,10),(1264,'\0','2104099','Formosa da Serra Negra','0',0,1,10),(1265,'\0','2104800','Grajaú','0',0,1,10),(1266,'\0','2105351','Itaipava do Grajaú','0',0,1,10),(1267,'\0','2105476','Jenipapo dos Vieiras','0',0,1,10),(1268,'\0','2105609','Joselândia','0',0,1,10),(1269,'\0','2109759','Santa Filomena do Maranhão','0',0,1,10),(1270,'\0','2111805','Sítio Novo','0',0,1,10),(1271,'\0','2112308','Tuntum','0',0,1,10),(1272,'\0','2103802','Dom Pedro','0',0,1,10),(1273,'\0','2104206','Fortuna','0',0,1,10),(1274,'\0','2104404','Gonçalves Dias','0',0,1,10),(1275,'\0','2104503','Governador Archer','0',0,1,10),(1276,'\0','2104602','Governador Eugênio Barros','0',0,1,10),(1277,'\0','2104628','Governador Luiz Rocha','0',0,1,10),(1278,'\0','2104701','Graça Aranha','0',0,1,10),(1279,'\0','2109106','Presidente Dutra','0',0,1,10),(1280,'\0','2110708','São Domingos do Maranhão','0',0,1,10),(1281,'\0','2111250','São José dos Basílios','0',0,1,10),(1282,'\0','2111748','Senador Alexandre Costa','0',0,1,10),(1283,'\0','2100154','Água Doce do Maranhão','0',0,1,10),(1284,'\0','2100907','Araioses','0',0,1,10),(1285,'\0','2106300','Magalhães de Almeida','0',0,1,10),(1286,'\0','2110104','Santa Quitéria do Maranhão','0',0,1,10),(1287,'\0','2110237','Santana do Maranhão','0',0,1,10),(1288,'\0','2110609','São Bernardo','0',0,1,10),(1289,'\0','2100808','Anapurus','0',0,1,10),(1290,'\0','2101731','Belágua','0',0,1,10),(1291,'\0','2102101','Brejo','0',0,1,10),(1292,'\0','2102200','Buriti','0',0,1,10),(1293,'\0','2103208','Chapadinha','0',0,1,10),(1294,'\0','2106409','Mata Roma','0',0,1,10),(1295,'\0','2106672','Milagres do Maranhão','0',0,1,10),(1296,'\0','2110401','São Benedito do Rio Preto','0',0,1,10),(1297,'\0','2112605','Urbano Santos','0',0,1,10),(1298,'\0','2100436','Alto Alegre do Maranhão','0',0,1,10),(1299,'\0','2102754','Capinzal do Norte','0',0,1,10),(1300,'\0','2103307','Codó','0',0,1,10),(1301,'\0','2103604','Coroatá','0',0,1,10),(1302,'\0','2108454','Peritoró','0',0,1,10),(1303,'\0','2112100','Timbiras','0',0,1,10),(1304,'\0','2100105','Afonso Cunha','0',0,1,10),(1305,'\0','2100303','Aldeias Altas','0',0,1,10),(1306,'\0','2103406','Coelho Neto','0',0,1,10),(1307,'\0','2103901','Duque Bacelar','0',0,1,10),(1308,'\0','2102309','Buriti Bravo','0',0,1,10),(1309,'\0','2103000','Caxias','0',0,1,10),(1310,'\0','2106607','Matões','0',0,1,10),(1311,'\0','2107803','Parnarama','0',0,1,10),(1312,'\0','2111078','São João do Soter','0',0,1,10),(1313,'\0','2112209','Timon','0',0,1,10),(1314,'\0','2101509','Barão de Grajaú','0',0,1,10),(1315,'\0','2103505','Colinas','0',0,1,10),(1316,'\0','2105450','Jatobá','0',0,1,10),(1317,'\0','2105922','Lagoa do Mato','0',0,1,10),(1318,'\0','2106706','Mirador','0',0,1,10),(1319,'\0','2107308','Nova Iorque','0',0,1,10),(1320,'\0','2107704','Paraibano','0',0,1,10),(1321,'\0','2107902','Passagem Franca','0',0,1,10),(1322,'\0','2108009','Pastos Bons','0',0,1,10),(1323,'\0','2110906','São Francisco do Maranhão','0',0,1,10),(1324,'\0','2111102','São João dos Patos','0',0,1,10),(1325,'\0','2111904','Sucupira do Norte','0',0,1,10),(1326,'\0','2111953','Sucupira do Riachão','0',0,1,10),(1327,'\0','2102556','Campestre do Maranhão','0',0,1,10),(1328,'\0','2102804','Carolina','0',0,1,10),(1329,'\0','2104057','Estreito','0',0,1,10),(1330,'\0','2109007','Porto Franco','0',0,1,10),(1331,'\0','2111052','São João do Paraíso','0',0,1,10),(1332,'\0','2111573','São Pedro dos Crentes','0',0,1,10),(1333,'\0','2100501','Alto Parnaíba','0',0,1,10),(1334,'\0','2101400','Balsas','0',0,1,10),(1335,'\0','2104073','Feira Nova do Maranhão','0',0,1,10),(1336,'\0','2109502','Riachão','0',0,1,10),(1337,'\0','2112001','Tasso Fragoso','0',0,1,10),(1338,'\0','2101806','Benedito Leite','0',0,1,10),(1339,'\0','2104107','Fortaleza dos Nogueiras','0',0,1,10),(1340,'\0','2106102','Loreto','0',0,1,10),(1341,'\0','2107258','Nova Colinas','0',0,1,10),(1342,'\0','2109700','Sambaíba','0',0,1,10),(1343,'\0','2110658','São Domingos do Azeitão','0',0,1,10),(1344,'\0','2110807','São Félix de Balsas','0',0,1,10),(1345,'\0','2111607','São Raimundo das Mangabeiras','0',0,1,10),(1346,'\0','3104502','Arinos','0',0,1,11),(1347,'\0','3108206','Bonfinópolis de Minas','0',0,1,11),(1348,'\0','3109303','Buritis','0',0,1,11),(1349,'\0','3109451','Cabeceira Grande','0',0,1,11),(1350,'\0','3122470','Dom Bosco','0',0,1,11),(1351,'\0','3126208','Formoso','0',0,1,11),(1352,'\0','3144375','Natalândia','0',0,1,11),(1353,'\0','3170404','Unaí','0',0,1,11),(1354,'\0','3170479','Uruana de Minas','0',0,1,11),(1355,'\0','3108552','Brasilândia de Minas','0',0,1,11),(1356,'\0','3128600','Guarda-Mor','0',0,1,11),(1357,'\0','3136306','João Pinheiro','0',0,1,11),(1358,'\0','3137106','Lagamar','0',0,1,11),(1359,'\0','3137536','Lagoa Grande','0',0,1,11),(1360,'\0','3147006','Paracatu','0',0,1,11),(1361,'\0','3153400','Presidente Olegário','0',0,1,11),(1362,'\0','3161700','São Gonçalo do Abaeté','0',0,1,11),(1363,'\0','3170750','Varjão de Minas','0',0,1,11),(1364,'\0','3171006','Vazante','0',0,1,11),(1365,'\0','3108255','Bonito de Minas','0',0,1,11),(1366,'\0','3116159','Chapada Gaúcha','0',0,1,11),(1367,'\0','3117836','Cônego Marinho','0',0,1,11),(1368,'\0','3130051','Icaraí de Minas','0',0,1,11),(1369,'\0','3132107','Itacarambi','0',0,1,11),(1370,'\0','3135209','Januária','0',0,1,11),(1371,'\0','3136959','Juvenília','0',0,1,11),(1372,'\0','3139300','Manga','0',0,1,11),(1373,'\0','3140852','Matias Cardoso','0',0,1,11),(1374,'\0','3142254','Miravânia','0',0,1,11),(1375,'\0','3142700','Montalvânia','0',0,1,11),(1376,'\0','3149150','Pedras de Maria da Cruz','0',0,1,11),(1377,'\0','3150570','Pintópolis','0',0,1,11),(1378,'\0','3161106','São Francisco','0',0,1,11),(1379,'\0','3162450','São João das Missões','0',0,1,11),(1380,'\0','3170529','Urucuia','0',0,1,11),(1381,'\0','3115474','Catuti','0',0,1,11),(1382,'\0','3124302','Espinosa','0',0,1,11),(1383,'\0','3127339','Gameleiras','0',0,1,11),(1384,'\0','3135050','Jaíba','0',0,1,11),(1385,'\0','3135100','Janaúba','0',0,1,11),(1386,'\0','3139250','Mamonas','0',0,1,11),(1387,'\0','3141009','Mato Verde','0',0,1,11),(1388,'\0','3142908','Monte Azul','0',0,1,11),(1389,'\0','3145059','Nova Porteirinha','0',0,1,11),(1390,'\0','3146552','Pai Pedro','0',0,1,11),(1391,'\0','3152204','Porteirinha','0',0,1,11),(1392,'\0','3154507','Riacho dos Machados','0',0,1,11),(1393,'\0','3166956','Serranópolis de Minas','0',0,1,11),(1394,'\0','3101003','Águas Vermelhas','0',0,1,11),(1395,'\0','3106655','Berizal','0',0,1,11),(1396,'\0','3120870','Curral de Dentro','0',0,1,11),(1397,'\0','3122355','Divisa Alegre','0',0,1,11),(1398,'\0','3127073','Fruta de Leite','0',0,1,11),(1399,'\0','3130655','Indaiabira','0',0,1,11),(1400,'\0','3143450','Montezuma','0',0,1,11),(1401,'\0','3144656','Ninheira','0',0,1,11),(1402,'\0','3145372','Novorizonte','0',0,1,11),(1403,'\0','3155603','Rio Pardo de Minas','0',0,1,11),(1404,'\0','3156502','Rubelita','0',0,1,11),(1405,'\0','3157005','Salinas','0',0,1,11),(1406,'\0','3157377','Santa Cruz de Salinas','0',0,1,11),(1407,'\0','3160454','Santo Antônio do Retiro','0',0,1,11),(1408,'\0','3162708','São João do Paraíso','0',0,1,11),(1409,'\0','3168002','Taiobeiras','0',0,1,11),(1410,'\0','3170651','Vargem Grande do Rio Pardo','0',0,1,11),(1411,'\0','3109402','Buritizeiro','0',0,1,11),(1412,'\0','3129608','Ibiaí','0',0,1,11),(1413,'\0','3135605','Jequitaí','0',0,1,11),(1414,'\0','3137304','Lagoa dos Patos','0',0,1,11),(1415,'\0','3138104','Lassance','0',0,1,11),(1416,'\0','3151206','Pirapora','0',0,1,11),(1417,'\0','3154457','Riachinho','0',0,1,11),(1418,'\0','3157609','Santa Fé de Minas','0',0,1,11),(1419,'\0','3164209','São Romão','0',0,1,11),(1420,'\0','3170800','Várzea da Palma','0',0,1,11),(1421,'\0','3108602','Brasília de Minas','0',0,1,11),(1422,'\0','3111150','Campo Azul','0',0,1,11),(1423,'\0','3112703','Capitão Enéas','0',0,1,11),(1424,'\0','3116506','Claro dos Poções','0',0,1,11),(1425,'\0','3118809','Coração de Jesus','0',0,1,11),(1426,'\0','3126703','Francisco Sá','0',0,1,11),(1427,'\0','3127354','Glaucilândia','0',0,1,11),(1428,'\0','3129657','Ibiracatu','0',0,1,11),(1429,'\0','3135357','Japonvar','0',0,1,11),(1430,'\0','3136801','Juramento','0',0,1,11),(1431,'\0','3138658','Lontra','0',0,1,11),(1432,'\0','3138682','Luislândia','0',0,1,11),(1433,'\0','3142007','Mirabela','0',0,1,11),(1434,'\0','3143302','Montes Claros','0',0,1,11),(1435,'\0','3147956','Patis','0',0,1,11),(1436,'\0','3152131','Ponto Chique','0',0,1,11),(1437,'\0','3162252','São João da Lagoa','0',0,1,11),(1438,'\0','3162401','São João da Ponte','0',0,1,11),(1439,'\0','3162658','São João do Pacuí','0',0,1,11),(1440,'\0','3170008','Ubaí','0',0,1,11),(1441,'\0','3170909','Varzelândia','0',0,1,11),(1442,'\0','3171030','Verdelândia','0',0,1,11),(1443,'\0','3108503','Botumirim','0',0,1,11),(1444,'\0','3120300','Cristália','0',0,1,11),(1445,'\0','3127800','Grão Mogol','0',0,1,11),(1446,'\0','3132008','Itacambira','0',0,1,11),(1447,'\0','3136579','Josenópolis','0',0,1,11),(1448,'\0','3146255','Padre Carvalho','0',0,1,11),(1449,'\0','3107307','Bocaiúva','0',0,1,11),(1450,'\0','3123809','Engenheiro Navarro','0',0,1,11),(1451,'\0','3126604','Francisco Dumont','0',0,1,11),(1452,'\0','3128253','Guaraciama','0',0,1,11),(1453,'\0','3145455','Olhos-d\'Água','0',0,1,11),(1454,'\0','3120102','Couto de Magalhães de Minas','0',0,1,11),(1455,'\0','3121001','Datas','0',0,1,11),(1456,'\0','3121605','Diamantina','0',0,1,11),(1457,'\0','3125408','Felício dos Santos','0',0,1,11),(1458,'\0','3125507','São Gonçalo do Rio Preto','0',0,1,11),(1459,'\0','3127602','Gouveia','0',0,1,11),(1460,'\0','3153301','Presidente Kubitschek','0',0,1,11),(1461,'\0','3165909','Senador Modestino Gonçalves','0',0,1,11),(1462,'\0','3102852','Angelândia','0',0,1,11),(1463,'\0','3104452','Aricanduva','0',0,1,11),(1464,'\0','3106507','Berilo','0',0,1,11),(1465,'\0','3112307','Capelinha','0',0,1,11),(1466,'\0','3113503','Carbonita','0',0,1,11),(1467,'\0','3116100','Chapada do Norte','0',0,1,11),(1468,'\0','3126505','Francisco Badaró','0',0,1,11),(1469,'\0','3132503','Itamarandiba','0',0,1,11),(1470,'\0','3135456','Jenipapo de Minas','0',0,1,11),(1471,'\0','3136520','José Gonçalves de Minas','0',0,1,11),(1472,'\0','3138351','Leme do Prado','0',0,1,11),(1473,'\0','3141801','Minas Novas','0',0,1,11),(1474,'\0','3169703','Turmalina','0',0,1,11),(1475,'\0','3171071','Veredinha','0',0,1,11),(1476,'\0','3103405','Araçuaí','0',0,1,11),(1477,'\0','3113008','Caraí','0',0,1,11),(1478,'\0','3119500','Coronel Murta','0',0,1,11),(1479,'\0','3134004','Itinga','0',0,1,11),(1480,'\0','3145307','Novo Cruzeiro','0',0,1,11),(1481,'\0','3146305','Padre Paraíso','0',0,1,11),(1482,'\0','3152170','Ponto dos Volantes','0',0,1,11),(1483,'\0','3171600','Virgem da Lapa','0',0,1,11),(1484,'\0','3102704','Cachoeira de Pajeú','0',0,1,11),(1485,'\0','3117009','Comercinho','0',0,1,11),(1486,'\0','3133303','Itaobim','0',0,1,11),(1487,'\0','3141405','Medina','0',0,1,11),(1488,'\0','3148707','Pedra Azul','0',0,1,11),(1489,'\0','3101706','Almenara','0',0,1,11),(1490,'\0','3105202','Bandeira','0',0,1,11),(1491,'\0','3122454','Divisópolis','0',0,1,11),(1492,'\0','3125606','Felisburgo','0',0,1,11),(1493,'\0','3134707','Jacinto','0',0,1,11),(1494,'\0','3135803','Jequitinhonha','0',0,1,11),(1495,'\0','3136009','Joaíma','0',0,1,11),(1496,'\0','3136504','Jordânia','0',0,1,11),(1497,'\0','3140555','Mata Verde','0',0,1,11),(1498,'\0','3143153','Monte Formoso','0',0,1,11),(1499,'\0','3146750','Palmópolis','0',0,1,11),(1500,'\0','3155108','Rio do Prado','0',0,1,11),(1501,'\0','3156601','Rubim','0',0,1,11),(1502,'\0','3157104','Salto da Divisa','0',0,1,11),(1503,'\0','3158102','Santa Maria do Salto','0',0,1,11),(1504,'\0','3160306','Santo Antônio do Jacinto','0',0,1,11),(1505,'\0','3104700','Ataléia','0',0,1,11),(1506,'\0','3115458','Catuji','0',0,1,11),(1507,'\0','3126752','Franciscópolis','0',0,1,11),(1508,'\0','3126802','Frei Gaspar','0',0,1,11),(1509,'\0','3132305','Itaipé','0',0,1,11),(1510,'\0','3137007','Ladainha','0',0,1,11),(1511,'\0','3139201','Malacacheta','0',0,1,11),(1512,'\0','3145356','Novo Oriente de Minas','0',0,1,11),(1513,'\0','3146206','Ouro Verde de Minas','0',0,1,11),(1514,'\0','3148509','Pavão','0',0,1,11),(1515,'\0','3152402','Poté','0',0,1,11),(1516,'\0','3165552','Setubinha','0',0,1,11),(1517,'\0','3168606','Teófilo Otoni','0',0,1,11),(1518,'\0','3100906','Águas Formosas','0',0,1,11),(1519,'\0','3106606','Bertópolis','0',0,1,11),(1520,'\0','3113701','Carlos Chagas','0',0,1,11),(1521,'\0','3120151','Crisólita','0',0,1,11),(1522,'\0','3127057','Fronteira dos Vales','0',0,1,11),(1523,'\0','3138906','Machacalis','0',0,1,11),(1524,'\0','3144300','Nanuque','0',0,1,11),(1525,'\0','3157658','Santa Helena de Minas','0',0,1,11),(1526,'\0','3166709','Serra dos Aimorés','0',0,1,11),(1527,'\0','3170305','Umburatiba','0',0,1,11),(1528,'\0','3109808','Cachoeira Dourada','0',0,1,11),(1529,'\0','3112604','Capinópolis','0',0,1,11),(1530,'\0','3129103','Gurinhatã','0',0,1,11),(1531,'\0','3131406','Ipiaçu','0',0,1,11),(1532,'\0','3134202','Ituiutaba','0',0,1,11),(1533,'\0','3159803','Santa Vitória','0',0,1,11),(1534,'\0','3103504','Araguari','0',0,1,11),(1535,'\0','3103751','Araporã','0',0,1,11),(1536,'\0','3111804','Canápolis','0',0,1,11),(1537,'\0','3115003','Cascalho Rico','0',0,1,11),(1538,'\0','3115805','Centralina','0',0,1,11),(1539,'\0','3130705','Indianópolis','0',0,1,11),(1540,'\0','3142809','Monte Alegre de Minas','0',0,1,11),(1541,'\0','3152808','Prata','0',0,1,11),(1542,'\0','3169604','Tupaciguara','0',0,1,11),(1543,'\0','3170206','Uberlândia','0',0,1,11),(1544,'\0','3100104','Abadia dos Dourados','0',0,1,11),(1545,'\0','3119302','Coromandel','0',0,1,11),(1546,'\0','3120706','Cruzeiro da Fortaleza','0',0,1,11),(1547,'\0','3123502','Douradoquara','0',0,1,11),(1548,'\0','3124807','Estrela do Sul','0',0,1,11),(1549,'\0','3127909','Grupiara','0',0,1,11),(1550,'\0','3131604','Iraí de Minas','0',0,1,11),(1551,'\0','3143104','Monte Carmelo','0',0,1,11),(1552,'\0','3148103','Patrocínio','0',0,1,11),(1553,'\0','3156403','Romaria','0',0,1,11),(1554,'\0','3166808','Serra do Salitre','0',0,1,11),(1555,'\0','3103801','Arapuá','0',0,1,11),(1556,'\0','3114303','Carmo do Paranaíba','0',0,1,11),(1557,'\0','3128907','Guimarânia','0',0,1,11),(1558,'\0','3137502','Lagoa Formosa','0',0,1,11),(1559,'\0','3141207','Matutina','0',0,1,11),(1560,'\0','3148004','Patos de Minas','0',0,1,11),(1561,'\0','3155504','Rio Paranaíba','0',0,1,11),(1562,'\0','3159704','Santa Rosa da Serra','0',0,1,11),(1563,'\0','3162104','São Gotardo','0',0,1,11),(1564,'\0','3168903','Tiros','0',0,1,11),(1565,'\0','3111101','Campina Verde','0',0,1,11),(1566,'\0','3114550','Carneirinho','0',0,1,11),(1567,'\0','3116902','Comendador Gomes','0',0,1,11),(1568,'\0','3127008','Fronteira','0',0,1,11),(1569,'\0','3127107','Frutal','0',0,1,11),(1570,'\0','3133402','Itapagipe','0',0,1,11),(1571,'\0','3134400','Iturama','0',0,1,11),(1572,'\0','3138625','Limeira do Oeste','0',0,1,11),(1573,'\0','3150703','Pirajuba','0',0,1,11),(1574,'\0','3151602','Planura','0',0,1,11),(1575,'\0','3161304','São Francisco de Sales','0',0,1,11),(1576,'\0','3170438','União de Minas','0',0,1,11),(1577,'\0','3100708','Água Comprida','0',0,1,11),(1578,'\0','3111408','Campo Florido','0',0,1,11),(1579,'\0','3117306','Conceição das Alagoas','0',0,1,11),(1580,'\0','3118205','Conquista','0',0,1,11),(1581,'\0','3121258','Delta','0',0,1,11),(1582,'\0','3170107','Uberaba','0',0,1,11),(1583,'\0','3171105','Veríssimo','0',0,1,11),(1584,'\0','3104007','Araxá','0',0,1,11),(1585,'\0','3111507','Campos Altos','0',0,1,11),(1586,'\0','3129509','Ibiá','0',0,1,11),(1587,'\0','3145000','Nova Ponte','0',0,1,11),(1588,'\0','3149200','Pedrinópolis','0',0,1,11),(1589,'\0','3149804','Perdizes','0',0,1,11),(1590,'\0','3153004','Pratinha','0',0,1,11),(1591,'\0','3156908','Sacramento','0',0,1,11),(1592,'\0','3157708','Santa Juliana','0',0,1,11),(1593,'\0','3168101','Tapira','0',0,1,11),(1594,'\0','3100203','Abaeté','0',0,1,11),(1595,'\0','3107000','Biquinhas','0',0,1,11),(1596,'\0','3115607','Cedro do Abaeté','0',0,1,11),(1597,'\0','3143500','Morada Nova de Minas','0',0,1,11),(1598,'\0','3146404','Paineiras','0',0,1,11),(1599,'\0','3152006','Pompéu','0',0,1,11),(1600,'\0','3169356','Três Marias','0',0,1,11),(1601,'\0','3104809','Augusto de Lima','0',0,1,11),(1602,'\0','3109204','Buenópolis','0',0,1,11),(1603,'\0','3119104','Corinto','0',0,1,11),(1604,'\0','3120904','Curvelo','0',0,1,11),(1605,'\0','3125705','Felixlândia','0',0,1,11),(1606,'\0','3131109','Inimutaba','0',0,1,11),(1607,'\0','3136405','Joaquim Felício','0',0,1,11),(1608,'\0','3142502','Monjolos','0',0,1,11),(1609,'\0','3143609','Morro da Garça','0',0,1,11),(1610,'\0','3153202','Presidente Juscelino','0',0,1,11),(1611,'\0','3160603','Santo Hipólito','0',0,1,11),(1612,'\0','3103900','Araújos','0',0,1,11),(1613,'\0','3107406','Bom Despacho','0',0,1,11),(1614,'\0','3123205','Dores do Indaiá','0',0,1,11),(1615,'\0','3124708','Estrela do Indaiá','0',0,1,11),(1616,'\0','3135308','Japaraíba','0',0,1,11),(1617,'\0','3137205','Lagoa da Prata','0',0,1,11),(1618,'\0','3138302','Leandro Ferreira','0',0,1,11),(1619,'\0','3138807','Luz','0',0,1,11),(1620,'\0','3140506','Martinho Campos','0',0,1,11),(1621,'\0','3142403','Moema','0',0,1,11),(1622,'\0','3153707','Quartel Geral','0',0,1,11),(1623,'\0','3166600','Serra da Saudade','0',0,1,11),(1624,'\0','3103207','Araçaí','0',0,1,11),(1625,'\0','3105004','Baldim','0',0,1,11),(1626,'\0','3109600','Cachoeira da Prata','0',0,1,11),(1627,'\0','3109907','Caetanópolis','0',0,1,11),(1628,'\0','3112505','Capim Branco','0',0,1,11),(1629,'\0','3118908','Cordisburgo','0',0,1,11),(1630,'\0','3126406','Fortuna de Minas','0',0,1,11),(1631,'\0','3127206','Funilândia','0',0,1,11),(1632,'\0','3131000','Inhaúma','0',0,1,11),(1633,'\0','3134608','Jaboticatubas','0',0,1,11),(1634,'\0','3135704','Jequitibá','0',0,1,11),(1635,'\0','3139706','Maravilhas','0',0,1,11),(1636,'\0','3141108','Matozinhos','0',0,1,11),(1637,'\0','3146909','Papagaios','0',0,1,11),(1638,'\0','3147402','Paraopeba','0',0,1,11),(1639,'\0','3149606','Pequi','0',0,1,11),(1640,'\0','3153608','Prudente de Morais','0',0,1,11),(1641,'\0','3158508','Santana de Pirapama','0',0,1,11),(1642,'\0','3159001','Santana do Riacho','0',0,1,11),(1643,'\0','3167202','Sete Lagoas','0',0,1,11),(1644,'\0','3102407','Alvorada de Minas','0',0,1,11),(1645,'\0','3117504','Conceição do Mato Dentro','0',0,1,11),(1646,'\0','3118106','Congonhas do Norte','0',0,1,11),(1647,'\0','3122603','Dom Joaquim','0',0,1,11),(1648,'\0','3132800','Itambé do Mato Dentro','0',0,1,11),(1649,'\0','3143708','Morro do Pilar','0',0,1,11),(1650,'\0','3147501','Passabém','0',0,1,11),(1651,'\0','3156007','Rio Vermelho','0',0,1,11),(1652,'\0','3160207','Santo Antônio do Itambé','0',0,1,11),(1653,'\0','3160504','Santo Antônio do Rio Abaixo','0',0,1,11),(1654,'\0','3164803','São Sebastião do Rio Preto','0',0,1,11),(1655,'\0','3166501','Serra Azul de Minas','0',0,1,11),(1656,'\0','3167103','Serro','0',0,1,11),(1657,'\0','3126000','Florestal','0',0,1,11),(1658,'\0','3145802','Onça de Pitangui','0',0,1,11),(1659,'\0','3147105','Pará de Minas','0',0,1,11),(1660,'\0','3151404','Pitangui','0',0,1,11),(1661,'\0','3163102','São José da Varginha','0',0,1,11),(1662,'\0','3106200','Belo Horizonte','0',0,1,11),(1663,'\0','3106705','Betim','0',0,1,11),(1664,'\0','3109006','Brumadinho','0',0,1,11),(1665,'\0','3110004','Caeté','0',0,1,11),(1666,'\0','3117876','Confins','0',0,1,11),(1667,'\0','3118601','Contagem','0',0,1,11),(1668,'\0','3124104','Esmeraldas','0',0,1,11),(1669,'\0','3129806','Ibirité','0',0,1,11),(1670,'\0','3130101','Igarapé','0',0,1,11),(1671,'\0','3136652','Juatuba','0',0,1,11),(1672,'\0','3137601','Lagoa Santa','0',0,1,11),(1673,'\0','3140159','Mário Campos','0',0,1,11),(1674,'\0','3140704','Mateus Leme','0',0,1,11),(1675,'\0','3144805','Nova Lima','0',0,1,11),(1676,'\0','3149309','Pedro Leopoldo','0',0,1,11),(1677,'\0','3153905','Raposos','0',0,1,11),(1678,'\0','3154606','Ribeirão das Neves','0',0,1,11),(1679,'\0','3154804','Rio Acima','0',0,1,11),(1680,'\0','3156700','Sabará','0',0,1,11),(1681,'\0','3157807','Santa Luzia','0',0,1,11),(1682,'\0','3162922','São Joaquim de Bicas','0',0,1,11),(1683,'\0','3162955','São José da Lapa','0',0,1,11),(1684,'\0','3165537','Sarzedo','0',0,1,11),(1685,'\0','3171204','Vespasiano','0',0,1,11),(1686,'\0','3102308','Alvinópolis','0',0,1,11),(1687,'\0','3105400','Barão de Cocais','0',0,1,11),(1688,'\0','3106002','Bela Vista de Minas','0',0,1,11),(1689,'\0','3107703','Bom Jesus do Amparo','0',0,1,11),(1690,'\0','3115359','Catas Altas','0',0,1,11),(1691,'\0','3121803','Dionísio','0',0,1,11),(1692,'\0','3125903','Ferros','0',0,1,11),(1693,'\0','3131703','Itabira','0',0,1,11),(1694,'\0','3136207','João Monlevade','0',0,1,11),(1695,'\0','3136603','Nova União','0',0,1,11),(1696,'\0','3144706','Nova Era','0',0,1,11),(1697,'\0','3155702','Rio Piracicaba','0',0,1,11),(1698,'\0','3157203','Santa Bárbara','0',0,1,11),(1699,'\0','3158003','Santa Maria de Itabira','0',0,1,11),(1700,'\0','3161007','São Domingos do Prata','0',0,1,11),(1701,'\0','3161908','São Gonçalo do Rio Abaixo','0',0,1,11),(1702,'\0','3163409','São José do Goiabal','0',0,1,11),(1703,'\0','3168309','Taquaraçu de Minas','0',0,1,11),(1704,'\0','3106408','Belo Vale','0',0,1,11),(1705,'\0','3108107','Bonfim','0',0,1,11),(1706,'\0','3120607','Crucilândia','0',0,1,11),(1707,'\0','3132206','Itaguara','0',0,1,11),(1708,'\0','3133709','Itatiaiuçu','0',0,1,11),(1709,'\0','3135407','Jeceaba','0',0,1,11),(1710,'\0','3142304','Moeda','0',0,1,11),(1711,'\0','3150406','Piedade dos Gerais','0',0,1,11),(1712,'\0','3155306','Rio Manso','0',0,1,11),(1713,'\0','3121704','Diogo de Vasconcelos','0',0,1,11),(1714,'\0','3131901','Itabirito','0',0,1,11),(1715,'\0','3140001','Mariana','0',0,1,11),(1716,'\0','3146107','Ouro Preto','0',0,1,11),(1717,'\0','3114907','Casa Grande','0',0,1,11),(1718,'\0','3115409','Catas Altas da Noruega','0',0,1,11),(1719,'\0','3118007','Congonhas','0',0,1,11),(1720,'\0','3118304','Conselheiro Lafaiete','0',0,1,11),(1721,'\0','3120409','Cristiano Otoni','0',0,1,11),(1722,'\0','3121407','Desterro de Entre Rios','0',0,1,11),(1723,'\0','3123908','Entre Rios de Minas','0',0,1,11),(1724,'\0','3133907','Itaverava','0',0,1,11),(1725,'\0','3145901','Ouro Branco','0',0,1,11),(1726,'\0','3153806','Queluzito','0',0,1,11),(1727,'\0','3159100','Santana dos Montes','0',0,1,11),(1728,'\0','3160900','São Brás do Suaçuí','0',0,1,11),(1729,'\0','3108800','Braúnas','0',0,1,11),(1730,'\0','3113800','Carmésia','0',0,1,11),(1731,'\0','3116803','Coluna','0',0,1,11),(1732,'\0','3122207','Divinolândia de Minas','0',0,1,11),(1733,'\0','3123106','Dores de Guanhães','0',0,1,11),(1734,'\0','3127503','Gonzaga','0',0,1,11),(1735,'\0','3128006','Guanhães','0',0,1,11),(1736,'\0','3140605','Materlândia','0',0,1,11),(1737,'\0','3148400','Paulistas','0',0,1,11),(1738,'\0','3156809','Sabinópolis','0',0,1,11),(1739,'\0','3157500','Santa Efigênia de Minas','0',0,1,11),(1740,'\0','3162807','São João Evangelista','0',0,1,11),(1741,'\0','3165503','Sardoá','0',0,1,11),(1742,'\0','3166105','Senhora do Porto','0',0,1,11),(1743,'\0','3171808','Virginópolis','0',0,1,11),(1744,'\0','3100609','Água Boa','0',0,1,11),(1745,'\0','3112059','Cantagalo','0',0,1,11),(1746,'\0','3126950','Frei Lagonegro','0',0,1,11),(1747,'\0','3136553','José Raydan','0',0,1,11),(1748,'\0','3148608','Peçanha','0',0,1,11),(1749,'\0','3158201','Santa Maria do Suaçuí','0',0,1,11),(1750,'\0','3163508','São José do Jacuri','0',0,1,11),(1751,'\0','3164100','São Pedro do Suaçuí','0',0,1,11),(1752,'\0','3164506','São Sebastião do Maranhão','0',0,1,11),(1753,'\0','3101805','Alpercata','0',0,1,11),(1754,'\0','3110806','Campanário','0',0,1,11),(1755,'\0','3112653','Capitão Andrade','0',0,1,11),(1756,'\0','3119203','Coroaci','0',0,1,11),(1757,'\0','3122108','Divino das Laranjeiras','0',0,1,11),(1758,'\0','3123700','Engenheiro Caldas','0',0,1,11),(1759,'\0','3125804','Fernandes Tourinho','0',0,1,11),(1760,'\0','3126901','Frei Inocêncio','0',0,1,11),(1761,'\0','3127305','Galiléia','0',0,1,11),(1762,'\0','3127701','Governador Valadares','0',0,1,11),(1763,'\0','3132701','Itambacuri','0',0,1,11),(1764,'\0','3133204','Itanhomi','0',0,1,11),(1765,'\0','3135076','Jampruca','0',0,1,11),(1766,'\0','3140100','Marilac','0',0,1,11),(1767,'\0','3144201','Nacip Raydan','0',0,1,11),(1768,'\0','3144904','Nova Módica','0',0,1,11),(1769,'\0','3150000','Pescador','0',0,1,11),(1770,'\0','3161601','São Geraldo da Piedade','0',0,1,11),(1771,'\0','3161650','São Geraldo do Baixio','0',0,1,11),(1772,'\0','3163003','São José da Safira','0',0,1,11),(1773,'\0','3163300','São José do Divino','0',0,1,11),(1774,'\0','3167707','Sobrália','0',0,1,11),(1775,'\0','3169505','Tumiritinga','0',0,1,11),(1776,'\0','3171501','Mathias Lobato','0',0,1,11),(1777,'\0','3171907','Virgolândia','0',0,1,11),(1778,'\0','3115706','Central de Minas','0',0,1,11),(1779,'\0','3131802','Itabirinha','0',0,1,11),(1780,'\0','3139607','Mantena','0',0,1,11),(1781,'\0','3141504','Mendes Pimentel','0',0,1,11),(1782,'\0','3144672','Nova Belém','0',0,1,11),(1783,'\0','3161056','São Félix de Minas','0',0,1,11),(1784,'\0','3162575','São João do Manteninha','0',0,1,11),(1785,'\0','3100500','Açucena','0',0,1,11),(1786,'\0','3103009','Antônio Dias','0',0,1,11),(1787,'\0','3106309','Belo Oriente','0',0,1,11),(1788,'\0','3119401','Coronel Fabriciano','0',0,1,11),(1789,'\0','3131307','Ipatinga','0',0,1,11),(1790,'\0','3135001','Jaguaraçu','0',0,1,11),(1791,'\0','3136108','Joanésia','0',0,1,11),(1792,'\0','3140308','Marliéria','0',0,1,11),(1793,'\0','3141702','Mesquita','0',0,1,11),(1794,'\0','3144359','Naque','0',0,1,11),(1795,'\0','3149952','Periquito','0',0,1,11),(1796,'\0','3158953','Santana do Paraíso','0',0,1,11),(1797,'\0','3168705','Timóteo','0',0,1,11),(1798,'\0','3107802','Bom Jesus do Galho','0',0,1,11),(1799,'\0','3109253','Bugre','0',0,1,11),(1800,'\0','3113404','Caratinga','0',0,1,11),(1801,'\0','3120003','Córrego Novo','0',0,1,11),(1802,'\0','3122504','Dom Cavati','0',0,1,11),(1803,'\0','3123858','Entre Folhas','0',0,1,11),(1804,'\0','3129301','Iapu','0',0,1,11),(1805,'\0','3130556','Imbé de Minas','0',0,1,11),(1806,'\0','3130903','Inhapim','0',0,1,11),(1807,'\0','3131158','Ipaba','0',0,1,11),(1808,'\0','3150158','Piedade de Caratinga','0',0,1,11),(1809,'\0','3150539','Pingo-d\'Água','0',0,1,11),(1810,'\0','3157252','Santa Bárbara do Leste','0',0,1,11),(1811,'\0','3159357','Santa Rita de Minas','0',0,1,11),(1812,'\0','3160959','São Domingos das Dores','0',0,1,11),(1813,'\0','3162609','São João do Oriente','0',0,1,11),(1814,'\0','3164472','São Sebastião do Anta','0',0,1,11),(1815,'\0','3168408','Tarumirim','0',0,1,11),(1816,'\0','3170057','Ubaporanga','0',0,1,11),(1817,'\0','3170578','Vargem Alegre','0',0,1,11),(1818,'\0','3101102','Aimorés','0',0,1,11),(1819,'\0','3102209','Alvarenga','0',0,1,11),(1820,'\0','3117405','Conceição de Ipanema','0',0,1,11),(1821,'\0','3118403','Conselheiro Pena','0',0,1,11),(1822,'\0','3120839','Cuparaque','0',0,1,11),(1823,'\0','3127370','Goiabeira','0',0,1,11),(1824,'\0','3131208','Ipanema','0',0,1,11),(1825,'\0','3134103','Itueta','0',0,1,11),(1826,'\0','3144003','Mutum','0',0,1,11),(1827,'\0','3151909','Pocrane','0',0,1,11),(1828,'\0','3154309','Resplendor','0',0,1,11),(1829,'\0','3159506','Santa Rita do Itueto','0',0,1,11),(1830,'\0','3168051','Taparuba','0',0,1,11),(1831,'\0','3105103','Bambuí','0',0,1,11),(1832,'\0','3119807','Córrego Danta','0',0,1,11),(1833,'\0','3123403','Doresópolis','0',0,1,11),(1834,'\0','3130309','Iguatama','0',0,1,11),(1835,'\0','3141306','Medeiros','0',0,1,11),(1836,'\0','3151503','Piumhi','0',0,1,11),(1837,'\0','3164308','São Roque de Minas','0',0,1,11),(1838,'\0','3168200','Tapiraí','0',0,1,11),(1839,'\0','3170602','Vargem Bonita','0',0,1,11),(1840,'\0','3114204','Carmo do Cajuru','0',0,1,11),(1841,'\0','3116605','Cláudio','0',0,1,11),(1842,'\0','3117603','Conceição do Pará','0',0,1,11),(1843,'\0','3122306','Divinópolis','0',0,1,11),(1844,'\0','3130200','Igaratinga','0',0,1,11),(1845,'\0','3133808','Itaúna','0',0,1,11),(1846,'\0','3145208','Nova Serrana','0',0,1,11),(1847,'\0','3149705','Perdigão','0',0,1,11),(1848,'\0','3160405','Santo Antônio do Monte','0',0,1,11),(1849,'\0','3161809','São Gonçalo do Pará','0',0,1,11),(1850,'\0','3164605','São Sebastião do Oeste','0',0,1,11),(1851,'\0','3104205','Arcos','0',0,1,11),(1852,'\0','3110400','Camacho','0',0,1,11),(1853,'\0','3119955','Córrego Fundo','0',0,1,11),(1854,'\0','3126109','Formiga','0',0,1,11),(1855,'\0','3133501','Itapecerica','0',0,1,11),(1856,'\0','3146503','Pains','0',0,1,11),(1857,'\0','3148905','Pedra do Indaiá','0',0,1,11),(1858,'\0','3150505','Pimenta','0',0,1,11),(1859,'\0','3100807','Aguanil','0',0,1,11),(1860,'\0','3111200','Campo Belo','0',0,1,11),(1861,'\0','3111903','Cana Verde','0',0,1,11),(1862,'\0','3112000','Candeias','0',0,1,11),(1863,'\0','3120201','Cristais','0',0,1,11),(1864,'\0','3149903','Perdões','0',0,1,11),(1865,'\0','3158805','Santana do Jacaré','0',0,1,11),(1866,'\0','3108008','Bom Sucesso','0',0,1,11),(1867,'\0','3114006','Carmo da Mata','0',0,1,11),(1868,'\0','3114501','Carmópolis de Minas','0',0,1,11),(1869,'\0','3130002','Ibituruna','0',0,1,11),(1870,'\0','3145604','Oliveira','0',0,1,11),(1871,'\0','3147709','Passa Tempo','0',0,1,11),(1872,'\0','3150604','Piracema','0',0,1,11),(1873,'\0','3159902','Santo Antônio do Amparo','0',0,1,11),(1874,'\0','3161205','São Francisco de Paula','0',0,1,11),(1875,'\0','3101904','Alpinópolis','0',0,1,11),(1876,'\0','3107604','Bom Jesus da Penha','0',0,1,11),(1877,'\0','3112406','Capetinga','0',0,1,11),(1878,'\0','3112802','Capitólio','0',0,1,11),(1879,'\0','3115102','Cássia','0',0,1,11),(1880,'\0','3116407','Claraval','0',0,1,11),(1881,'\0','3121209','Delfinópolis','0',0,1,11),(1882,'\0','3126307','Fortaleza de Minas','0',0,1,11),(1883,'\0','3129707','Ibiraci','0',0,1,11),(1884,'\0','3133758','Itaú de Minas','0',0,1,11),(1885,'\0','3147907','Passos','0',0,1,11),(1886,'\0','3152907','Pratápolis','0',0,1,11),(1887,'\0','3162203','São João Batista do Glória','0',0,1,11),(1888,'\0','3162948','São José da Barra','0',0,1,11),(1889,'\0','3104106','Arceburgo','0',0,1,11),(1890,'\0','3109501','Cabo Verde','0',0,1,11),(1891,'\0','3128303','Guaranésia','0',0,1,11),(1892,'\0','3128709','Guaxupé','0',0,1,11),(1893,'\0','3132909','Itamogi','0',0,1,11),(1894,'\0','3134806','Jacuí','0',0,1,11),(1895,'\0','3136900','Juruaia','0',0,1,11),(1896,'\0','3143005','Monte Belo','0',0,1,11),(1897,'\0','3143203','Monte Santo de Minas','0',0,1,11),(1898,'\0','3144102','Muzambinho','0',0,1,11),(1899,'\0','3145109','Nova Resende','0',0,1,11),(1900,'\0','3163904','São Pedro da União','0',0,1,11),(1901,'\0','3164704','São Sebastião do Paraíso','0',0,1,11),(1902,'\0','3165107','São Tomás de Aquino','0',0,1,11),(1903,'\0','3101607','Alfenas','0',0,1,11),(1904,'\0','3102001','Alterosa','0',0,1,11),(1905,'\0','3104304','Areado','0',0,1,11),(1906,'\0','3114402','Carmo do Rio Claro','0',0,1,11),(1907,'\0','3114709','Carvalhópolis','0',0,1,11),(1908,'\0','3117108','Conceição da Aparecida','0',0,1,11),(1909,'\0','3122405','Divisa Nova','0',0,1,11),(1910,'\0','3125200','Fama','0',0,1,11),(1911,'\0','3139003','Machado','0',0,1,11),(1912,'\0','3147204','Paraguaçu','0',0,1,11),(1913,'\0','3151701','Poço Fundo','0',0,1,11),(1914,'\0','3166907','Serrania','0',0,1,11),(1915,'\0','3107109','Boa Esperança','0',0,1,11),(1916,'\0','3110905','Campanha','0',0,1,11),(1917,'\0','3111309','Campo do Meio','0',0,1,11),(1918,'\0','3111606','Campos Gerais','0',0,1,11),(1919,'\0','3113909','Carmo da Cachoeira','0',0,1,11),(1920,'\0','3118700','Coqueiral','0',0,1,11),(1921,'\0','3123601','Elói Mendes','0',0,1,11),(1922,'\0','3128105','Guapé','0',0,1,11),(1923,'\0','3130507','Ilicínea','0',0,1,11),(1924,'\0','3142601','Monsenhor Paulo','0',0,1,11),(1925,'\0','3158300','Santana da Vargem','0',0,1,11),(1926,'\0','3160801','São Bento Abade','0',0,1,11),(1927,'\0','3165206','São Thomé das Letras','0',0,1,11),(1928,'\0','3169307','Três Corações','0',0,1,11),(1929,'\0','3169406','Três Pontas','0',0,1,11),(1930,'\0','3170701','Varginha','0',0,1,11),(1931,'\0','3101409','Albertina','0',0,1,11),(1932,'\0','3102605','Andradas','0',0,1,11),(1933,'\0','3105301','Bandeira do Sul','0',0,1,11),(1934,'\0','3108404','Botelhos','0',0,1,11),(1935,'\0','3110301','Caldas','0',0,1,11),(1936,'\0','3111002','Campestre','0',0,1,11),(1937,'\0','3129905','Ibitiúra de Minas','0',0,1,11),(1938,'\0','3130606','Inconfidentes','0',0,1,11),(1939,'\0','3134905','Jacutinga','0',0,1,11),(1940,'\0','3143401','Monte Sião','0',0,1,11),(1941,'\0','3146008','Ouro Fino','0',0,1,11),(1942,'\0','3151800','Poços de Caldas','0',0,1,11),(1943,'\0','3159209','Santa Rita de Caldas','0',0,1,11),(1944,'\0','3107901','Bom Repouso','0',0,1,11),(1945,'\0','3108305','Borda da Mata','0',0,1,11),(1946,'\0','3109105','Bueno Brandão','0',0,1,11),(1947,'\0','3110509','Camanducaia','0',0,1,11),(1948,'\0','3110608','Cambuí','0',0,1,11),(1949,'\0','3117900','Congonhal','0',0,1,11),(1950,'\0','3119906','Córrego do Bom Jesus','0',0,1,11),(1951,'\0','3124401','Espírito Santo do Dourado','0',0,1,11),(1952,'\0','3124500','Estiva','0',0,1,11),(1953,'\0','3125101','Extrema','0',0,1,11),(1954,'\0','3127404','Gonçalves','0',0,1,11),(1955,'\0','3131505','Ipuiúna','0',0,1,11),(1956,'\0','3133600','Itapeva','0',0,1,11),(1957,'\0','3143807','Munhoz','0',0,1,11),(1958,'\0','3152501','Pouso Alegre','0',0,1,11),(1959,'\0','3165404','Sapucaí-Mirim','0',0,1,11),(1960,'\0','3165578','Senador Amaral','0',0,1,11),(1961,'\0','3165800','Senador José Bento','0',0,1,11),(1962,'\0','3169059','Tocos do Moji','0',0,1,11),(1963,'\0','3169109','Toledo','0',0,1,11),(1964,'\0','3109709','Cachoeira de Minas','0',0,1,11),(1965,'\0','3113602','Careaçu','0',0,1,11),(1966,'\0','3117207','Conceição das Pedras','0',0,1,11),(1967,'\0','3117801','Conceição dos Ouros','0',0,1,11),(1968,'\0','3119005','Cordislândia','0',0,1,11),(1969,'\0','3129202','Heliodora','0',0,1,11),(1970,'\0','3144409','Natércia','0',0,1,11),(1971,'\0','3149101','Pedralva','0',0,1,11),(1972,'\0','3159605','Santa Rita do Sapucaí','0',0,1,11),(1973,'\0','3162005','São Gonçalo do Sapucaí','0',0,1,11),(1974,'\0','3162302','São João da Mata','0',0,1,11),(1975,'\0','3163201','São José do Alegre','0',0,1,11),(1976,'\0','3164407','São Sebastião da Bela Vista','0',0,1,11),(1977,'\0','3167400','Silvianópolis','0',0,1,11),(1978,'\0','3169802','Turvolândia','0',0,1,11),(1979,'\0','3101300','Alagoa','0',0,1,11),(1980,'\0','3104908','Baependi','0',0,1,11),(1981,'\0','3110707','Cambuquira','0',0,1,11),(1982,'\0','3114105','Carmo de Minas','0',0,1,11),(1983,'\0','3115508','Caxambu','0',0,1,11),(1984,'\0','3117702','Conceição do Rio Verde','0',0,1,11),(1985,'\0','3133006','Itamonte','0',0,1,11),(1986,'\0','3133105','Itanhandu','0',0,1,11),(1987,'\0','3135902','Jesuânia','0',0,1,11),(1988,'\0','3137809','Lambari','0',0,1,11),(1989,'\0','3145505','Olímpio Noronha','0',0,1,11),(1990,'\0','3147600','Passa Quatro','0',0,1,11),(1991,'\0','3152600','Pouso Alto','0',0,1,11),(1992,'\0','3163706','São Lourenço','0',0,1,11),(1993,'\0','3164902','São Sebastião do Rio Verde','0',0,1,11),(1994,'\0','3167806','Soledade de Minas','0',0,1,11),(1995,'\0','3101201','Aiuruoca','0',0,1,11),(1996,'\0','3102803','Andrelândia','0',0,1,11),(1997,'\0','3103603','Arantina','0',0,1,11),(1998,'\0','3107208','Bocaina de Minas','0',0,1,11),(1999,'\0','3107505','Bom Jardim de Minas','0',0,1,11),(2000,'\0','3114808','Carvalhos','0',0,1,11),(2001,'\0','3120805','Cruzília','0',0,1,11),(2002,'\0','3138500','Liberdade','0',0,1,11),(2003,'\0','3141900','Minduri','0',0,1,11),(2004,'\0','3147808','Passa-Vinte','0',0,1,11),(2005,'\0','3165305','São Vicente de Minas','0',0,1,11),(2006,'\0','3166402','Seritinga','0',0,1,11),(2007,'\0','3167004','Serranos','0',0,1,11),(2008,'\0','3108909','Brasópolis','0',0,1,11),(2009,'\0','3118502','Consolação','0',0,1,11),(2010,'\0','3120508','Cristina','0',0,1,11),(2011,'\0','3121100','Delfim Moreira','0',0,1,11),(2012,'\0','3122801','Dom Viçoso','0',0,1,11),(2013,'\0','3132404','Itajubá','0',0,1,11),(2014,'\0','3139904','Maria da Fé','0',0,1,11),(2015,'\0','3140407','Marmelópolis','0',0,1,11),(2016,'\0','3147303','Paraisópolis','0',0,1,11),(2017,'\0','3150901','Piranguçu','0',0,1,11),(2018,'\0','3151008','Piranguinho','0',0,1,11),(2019,'\0','3171709','Virgínia','0',0,1,11),(2020,'\0','3172202','Wenceslau Braz','0',0,1,11),(2021,'\0','3114600','Carrancas','0',0,1,11),(2022,'\0','3130408','Ijaci','0',0,1,11),(2023,'\0','3130804','Ingaí','0',0,1,11),(2024,'\0','3134301','Itumirim','0',0,1,11),(2025,'\0','3134509','Itutinga','0',0,1,11),(2026,'\0','3138203','Lavras','0',0,1,11),(2027,'\0','3138708','Luminárias','0',0,1,11),(2028,'\0','3144607','Nepomuceno','0',0,1,11),(2029,'\0','3154705','Ribeirão Vermelho','0',0,1,11),(2030,'\0','3115201','Conceição da Barra de Minas','0',0,1,11),(2031,'\0','3119708','Coronel Xavier Chaves','0',0,1,11),(2032,'\0','3123007','Dores de Campos','0',0,1,11),(2033,'\0','3137403','Lagoa Dourada','0',0,1,11),(2034,'\0','3139102','Madre de Deus de Minas','0',0,1,11),(2035,'\0','3144508','Nazareno','0',0,1,11),(2036,'\0','3150307','Piedade do Rio Grande','0',0,1,11),(2037,'\0','3152709','Prados','0',0,1,11),(2038,'\0','3154200','Resende Costa','0',0,1,11),(2039,'\0','3156106','Ritápolis','0',0,1,11),(2040,'\0','3157336','Santa Cruz de Minas','0',0,1,11),(2041,'\0','3158706','Santana do Garambéu','0',0,1,11),(2042,'\0','3162500','São João del Rei','0',0,1,11),(2043,'\0','3165008','São Tiago','0',0,1,11),(2044,'\0','3168804','Tiradentes','0',0,1,11),(2045,'\0','3101631','Alfredo Vasconcelos','0',0,1,11),(2046,'\0','3102902','Antônio Carlos','0',0,1,11),(2047,'\0','3105608','Barbacena','0',0,1,11),(2048,'\0','3105905','Barroso','0',0,1,11),(2049,'\0','3112208','Capela Nova','0',0,1,11),(2050,'\0','3113107','Caranaíba','0',0,1,11),(2051,'\0','3113206','Carandaí','0',0,1,11),(2052,'\0','3121506','Desterro do Melo','0',0,1,11),(2053,'\0','3129400','Ibertioga','0',0,1,11),(2054,'\0','3154408','Ressaquinha','0',0,1,11),(2055,'\0','3157302','Santa Bárbara do Tugúrio','0',0,1,11),(2056,'\0','3166204','Senhora dos Remédios','0',0,1,11),(2057,'\0','3100401','Acaiaca','0',0,1,11),(2058,'\0','3105707','Barra Longa','0',0,1,11),(2059,'\0','3122702','Dom Silvério','0',0,1,11),(2060,'\0','3128204','Guaraciaba','0',0,1,11),(2061,'\0','3135506','Jequeri','0',0,1,11),(2062,'\0','3145851','Oratórios','0',0,1,11),(2063,'\0','3150208','Piedade de Ponte Nova','0',0,1,11),(2064,'\0','3152105','Ponte Nova','0',0,1,11),(2065,'\0','3154002','Raul Soares','0',0,1,11),(2066,'\0','3154903','Rio Casca','0',0,1,11),(2067,'\0','3155009','Rio Doce','0',0,1,11),(2068,'\0','3157401','Santa Cruz do Escalvado','0',0,1,11),(2069,'\0','3160108','Santo Antônio do Grama','0',0,1,11),(2070,'\0','3164001','São Pedro dos Ferros','0',0,1,11),(2071,'\0','3165560','Sem-Peixe','0',0,1,11),(2072,'\0','3166303','Sericita','0',0,1,11),(2073,'\0','3170503','Urucânia','0',0,1,11),(2074,'\0','3171154','Vermelho Novo','0',0,1,11),(2075,'\0','3100302','Abre Campo','0',0,1,11),(2076,'\0','3102050','Alto Caparaó','0',0,1,11),(2077,'\0','3112109','Caparaó','0',0,1,11),(2078,'\0','3112901','Caputira','0',0,1,11),(2079,'\0','3116001','Chalé','0',0,1,11),(2080,'\0','3123528','Durandé','0',0,1,11),(2081,'\0','3137700','Lajinha','0',0,1,11),(2082,'\0','3138674','Luisburgo','0',0,1,11),(2083,'\0','3139409','Manhuaçu','0',0,1,11),(2084,'\0','3139508','Manhumirim','0',0,1,11),(2085,'\0','3140530','Martins Soares','0',0,1,11),(2086,'\0','3140902','Matipó','0',0,1,11),(2087,'\0','3148756','Pedra Bonita','0',0,1,11),(2088,'\0','3153509','Alto Jequitibá','0',0,1,11),(2089,'\0','3154150','Reduto','0',0,1,11),(2090,'\0','3157906','Santa Margarida','0',0,1,11),(2091,'\0','3158904','Santana do Manhuaçu','0',0,1,11),(2092,'\0','3162559','São João do Manhuaçu','0',0,1,11),(2093,'\0','3163607','São José do Mantimento','0',0,1,11),(2094,'\0','3167608','Simonésia','0',0,1,11),(2095,'\0','3102100','Alto Rio Doce','0',0,1,11),(2096,'\0','3102506','Amparo do Serra','0',0,1,11),(2097,'\0','3103702','Araponga','0',0,1,11),(2098,'\0','3108701','Brás Pires','0',0,1,11),(2099,'\0','3110202','Cajuri','0',0,1,11),(2100,'\0','3111705','Canaã','0',0,1,11),(2101,'\0','3116308','Cipotânea','0',0,1,11),(2102,'\0','3116704','Coimbra','0',0,1,11),(2103,'\0','3124005','Ervália','0',0,1,11),(2104,'\0','3137908','Lamim','0',0,1,11),(2105,'\0','3148301','Paula Cândido','0',0,1,11),(2106,'\0','3148806','Pedra do Anta','0',0,1,11),(2107,'\0','3150802','Piranga','0',0,1,11),(2108,'\0','3152303','Porto Firme','0',0,1,11),(2109,'\0','3153103','Presidente Bernardes','0',0,1,11),(2110,'\0','3155207','Rio Espera','0',0,1,11),(2111,'\0','3163805','São Miguel do Anta','0',0,1,11),(2112,'\0','3166006','Senhora de Oliveira','0',0,1,11),(2113,'\0','3168507','Teixeiras','0',0,1,11),(2114,'\0','3171303','Viçosa','0',0,1,11),(2115,'\0','3103108','Antônio Prado de Minas','0',0,1,11),(2116,'\0','3105509','Barão de Monte Alto','0',0,1,11),(2117,'\0','3110103','Caiana','0',0,1,11),(2118,'\0','3113305','Carangola','0',0,1,11),(2119,'\0','3122009','Divino','0',0,1,11),(2120,'\0','3124203','Espera Feliz','0',0,1,11),(2121,'\0','3124906','Eugenópolis','0',0,1,11),(2122,'\0','3125309','Faria Lemos','0',0,1,11),(2123,'\0','3125952','Fervedouro','0',0,1,11),(2124,'\0','3142106','Miradouro','0',0,1,11),(2125,'\0','3142205','Miraí','0',0,1,11),(2126,'\0','3143906','Muriaé','0',0,1,11),(2127,'\0','3145877','Orizânia','0',0,1,11),(2128,'\0','3148202','Patrocínio do Muriaé','0',0,1,11),(2129,'\0','3149002','Pedra Dourada','0',0,1,11),(2130,'\0','3156452','Rosário da Limeira','0',0,1,11),(2131,'\0','3161403','São Francisco do Glória','0',0,1,11),(2132,'\0','3164431','São Sebastião da Vargem Alegre','0',0,1,11),(2133,'\0','3169208','Tombos','0',0,1,11),(2134,'\0','3171402','Vieiras','0',0,1,11),(2135,'\0','3104601','Astolfo Dutra','0',0,1,11),(2136,'\0','3121902','Divinésia','0',0,1,11),(2137,'\0','3123304','Dores do Turvo','0',0,1,11),(2138,'\0','3128402','Guarani','0',0,1,11),(2139,'\0','3128808','Guidoval','0',0,1,11),(2140,'\0','3129004','Guiricema','0',0,1,11),(2141,'\0','3141603','Mercês','0',0,1,11),(2142,'\0','3151305','Piraúba','0',0,1,11),(2143,'\0','3155801','Rio Pomba','0',0,1,11),(2144,'\0','3156304','Rodeiro','0',0,1,11),(2145,'\0','3161502','São Geraldo','0',0,1,11),(2146,'\0','3165701','Senador Firmino','0',0,1,11),(2147,'\0','3167301','Silveirânia','0',0,1,11),(2148,'\0','3167905','Tabuleiro','0',0,1,11),(2149,'\0','3169000','Tocantins','0',0,1,11),(2150,'\0','3169901','Ubá','0',0,1,11),(2151,'\0','3172004','Visconde do Rio Branco','0',0,1,11),(2152,'\0','3103306','Aracitaba','0',0,1,11),(2153,'\0','3106101','Belmiro Braga','0',0,1,11),(2154,'\0','3106804','Bias Fortes','0',0,1,11),(2155,'\0','3106903','Bicas','0',0,1,11),(2156,'\0','3115904','Chácara','0',0,1,11),(2157,'\0','3116209','Chiador','0',0,1,11),(2158,'\0','3119609','Coronel Pacheco','0',0,1,11),(2159,'\0','3121308','Descoberto','0',0,1,11),(2160,'\0','3125002','Ewbank da Câmara','0',0,1,11),(2161,'\0','3127388','Goianá','0',0,1,11),(2162,'\0','3128501','Guarará','0',0,1,11),(2163,'\0','3136702','Juiz de Fora','0',0,1,11),(2164,'\0','3138609','Lima Duarte','0',0,1,11),(2165,'\0','3139805','Mar de Espanha','0',0,1,11),(2166,'\0','3140209','Maripá de Minas','0',0,1,11),(2167,'\0','3140803','Matias Barbosa','0',0,1,11),(2168,'\0','3145406','Olaria','0',0,1,11),(2169,'\0','3145703','Oliveira Fortes','0',0,1,11),(2170,'\0','3146602','Paiva','0',0,1,11),(2171,'\0','3149408','Pedro Teixeira','0',0,1,11),(2172,'\0','3149507','Pequeri','0',0,1,11),(2173,'\0','3150109','Piau','0',0,1,11),(2174,'\0','3155405','Rio Novo','0',0,1,11),(2175,'\0','3155900','Rio Preto','0',0,1,11),(2176,'\0','3156205','Rochedo de Minas','0',0,1,11),(2177,'\0','3157278','Santa Bárbara do Monte Verde','0',0,1,11),(2178,'\0','3158607','Santana do Deserto','0',0,1,11),(2179,'\0','3159308','Santa Rita de Jacutinga','0',0,1,11),(2180,'\0','3159407','Santa Rita de Ibitipoca','0',0,1,11),(2181,'\0','3160702','Santos Dumont','0',0,1,11),(2182,'\0','3162906','São João Nepomuceno','0',0,1,11),(2183,'\0','3165602','Senador Cortes','0',0,1,11),(2184,'\0','3167509','Simão Pereira','0',0,1,11),(2185,'\0','3101508','Além Paraíba','0',0,1,11),(2186,'\0','3104403','Argirita','0',0,1,11),(2187,'\0','3115300','Cataguases','0',0,1,11),(2188,'\0','3122900','Dona Eusébia','0',0,1,11),(2189,'\0','3124609','Estrela Dalva','0',0,1,11),(2190,'\0','3132602','Itamarati de Minas','0',0,1,11),(2191,'\0','3138005','Laranjal','0',0,1,11),(2192,'\0','3138401','Leopoldina','0',0,1,11),(2193,'\0','3146701','Palma','0',0,1,11),(2194,'\0','3151107','Pirapetinga','0',0,1,11),(2195,'\0','3154101','Recreio','0',0,1,11),(2196,'\0','3158409','Santana de Cataguases','0',0,1,11),(2197,'\0','3160009','Santo Antônio do Aventureiro','0',0,1,11),(2198,'\0','3172103','Volta Grande','0',0,1,11),(2199,'\0','5003207','Corumbá','0',0,1,12),(2200,'\0','5005202','Ladário','0',0,1,12),(2201,'\0','5006903','Porto Murtinho','0',0,1,12),(2202,'\0','5000708','Anastácio','0',0,1,12),(2203,'\0','5001102','Aquidauana','0',0,1,12),(2204,'\0','5003488','Dois Irmãos do Buriti','0',0,1,12),(2205,'\0','5005608','Miranda','0',0,1,12),(2206,'\0','5000252','Alcinópolis','0',0,1,12),(2207,'\0','5002605','Camapuã','0',0,1,12),(2208,'\0','5003306','Coxim','0',0,1,12),(2209,'\0','5003900','Figueirão','0',0,1,12),(2210,'\0','5006408','Pedro Gomes','0',0,1,12),(2211,'\0','5007406','Rio Verde de Mato Grosso','0',0,1,12),(2212,'\0','5007695','São Gabriel do Oeste','0',0,1,12),(2213,'\0','5007935','Sonora','0',0,1,12),(2214,'\0','5001508','Bandeirantes','0',0,1,12),(2215,'\0','5002704','Campo Grande','0',0,1,12),(2216,'\0','5003108','Corguinho','0',0,1,12),(2217,'\0','5004908','Jaraguari','0',0,1,12),(2218,'\0','5007307','Rio Negro','0',0,1,12),(2219,'\0','5007505','Rochedo','0',0,1,12),(2220,'\0','5007901','Sidrolândia','0',0,1,12),(2221,'\0','5008008','Terenos','0',0,1,12),(2222,'\0','5002902','Cassilândia','0',0,1,12),(2223,'\0','5002951','Chapadão do Sul','0',0,1,12),(2224,'\0','5003256','Costa Rica','0',0,1,12),(2225,'\0','5001003','Aparecida do Taboado','0',0,1,12),(2226,'\0','5004403','Inocência','0',0,1,12),(2227,'\0','5006309','Paranaíba','0',0,1,12),(2228,'\0','5007802','Selvíria','0',0,1,12),(2229,'\0','5000203','Água Clara','0',0,1,12),(2230,'\0','5002308','Brasilândia','0',0,1,12),(2231,'\0','5007109','Ribas do Rio Pardo','0',0,1,12),(2232,'\0','5007554','Santa Rita do Pardo','0',0,1,12),(2233,'\0','5008305','Três Lagoas','0',0,1,12),(2234,'\0','5000807','Anaurilândia','0',0,1,12),(2235,'\0','5001904','Bataguassu','0',0,1,12),(2236,'\0','5002001','Batayporã','0',0,1,12),(2237,'\0','5006200','Nova Andradina','0',0,1,12),(2238,'\0','5007976','Taquarussu','0',0,1,12),(2239,'\0','5002100','Bela Vista','0',0,1,12),(2240,'\0','5002159','Bodoquena','0',0,1,12),(2241,'\0','5002209','Bonito','0',0,1,12),(2242,'\0','5002803','Caracol','0',0,1,12),(2243,'\0','5004106','Guia Lopes da Laguna','0',0,1,12),(2244,'\0','5005004','Jardim','0',0,1,12),(2245,'\0','5005806','Nioaque','0',0,1,12),(2246,'\0','5000609','Amambaí','0',0,1,12),(2247,'\0','5000906','Antônio João','0',0,1,12),(2248,'\0','5001243','Aral Moreira','0',0,1,12),(2249,'\0','5002407','Caarapó','0',0,1,12),(2250,'\0','5003504','Douradina','0',0,1,12),(2251,'\0','5003702','Dourados','0',0,1,12),(2252,'\0','5003801','Fátima do Sul','0',0,1,12),(2253,'\0','5004502','Itaporã','0',0,1,12),(2254,'\0','5005152','Juti','0',0,1,12),(2255,'\0','5005251','Laguna Carapã','0',0,1,12),(2256,'\0','5005400','Maracaju','0',0,1,12),(2257,'\0','5006002','Nova Alvorada do Sul','0',0,1,12),(2258,'\0','5006606','Ponta Porã','0',0,1,12),(2259,'\0','5007208','Rio Brilhante','0',0,1,12),(2260,'\0','5008404','Vicentina','0',0,1,12),(2261,'\0','5000856','Angélica','0',0,1,12),(2262,'\0','5003157','Coronel Sapucaia','0',0,1,12),(2263,'\0','5003454','Deodápolis','0',0,1,12),(2264,'\0','5003751','Eldorado','0',0,1,12),(2265,'\0','5004007','Glória de Dourados','0',0,1,12),(2266,'\0','5004304','Iguatemi','0',0,1,12),(2267,'\0','5004601','Itaquiraí','0',0,1,12),(2268,'\0','5004700','Ivinhema','0',0,1,12),(2269,'\0','5004809','Japorã','0',0,1,12),(2270,'\0','5005103','Jateí','0',0,1,12),(2271,'\0','5005681','Mundo Novo','0',0,1,12),(2272,'\0','5005707','Naviraí','0',0,1,12),(2273,'\0','5006259','Novo Horizonte do Sul','0',0,1,12),(2274,'\0','5006358','Paranhos','0',0,1,12),(2275,'\0','5007703','Sete Quedas','0',0,1,12),(2276,'\0','5007950','Tacuru','0',0,1,12),(2277,'\0','5101407','Aripuanã','0',0,1,13),(2278,'\0','5101902','Brasnorte','0',0,1,13),(2279,'\0','5102850','Castanheira','0',0,1,13),(2280,'\0','5103254','Colniza','0',0,1,13),(2281,'\0','5103379','Cotriguaçu','0',0,1,13),(2282,'\0','5105150','Juína','0',0,1,13),(2283,'\0','5105176','Juruena','0',0,1,13),(2284,'\0','5107578','Rondolândia','0',0,1,13),(2285,'\0','5100250','Alta Floresta','0',0,1,13),(2286,'\0','5100805','Apiacás','0',0,1,13),(2287,'\0','5102793','Carlinda','0',0,1,13),(2288,'\0','5106158','Nova Bandeirantes','0',0,1,13),(2289,'\0','5106299','Paranaíta','0',0,1,13),(2290,'\0','5108956','Nova Monte Verde','0',0,1,13),(2291,'\0','5103205','Colíder','0',0,1,13),(2292,'\0','5104104','Guarantã do Norte','0',0,1,13),(2293,'\0','5105606','Matupá','0',0,1,13),(2294,'\0','5106216','Nova Canaã do Norte','0',0,1,13),(2295,'\0','5106265','Novo Mundo','0',0,1,13),(2296,'\0','5106422','Peixoto de Azevedo','0',0,1,13),(2297,'\0','5108055','Terra Nova do Norte','0',0,1,13),(2298,'\0','5108808','Nova Guarita','0',0,1,13),(2299,'\0','5102637','Campo Novo do Parecis','0',0,1,13),(2300,'\0','5102686','Campos de Júlio','0',0,1,13),(2301,'\0','5103304','Comodoro','0',0,1,13),(2302,'\0','5103502','Diamantino','0',0,1,13),(2303,'\0','5107875','Sapezal','0',0,1,13),(2304,'\0','5105101','Juara','0',0,1,13),(2305,'\0','5106273','Novo Horizonte do Norte','0',0,1,13),(2306,'\0','5106802','Porto dos Gaúchos','0',0,1,13),(2307,'\0','5107305','São José do Rio Claro','0',0,1,13),(2308,'\0','5107941','Tabaporã','0',0,1,13),(2309,'\0','5108907','Nova Maringá','0',0,1,13),(2310,'\0','5104526','Ipiranga do Norte','0',0,1,13),(2311,'\0','5104542','Itanhangá','0',0,1,13),(2312,'\0','5105259','Lucas do Rio Verde','0',0,1,13),(2313,'\0','5105903','Nobres','0',0,1,13),(2314,'\0','5106224','Nova Mutum','0',0,1,13),(2315,'\0','5106240','Nova Ubiratã','0',0,1,13),(2316,'\0','5107768','Santa Rita do Trivelato','0',0,1,13),(2317,'\0','5107925','Sorriso','0',0,1,13),(2318,'\0','5108006','Tapurah','0',0,1,13),(2319,'\0','5103056','Cláudia','0',0,1,13),(2320,'\0','5103700','Feliz Natal','0',0,1,13),(2321,'\0','5104559','Itaúba','0',0,1,13),(2322,'\0','5105580','Marcelândia','0',0,1,13),(2323,'\0','5106190','Nova Santa Helena','0',0,1,13),(2324,'\0','5107248','Santa Carmem','0',0,1,13),(2325,'\0','5107909','Sinop','0',0,1,13),(2326,'\0','5108303','União do Sul','0',0,1,13),(2327,'\0','5108501','Vera','0',0,1,13),(2328,'\0','5103858','Gaúcha do Norte','0',0,1,13),(2329,'\0','5106208','Nova Brasilândia','0',0,1,13),(2330,'\0','5106307','Paranatinga','0',0,1,13),(2331,'\0','5106455','Planalto da Serra','0',0,1,13),(2332,'\0','5100359','Alto Boa Vista','0',0,1,13),(2333,'\0','5101852','Bom Jesus do Araguaia','0',0,1,13),(2334,'\0','5102694','Canabrava do Norte','0',0,1,13),(2335,'\0','5103353','Confresa','0',0,1,13),(2336,'\0','5105309','Luciára','0',0,1,13),(2337,'\0','5106315','Novo Santo Antônio','0',0,1,13),(2338,'\0','5106778','Porto Alegre do Norte','0',0,1,13),(2339,'\0','5107180','Ribeirão Cascalheira','0',0,1,13),(2340,'\0','5107354','São José do Xingu','0',0,1,13),(2341,'\0','5107743','Santa Cruz do Xingu','0',0,1,13),(2342,'\0','5107776','Santa Terezinha','0',0,1,13),(2343,'\0','5107859','São Félix do Araguaia','0',0,1,13),(2344,'\0','5107883','Serra Nova Dourada','0',0,1,13),(2345,'\0','5108600','Vila Rica','0',0,1,13),(2346,'\0','5100201','Água Boa','0',0,1,13),(2347,'\0','5102603','Campinápolis','0',0,1,13),(2348,'\0','5102702','Canarana','0',0,1,13),(2349,'\0','5106174','Nova Nazaré','0',0,1,13),(2350,'\0','5106257','Nova Xavantina','0',0,1,13),(2351,'\0','5106281','Novo São Joaquim','0',0,1,13),(2352,'\0','5107065','Querência','0',0,1,13),(2353,'\0','5107792','Santo Antônio do Leste','0',0,1,13),(2354,'\0','5101001','Araguaiana','0',0,1,13),(2355,'\0','5101803','Barra do Garças','0',0,1,13),(2356,'\0','5103106','Cocalinho','0',0,1,13),(2357,'\0','5103361','Conquista D\'Oeste','0',0,1,13),(2358,'\0','5105507','Vila Bela da Santíssima Trindade','0',0,1,13),(2359,'\0','5106182','Nova Lacerda','0',0,1,13),(2360,'\0','5106752','Pontes e Lacerda','0',0,1,13),(2361,'\0','5108352','Vale de São Domingos','0',0,1,13),(2362,'\0','5101704','Barra do Bugres','0',0,1,13),(2363,'\0','5103452','Denise','0',0,1,13),(2364,'\0','5106232','Nova Olímpia','0',0,1,13),(2365,'\0','5106851','Porto Estrela','0',0,1,13),(2366,'\0','5107958','Tangará da Serra','0',0,1,13),(2367,'\0','5101258','Araputanga','0',0,1,13),(2368,'\0','5103809','Figueirópolis D\'Oeste','0',0,1,13),(2369,'\0','5103957','Glória D\'Oeste','0',0,1,13),(2370,'\0','5104500','Indiavaí','0',0,1,13),(2371,'\0','5105002','Jauru','0',0,1,13),(2372,'\0','5105234','Lambari D\'Oeste','0',0,1,13),(2373,'\0','5105622','Mirassol d\'Oeste','0',0,1,13),(2374,'\0','5106828','Porto Esperidião','0',0,1,13),(2375,'\0','5107107','São José dos Quatro Marcos','0',0,1,13),(2376,'\0','5107156','Reserva do Cabaçal','0',0,1,13),(2377,'\0','5107206','Rio Branco','0',0,1,13),(2378,'\0','5107750','Salto do Céu','0',0,1,13),(2379,'\0','5100508','Alto Paraguai','0',0,1,13),(2380,'\0','5101308','Arenápolis','0',0,1,13),(2381,'\0','5106000','Nortelândia','0',0,1,13),(2382,'\0','5107263','Santo Afonso','0',0,1,13),(2383,'\0','5108857','Nova Marilândia','0',0,1,13),(2384,'\0','5100102','Acorizal','0',0,1,13),(2385,'\0','5104906','Jangada','0',0,1,13),(2386,'\0','5107701','Rosário Oeste','0',0,1,13),(2387,'\0','5103007','Chapada dos Guimarães','0',0,1,13),(2388,'\0','5103403','Cuiabá','0',0,1,13),(2389,'\0','5106109','Nossa Senhora do Livramento','0',0,1,13),(2390,'\0','5107800','Santo Antônio do Leverger','0',0,1,13),(2391,'\0','5108402','Várzea Grande','0',0,1,13),(2392,'\0','5101605','Barão de Melgaço','0',0,1,13),(2393,'\0','5102504','Cáceres','0',0,1,13),(2394,'\0','5103437','Curvelândia','0',0,1,13),(2395,'\0','5106505','Poconé','0',0,1,13),(2396,'\0','5102678','Campo Verde','0',0,1,13),(2397,'\0','5107040','Primavera do Leste','0',0,1,13),(2398,'\0','5101209','Araguainha','0',0,1,13),(2399,'\0','5103908','General Carneiro','0',0,1,13),(2400,'\0','5104203','Guiratinga','0',0,1,13),(2401,'\0','5106653','Pontal do Araguaia','0',0,1,13),(2402,'\0','5106703','Ponte Branca','0',0,1,13),(2403,'\0','5107008','Poxoréo','0',0,1,13),(2404,'\0','5107198','Ribeirãozinho','0',0,1,13),(2405,'\0','5108105','Tesouro','0',0,1,13),(2406,'\0','5108204','Torixoréu','0',0,1,13),(2407,'\0','5103601','Dom Aquino','0',0,1,13),(2408,'\0','5104609','Itiquira','0',0,1,13),(2409,'\0','5104807','Jaciara','0',0,1,13),(2410,'\0','5105200','Juscimeira','0',0,1,13),(2411,'\0','5106372','Pedra Preta','0',0,1,13),(2412,'\0','5107297','São José do Povo','0',0,1,13),(2413,'\0','5107404','São Pedro da Cipa','0',0,1,13),(2414,'\0','5107602','Rondonópolis','0',0,1,13),(2415,'\0','5100300','Alto Araguaia','0',0,1,13),(2416,'\0','5100409','Alto Garças','0',0,1,13),(2417,'\0','5100607','Alto Taquari','0',0,1,13),(2418,'\0','1503002','Faro','0',0,1,14),(2419,'\0','1503903','Juruti','0',0,1,14),(2420,'\0','1505106','Óbidos','0',0,1,14),(2421,'\0','1505304','Oriximiná','0',0,1,14),(2422,'\0','1507979','Terra Santa','0',0,1,14),(2423,'\0','1500404','Alenquer','0',0,1,14),(2424,'\0','1501451','Belterra','0',0,1,14),(2425,'\0','1502855','Curuá','0',0,1,14),(2426,'\0','1504802','Monte Alegre','0',0,1,14),(2427,'\0','1505650','Placas','0',0,1,14),(2428,'\0','1506005','Prainha','0',0,1,14),(2429,'\0','1506807','Santarém','0',0,1,14),(2430,'\0','1500503','Almeirim','0',0,1,14),(2431,'\0','1505908','Porto de Moz','0',0,1,14),(2432,'\0','1501105','Bagre','0',0,1,14),(2433,'\0','1503101','Gurupá','0',0,1,14),(2434,'\0','1504505','Melgaço','0',0,1,14),(2435,'\0','1505809','Portel','0',0,1,14),(2436,'\0','1500305','Afuá','0',0,1,14),(2437,'\0','1500701','Anajás','0',0,1,14),(2438,'\0','1501808','Breves','0',0,1,14),(2439,'\0','1502806','Curralinho','0',0,1,14),(2440,'\0','1507706','São Sebastião da Boa Vista','0',0,1,14),(2441,'\0','1502004','Cachoeira do Arari','0',0,1,14),(2442,'\0','1502509','Chaves','0',0,1,14),(2443,'\0','1504901','Muaná','0',0,1,14),(2444,'\0','1505700','Ponta de Pedras','0',0,1,14),(2445,'\0','1506302','Salvaterra','0',0,1,14),(2446,'\0','1506401','Santa Cruz do Arari','0',0,1,14),(2447,'\0','1507904','Soure','0',0,1,14),(2448,'\0','1500800','Ananindeua','0',0,1,14),(2449,'\0','1501303','Barcarena','0',0,1,14),(2450,'\0','1501402','Belém','0',0,1,14),(2451,'\0','1501501','Benevides','0',0,1,14),(2452,'\0','1504422','Marituba','0',0,1,14),(2453,'\0','1506351','Santa Bárbara do Pará','0',0,1,14),(2454,'\0','1501907','Bujaru','0',0,1,14),(2455,'\0','1502400','Castanhal','0',0,1,14),(2456,'\0','1503408','Inhangapi','0',0,1,14),(2457,'\0','1506500','Santa Isabel do Pará','0',0,1,14),(2458,'\0','1507003','Santo Antônio do Tauá','0',0,1,14),(2459,'\0','1502608','Colares','0',0,1,14),(2460,'\0','1502905','Curuçá','0',0,1,14),(2461,'\0','1504109','Magalhães Barata','0',0,1,14),(2462,'\0','1504307','Maracanã','0',0,1,14),(2463,'\0','1504406','Marapanim','0',0,1,14),(2464,'\0','1506203','Salinópolis','0',0,1,14),(2465,'\0','1507102','São Caetano de Odivelas','0',0,1,14),(2466,'\0','1507466','São João da Ponta','0',0,1,14),(2467,'\0','1507474','São João de Pirabas','0',0,1,14),(2468,'\0','1507961','Terra Alta','0',0,1,14),(2469,'\0','1508209','Vigia','0',0,1,14),(2470,'\0','1500909','Augusto Corrêa','0',0,1,14),(2471,'\0','1501600','Bonito','0',0,1,14),(2472,'\0','1501709','Bragança','0',0,1,14),(2473,'\0','1502202','Capanema','0',0,1,14),(2474,'\0','1503200','Igarapé-Açu','0',0,1,14),(2475,'\0','1505007','Nova Timboteua','0',0,1,14),(2476,'\0','1505601','Peixe-Boi','0',0,1,14),(2477,'\0','1506104','Primavera','0',0,1,14),(2478,'\0','1506112','Quatipuru','0',0,1,14),(2479,'\0','1506609','Santa Maria do Pará','0',0,1,14),(2480,'\0','1506906','Santarém Novo','0',0,1,14),(2481,'\0','1507409','São Francisco do Pará','0',0,1,14),(2482,'\0','1508035','Tracuateua','0',0,1,14),(2483,'\0','1500107','Abaetetuba','0',0,1,14),(2484,'\0','1501204','Baião','0',0,1,14),(2485,'\0','1502103','Cametá','0',0,1,14),(2486,'\0','1503309','Igarapé-Miri','0',0,1,14),(2487,'\0','1504000','Limoeiro do Ajuru','0',0,1,14),(2488,'\0','1504604','Mocajuba','0',0,1,14),(2489,'\0','1505205','Oeiras do Pará','0',0,1,14),(2490,'\0','1500206','Acará','0',0,1,14),(2491,'\0','1502756','Concórdia do Pará','0',0,1,14),(2492,'\0','1504703','Moju','0',0,1,14),(2493,'\0','1507953','Tailândia','0',0,1,14),(2494,'\0','1508001','Tomé-Açu','0',0,1,14),(2495,'\0','1500958','Aurora do Pará','0',0,1,14),(2496,'\0','1501956','Cachoeira do Piriá','0',0,1,14),(2497,'\0','1502301','Capitão Poço','0',0,1,14),(2498,'\0','1503077','Garrafão do Norte','0',0,1,14),(2499,'\0','1503457','Ipixuna do Pará','0',0,1,14),(2500,'\0','1503507','Irituia','0',0,1,14),(2501,'\0','1504059','Mãe do Rio','0',0,1,14),(2502,'\0','1504950','Nova Esperança do Piriá','0',0,1,14),(2503,'\0','1505403','Ourém','0',0,1,14),(2504,'\0','1506559','Santa Luzia do Pará','0',0,1,14),(2505,'\0','1507201','São Domingos do Capim','0',0,1,14),(2506,'\0','1507607','São Miguel do Guamá','0',0,1,14),(2507,'\0','1508308','Viseu','0',0,1,14),(2508,'\0','1501006','Aveiro','0',0,1,14),(2509,'\0','1503606','Itaituba','0',0,1,14),(2510,'\0','1503754','Jacareacanga','0',0,1,14),(2511,'\0','1505031','Novo Progresso','0',0,1,14),(2512,'\0','1506195','Rurópolis','0',0,1,14),(2513,'\0','1508050','Trairão','0',0,1,14),(2514,'\0','1500602','Altamira','0',0,1,14),(2515,'\0','1500859','Anapu','0',0,1,14),(2516,'\0','1501725','Brasil Novo','0',0,1,14),(2517,'\0','1504455','Medicilândia','0',0,1,14),(2518,'\0','1505486','Pacajá','0',0,1,14),(2519,'\0','1507805','Senador José Porfírio','0',0,1,14),(2520,'\0','1508159','Uruará','0',0,1,14),(2521,'\0','1508357','Vitória do Xingu','0',0,1,14),(2522,'\0','1501782','Breu Branco','0',0,1,14),(2523,'\0','1503705','Itupiranga','0',0,1,14),(2524,'\0','1503804','Jacundá','0',0,1,14),(2525,'\0','1504976','Nova Ipixuna','0',0,1,14),(2526,'\0','1505064','Novo Repartimento','0',0,1,14),(2527,'\0','1508100','Tucuruí','0',0,1,14),(2528,'\0','1500131','Abel Figueiredo','0',0,1,14),(2529,'\0','1501576','Bom Jesus do Tocantins','0',0,1,14),(2530,'\0','1502939','Dom Eliseu','0',0,1,14),(2531,'\0','1503093','Goianésia do Pará','0',0,1,14),(2532,'\0','1505502','Paragominas','0',0,1,14),(2533,'\0','1506187','Rondon do Pará','0',0,1,14),(2534,'\0','1508126','Ulianópolis','0',0,1,14),(2535,'\0','1501253','Bannach','0',0,1,14),(2536,'\0','1502764','Cumaru do Norte','0',0,1,14),(2537,'\0','1505437','Ourilândia do Norte','0',0,1,14),(2538,'\0','1507300','São Félix do Xingu','0',0,1,14),(2539,'\0','1508084','Tucumã','0',0,1,14),(2540,'\0','1500347','Água Azul do Norte','0',0,1,14),(2541,'\0','1502152','Canaã dos Carajás','0',0,1,14),(2542,'\0','1502772','Curionópolis','0',0,1,14),(2543,'\0','1502954','Eldorado dos Carajás','0',0,1,14),(2544,'\0','1505536','Parauapebas','0',0,1,14),(2545,'\0','1501758','Brejo Grande do Araguaia','0',0,1,14),(2546,'\0','1504208','Marabá','0',0,1,14),(2547,'\0','1505494','Palestina do Pará','0',0,1,14),(2548,'\0','1507151','São Domingos do Araguaia','0',0,1,14),(2549,'\0','1507508','São João do Araguaia','0',0,1,14),(2550,'\0','1505551','Pau D\'Arco','0',0,1,14),(2551,'\0','1505635','Piçarra','0',0,1,14),(2552,'\0','1506138','Redenção','0',0,1,14),(2553,'\0','1506161','Rio Maria','0',0,1,14),(2554,'\0','1507458','São Geraldo do Araguaia','0',0,1,14),(2555,'\0','1507755','Sapucaia','0',0,1,14),(2556,'\0','1508407','Xinguara','0',0,1,14),(2557,'\0','1502707','Conceição do Araguaia','0',0,1,14),(2558,'\0','1503044','Floresta do Araguaia','0',0,1,14),(2559,'\0','1506583','Santa Maria das Barreiras','0',0,1,14),(2560,'\0','1506708','Santana do Araguaia','0',0,1,14),(2561,'\0','2502003','Belém do Brejo do Cruz','0',0,1,15),(2562,'\0','2502300','Bom Sucesso','0',0,1,15),(2563,'\0','2502805','Brejo do Cruz','0',0,1,15),(2564,'\0','2502904','Brejo dos Santos','0',0,1,15),(2565,'\0','2504306','Catolé do Rocha','0',0,1,15),(2566,'\0','2507408','Jericó','0',0,1,15),(2567,'\0','2508109','Lagoa','0',0,1,15),(2568,'\0','2509370','Mato Grosso','0',0,1,15),(2569,'\0','2512804','Riacho dos Cavalos','0',0,1,15),(2570,'\0','2513901','São Bento','0',0,1,15),(2571,'\0','2514651','São José do Brejo do Cruz','0',0,1,15),(2572,'\0','2500700','São João do Rio do Peixe','0',0,1,15),(2573,'\0','2502052','Bernardino Batista','0',0,1,15),(2574,'\0','2502201','Bom Jesus','0',0,1,15),(2575,'\0','2502409','Bonito de Santa Fé','0',0,1,15),(2576,'\0','2503308','Cachoeira dos Índios','0',0,1,15),(2577,'\0','2503704','Cajazeiras','0',0,1,15),(2578,'\0','2504108','Carrapateira','0',0,1,15),(2579,'\0','2509602','Monte Horebe','0',0,1,15),(2580,'\0','2512036','Poço Dantas','0',0,1,15),(2581,'\0','2512077','Poço de José de Moura','0',0,1,15),(2582,'\0','2513307','Santa Helena','0',0,1,15),(2583,'\0','2513653','Santarém','0',0,1,15),(2584,'\0','2514503','São José de Piranhas','0',0,1,15),(2585,'\0','2516805','Triunfo','0',0,1,15),(2586,'\0','2516904','Uiraúna','0',0,1,15),(2587,'\0','2500775','Aparecida','0',0,1,15),(2588,'\0','2503753','Cajazeirinhas','0',0,1,15),(2589,'\0','2504504','Condado','0',0,1,15),(2590,'\0','2505501','Vista Serrana','0',0,1,15),(2591,'\0','2508406','Lastro','0',0,1,15),(2592,'\0','2508802','Malta','0',0,1,15),(2593,'\0','2509156','Marizópolis','0',0,1,15),(2594,'\0','2510006','Nazarezinho','0',0,1,15),(2595,'\0','2510907','Paulista','0',0,1,15),(2596,'\0','2512101','Pombal','0',0,1,15),(2597,'\0','2513208','Santa Cruz','0',0,1,15),(2598,'\0','2513927','São Bentinho','0',0,1,15),(2599,'\0','2513968','São Domingos de Pombal','0',0,1,15),(2600,'\0','2513984','São Francisco','0',0,1,15),(2601,'\0','2514206','São José da Lagoa Tapada','0',0,1,15),(2602,'\0','2516201','Sousa','0',0,1,15),(2603,'\0','2517209','Vieirópolis','0',0,1,15),(2604,'\0','2501153','Areia de Baraúnas','0',0,1,15),(2605,'\0','2503407','Cacimba de Areia','0',0,1,15),(2606,'\0','2508703','Mãe d\'Água','0',0,1,15),(2607,'\0','2510709','Passagem','0',0,1,15),(2608,'\0','2510808','Patos','0',0,1,15),(2609,'\0','2512606','Quixabá','0',0,1,15),(2610,'\0','2513802','Santa Teresinha','0',0,1,15),(2611,'\0','2514404','São José de Espinharas','0',0,1,15),(2612,'\0','2514602','São José do Bonfim','0',0,1,15),(2613,'\0','2500205','Aguiar','0',0,1,15),(2614,'\0','2502607','Igaracy','0',0,1,15),(2615,'\0','2504207','Catingueira','0',0,1,15),(2616,'\0','2504801','Coremas','0',0,1,15),(2617,'\0','2505907','Emas','0',0,1,15),(2618,'\0','2510204','Nova Olinda','0',0,1,15),(2619,'\0','2510402','Olho d\'Água','0',0,1,15),(2620,'\0','2511301','Piancó','0',0,1,15),(2621,'\0','2513604','Santana dos Garrotes','0',0,1,15),(2622,'\0','2502102','Boa Ventura','0',0,1,15),(2623,'\0','2504405','Conceição','0',0,1,15),(2624,'\0','2505303','Curral Velho','0',0,1,15),(2625,'\0','2505600','Diamante','0',0,1,15),(2626,'\0','2506608','Ibiara','0',0,1,15),(2627,'\0','2507002','Itaporanga','0',0,1,15),(2628,'\0','2511004','Pedra Branca','0',0,1,15),(2629,'\0','2513356','Santa Inês','0',0,1,15),(2630,'\0','2513505','Santana de Mangueira','0',0,1,15),(2631,'\0','2514305','São José de Caiana','0',0,1,15),(2632,'\0','2515708','Serra Grande','0',0,1,15),(2633,'\0','2500106','Água Branca','0',0,1,15),(2634,'\0','2503555','Cacimbas','0',0,1,15),(2635,'\0','2505402','Desterro','0',0,1,15),(2636,'\0','2506707','Imaculada','0',0,1,15),(2637,'\0','2508000','Juru','0',0,1,15),(2638,'\0','2509008','Manaíra','0',0,1,15),(2639,'\0','2509396','Maturéia','0',0,1,15),(2640,'\0','2512309','Princesa Isabel','0',0,1,15),(2641,'\0','2514552','São José de Princesa','0',0,1,15),(2642,'\0','2516607','Tavares','0',0,1,15),(2643,'\0','2516706','Teixeira','0',0,1,15),(2644,'\0','2507804','Junco do Seridó','0',0,1,15),(2645,'\0','2513000','Salgadinho','0',0,1,15),(2646,'\0','2513406','Santa Luzia','0',0,1,15),(2647,'\0','2514701','São José do Sabugi','0',0,1,15),(2648,'\0','2514909','São Mamede','0',0,1,15),(2649,'\0','2517100','Várzea','0',0,1,15),(2650,'\0','2501534','Baraúna','0',0,1,15),(2651,'\0','2505006','Cubati','0',0,1,15),(2652,'\0','2506202','Frei Martinho','0',0,1,15),(2653,'\0','2507705','Juazeirinho','0',0,1,15),(2654,'\0','2510303','Nova Palmeira','0',0,1,15),(2655,'\0','2511103','Pedra Lavrada','0',0,1,15),(2656,'\0','2511400','Picuí','0',0,1,15),(2657,'\0','2515401','Seridó','0',0,1,15),(2658,'\0','2516755','Tenório','0',0,1,15),(2659,'\0','2500734','Amparo','0',0,1,15),(2660,'\0','2501351','Assunção','0',0,1,15),(2661,'\0','2503902','Camalaú','0',0,1,15),(2662,'\0','2504702','Congo','0',0,1,15),(2663,'\0','2504850','Coxixola','0',0,1,15),(2664,'\0','2508505','Livramento','0',0,1,15),(2665,'\0','2509701','Monteiro','0',0,1,15),(2666,'\0','2510600','Ouro Velho','0',0,1,15),(2667,'\0','2510659','Parari','0',0,1,15),(2668,'\0','2512200','Prata','0',0,1,15),(2669,'\0','2514107','São João do Tigre','0',0,1,15),(2670,'\0','2514800','São José dos Cordeiros','0',0,1,15),(2671,'\0','2515203','São Sebastião do Umbuzeiro','0',0,1,15),(2672,'\0','2515500','Serra Branca','0',0,1,15),(2673,'\0','2516300','Sumé','0',0,1,15),(2674,'\0','2516508','Taperoá','0',0,1,15),(2675,'\0','2517407','Zabelê','0',0,1,15),(2676,'\0','2500536','Alcantil','0',0,1,15),(2677,'\0','2501575','Barra de Santana','0',0,1,15),(2678,'\0','2501708','Barra de São Miguel','0',0,1,15),(2679,'\0','2502508','Boqueirão','0',0,1,15),(2680,'\0','2503100','Cabaceiras','0',0,1,15),(2681,'\0','2504074','Caraúbas','0',0,1,15),(2682,'\0','2504355','Caturité','0',0,1,15),(2683,'\0','2506509','Gurjão','0',0,1,15),(2684,'\0','2512788','Riacho de Santo Antônio','0',0,1,15),(2685,'\0','2513851','Santo André','0',0,1,15),(2686,'\0','2513943','São Domingos do Cariri','0',0,1,15),(2687,'\0','2514008','São João do Cariri','0',0,1,15),(2688,'\0','2500577','Algodão de Jandaíra','0',0,1,15),(2689,'\0','2500908','Arara','0',0,1,15),(2690,'\0','2501609','Barra de Santa Rosa','0',0,1,15),(2691,'\0','2505105','Cuité','0',0,1,15),(2692,'\0','2505352','Damião','0',0,1,15),(2693,'\0','2510105','Nova Floresta','0',0,1,15),(2694,'\0','2510501','Olivedos','0',0,1,15),(2695,'\0','2512002','Pocinhos','0',0,1,15),(2696,'\0','2512705','Remígio','0',0,1,15),(2697,'\0','2516102','Soledade','0',0,1,15),(2698,'\0','2516151','Sossêgo','0',0,1,15),(2699,'\0','2501005','Araruna','0',0,1,15),(2700,'\0','2503506','Cacimba de Dentro','0',0,1,15),(2701,'\0','2504157','Casserengue','0',0,1,15),(2702,'\0','2505709','Dona Inês','0',0,1,15),(2703,'\0','2512747','Riachão','0',0,1,15),(2704,'\0','2516003','Solânea','0',0,1,15),(2705,'\0','2516409','Campo de Santana','0',0,1,15),(2706,'\0','2501203','Areial','0',0,1,15),(2707,'\0','2506004','Esperança','0',0,1,15),(2708,'\0','2509503','Montadas','0',0,1,15),(2709,'\0','2515104','São Sebastião de Lagoa de Roça','0',0,1,15),(2710,'\0','2500304','Alagoa Grande','0',0,1,15),(2711,'\0','2500403','Alagoa Nova','0',0,1,15),(2712,'\0','2501104','Areia','0',0,1,15),(2713,'\0','2501500','Bananeiras','0',0,1,15),(2714,'\0','2502706','Borborema','0',0,1,15),(2715,'\0','2509339','Matinhas','0',0,1,15),(2716,'\0','2511608','Pilões','0',0,1,15),(2717,'\0','2515906','Serraria','0',0,1,15),(2718,'\0','2500502','Alagoinha','0',0,1,15),(2719,'\0','2500809','Araçagi','0',0,1,15),(2720,'\0','2501906','Belém','0',0,1,15),(2721,'\0','2503605','Caiçara','0',0,1,15),(2722,'\0','2505204','Cuitegi','0',0,1,15),(2723,'\0','2505808','Duas Estradas','0',0,1,15),(2724,'\0','2506301','Guarabira','0',0,1,15),(2725,'\0','2508208','Lagoa de Dentro','0',0,1,15),(2726,'\0','2508554','Logradouro','0',0,1,15),(2727,'\0','2509800','Mulungu','0',0,1,15),(2728,'\0','2511707','Pilõezinhos','0',0,1,15),(2729,'\0','2511806','Pirpirituba','0',0,1,15),(2730,'\0','2515609','Serra da Raiz','0',0,1,15),(2731,'\0','2515930','Sertãozinho','0',0,1,15),(2732,'\0','2502151','Boa Vista','0',0,1,15),(2733,'\0','2504009','Campina Grande','0',0,1,15),(2734,'\0','2506103','Fagundes','0',0,1,15),(2735,'\0','2508307','Lagoa Seca','0',0,1,15),(2736,'\0','2509206','Massaranduba','0',0,1,15),(2737,'\0','2512408','Puxinanã','0',0,1,15),(2738,'\0','2512507','Queimadas','0',0,1,15),(2739,'\0','2515807','Serra Redonda','0',0,1,15),(2740,'\0','2503803','Caldas Brandão','0',0,1,15),(2741,'\0','2506400','Gurinhém','0',0,1,15),(2742,'\0','2506806','Ingá','0',0,1,15),(2743,'\0','2506905','Itabaiana','0',0,1,15),(2744,'\0','2507200','Itatuba','0',0,1,15),(2745,'\0','2507606','Juarez Távora','0',0,1,15),(2746,'\0','2509404','Mogeiro','0',0,1,15),(2747,'\0','2512754','Riachão do Bacamarte','0',0,1,15),(2748,'\0','2513109','Salgado de São Félix','0',0,1,15),(2749,'\0','2501302','Aroeiras','0',0,1,15),(2750,'\0','2506251','Gado Bravo','0',0,1,15),(2751,'\0','2509909','Natuba','0',0,1,15),(2752,'\0','2513158','Santa Cecília','0',0,1,15),(2753,'\0','2517001','Umbuzeiro','0',0,1,15),(2754,'\0','2501401','Baía da Traição','0',0,1,15),(2755,'\0','2504033','Capim','0',0,1,15),(2756,'\0','2505238','Cuité de Mamanguape','0',0,1,15),(2757,'\0','2505279','Curral de Cima','0',0,1,15),(2758,'\0','2507101','Itapororoca','0',0,1,15),(2759,'\0','2507309','Jacaraú','0',0,1,15),(2760,'\0','2508901','Mamanguape','0',0,1,15),(2761,'\0','2509057','Marcação','0',0,1,15),(2762,'\0','2509305','Mataraca','0',0,1,15),(2763,'\0','2512721','Pedro Régis','0',0,1,15),(2764,'\0','2512903','Rio Tinto','0',0,1,15),(2765,'\0','2504900','Cruz do Espírito Santo','0',0,1,15),(2766,'\0','2507903','Juripiranga','0',0,1,15),(2767,'\0','2509107','Mari','0',0,1,15),(2768,'\0','2511509','Pilar','0',0,1,15),(2769,'\0','2512762','Riachão do Poço','0',0,1,15),(2770,'\0','2514453','São José dos Ramos','0',0,1,15),(2771,'\0','2515005','São Miguel de Taipu','0',0,1,15),(2772,'\0','2515302','Sapé','0',0,1,15),(2773,'\0','2515971','Sobrado','0',0,1,15),(2774,'\0','2501807','Bayeux','0',0,1,15),(2775,'\0','2503209','Cabedelo','0',0,1,15),(2776,'\0','2504603','Conde','0',0,1,15),(2777,'\0','2507507','João Pessoa','0',0,1,15),(2778,'\0','2508604','Lucena','0',0,1,15),(2779,'\0','2513703','Santa Rita','0',0,1,15),(2780,'\0','2500601','Alhandra','0',0,1,15),(2781,'\0','2503001','Caaporã','0',0,1,15),(2782,'\0','2511202','Pedras de Fogo','0',0,1,15),(2783,'\0','2511905','Pitimbu','0',0,1,15),(2784,'\0','2601102','Araripina','0',0,1,16),(2785,'\0','2602001','Bodocó','0',0,1,16),(2786,'\0','2605301','Exu','0',0,1,16),(2787,'\0','2606309','Granito','0',0,1,16),(2788,'\0','2607307','Ipubi','0',0,1,16),(2789,'\0','2609907','Ouricuri','0',0,1,16),(2790,'\0','2612455','Santa Cruz','0',0,1,16),(2791,'\0','2612554','Santa Filomena','0',0,1,16),(2792,'\0','2614303','Moreilândia','0',0,1,16),(2793,'\0','2615607','Trindade','0',0,1,16),(2794,'\0','2604304','Cedro','0',0,1,16),(2795,'\0','2609303','Mirandiba','0',0,1,16),(2796,'\0','2610400','Parnamirim','0',0,1,16),(2797,'\0','2612208','Salgueiro','0',0,1,16),(2798,'\0','2613503','São José do Belmonte','0',0,1,16),(2799,'\0','2614006','Serrita','0',0,1,16),(2800,'\0','2616100','Verdejante','0',0,1,16),(2801,'\0','2600104','Afogados da Ingazeira','0',0,1,16),(2802,'\0','2602506','Brejinho','0',0,1,16),(2803,'\0','2603405','Calumbi','0',0,1,16),(2804,'\0','2603900','Carnaíba','0',0,1,16),(2805,'\0','2605608','Flores','0',0,1,16),(2806,'\0','2606903','Iguaraci','0',0,1,16),(2807,'\0','2607109','Ingazeira','0',0,1,16),(2808,'\0','2607703','Itapetim','0',0,1,16),(2809,'\0','2611533','Quixaba','0',0,1,16),(2810,'\0','2612471','Santa Cruz da Baixa Verde','0',0,1,16),(2811,'\0','2612802','Santa Terezinha','0',0,1,16),(2812,'\0','2613602','São José do Egito','0',0,1,16),(2813,'\0','2613909','Serra Talhada','0',0,1,16),(2814,'\0','2614402','Solidão','0',0,1,16),(2815,'\0','2614600','Tabira','0',0,1,16),(2816,'\0','2615706','Triunfo','0',0,1,16),(2817,'\0','2615904','Tuparetama','0',0,1,16),(2818,'\0','2601201','Arcoverde','0',0,1,16),(2819,'\0','2601805','Betânia','0',0,1,16),(2820,'\0','2605103','Custódia','0',0,1,16),(2821,'\0','2606606','Ibimirim','0',0,1,16),(2822,'\0','2607000','Inajá','0',0,1,16),(2823,'\0','2609154','Manari','0',0,1,16),(2824,'\0','2614105','Sertânia','0',0,1,16),(2825,'\0','2600203','Afrânio','0',0,1,16),(2826,'\0','2603009','Cabrobó','0',0,1,16),(2827,'\0','2605152','Dormentes','0',0,1,16),(2828,'\0','2608750','Lagoa Grande','0',0,1,16),(2829,'\0','2609808','Orocó','0',0,1,16),(2830,'\0','2611101','Petrolina','0',0,1,16),(2831,'\0','2612604','Santa Maria da Boa Vista','0',0,1,16),(2832,'\0','2615201','Terra Nova','0',0,1,16),(2833,'\0','2601607','Belém de São Francisco','0',0,1,16),(2834,'\0','2603926','Carnaubeira da Penha','0',0,1,16),(2835,'\0','2605707','Floresta','0',0,1,16),(2836,'\0','2607406','Itacuruba','0',0,1,16),(2837,'\0','2608057','Jatobá','0',0,1,16),(2838,'\0','2611002','Petrolândia','0',0,1,16),(2839,'\0','2614808','Tacaratu','0',0,1,16),(2840,'\0','2600500','Águas Belas','0',0,1,16),(2841,'\0','2602803','Buíque','0',0,1,16),(2842,'\0','2607505','Itaíba','0',0,1,16),(2843,'\0','2610806','Pedra','0',0,1,16),(2844,'\0','2615805','Tupanatinga','0',0,1,16),(2845,'\0','2616001','Venturosa','0',0,1,16),(2846,'\0','2600609','Alagoinha','0',0,1,16),(2847,'\0','2601706','Belo Jardim','0',0,1,16),(2848,'\0','2601904','Bezerros','0',0,1,16),(2849,'\0','2602605','Brejo da Madre de Deus','0',0,1,16),(2850,'\0','2603108','Cachoeirinha','0',0,1,16),(2851,'\0','2603801','Capoeiras','0',0,1,16),(2852,'\0','2604106','Caruaru','0',0,1,16),(2853,'\0','2606408','Gravatá','0',0,1,16),(2854,'\0','2608008','Jataúba','0',0,1,16),(2855,'\0','2610905','Pesqueira','0',0,1,16),(2856,'\0','2611200','Poção','0',0,1,16),(2857,'\0','2611705','Riacho das Almas','0',0,1,16),(2858,'\0','2612406','Sanharó','0',0,1,16),(2859,'\0','2613008','São Bento do Una','0',0,1,16),(2860,'\0','2613107','São Caitano','0',0,1,16),(2861,'\0','2614709','Tacaimbó','0',0,1,16),(2862,'\0','2604155','Casinhas','0',0,1,16),(2863,'\0','2605806','Frei Miguelinho','0',0,1,16),(2864,'\0','2612505','Santa Cruz do Capibaribe','0',0,1,16),(2865,'\0','2612703','Santa Maria do Cambucá','0',0,1,16),(2866,'\0','2614501','Surubim','0',0,1,16),(2867,'\0','2615003','Taquaritinga do Norte','0',0,1,16),(2868,'\0','2615409','Toritama','0',0,1,16),(2869,'\0','2616183','Vertente do Lério','0',0,1,16),(2870,'\0','2616209','Vertentes','0',0,1,16),(2871,'\0','2602209','Bom Jardim','0',0,1,16),(2872,'\0','2604908','Cumaru','0',0,1,16),(2873,'\0','2605400','Feira Nova','0',0,1,16),(2874,'\0','2608107','João Alfredo','0',0,1,16),(2875,'\0','2608909','Limoeiro','0',0,1,16),(2876,'\0','2609105','Machados','0',0,1,16),(2877,'\0','2609709','Orobó','0',0,1,16),(2878,'\0','2610509','Passira','0',0,1,16),(2879,'\0','2612109','Salgadinho','0',0,1,16),(2880,'\0','2613800','São Vicente Ferrer','0',0,1,16),(2881,'\0','2601003','Angelim','0',0,1,16),(2882,'\0','2602100','Bom Conselho','0',0,1,16),(2883,'\0','2602407','Brejão','0',0,1,16),(2884,'\0','2603207','Caetés','0',0,1,16),(2885,'\0','2603306','Calçado','0',0,1,16),(2886,'\0','2603702','Canhotinho','0',0,1,16),(2887,'\0','2604700','Correntes','0',0,1,16),(2888,'\0','2606002','Garanhuns','0',0,1,16),(2889,'\0','2606507','Iati','0',0,1,16),(2890,'\0','2608255','Jucati','0',0,1,16),(2891,'\0','2608305','Jupi','0',0,1,16),(2892,'\0','2608404','Jurema','0',0,1,16),(2893,'\0','2608602','Lagoa do Ouro','0',0,1,16),(2894,'\0','2608800','Lajedo','0',0,1,16),(2895,'\0','2610103','Palmeirina','0',0,1,16),(2896,'\0','2610301','Paranatama','0',0,1,16),(2897,'\0','2612307','Saloá','0',0,1,16),(2898,'\0','2613206','São João','0',0,1,16),(2899,'\0','2615102','Terezinha','0',0,1,16),(2900,'\0','2600302','Agrestina','0',0,1,16),(2901,'\0','2600807','Altinho','0',0,1,16),(2902,'\0','2601300','Barra de Guabiraba','0',0,1,16),(2903,'\0','2602308','Bonito','0',0,1,16),(2904,'\0','2603504','Camocim de São Félix','0',0,1,16),(2905,'\0','2605004','Cupira','0',0,1,16),(2906,'\0','2606705','Ibirajuba','0',0,1,16),(2907,'\0','2608701','Lagoa dos Gatos','0',0,1,16),(2908,'\0','2610202','Panelas','0',0,1,16),(2909,'\0','2612000','Sairé','0',0,1,16),(2910,'\0','2613305','São Joaquim do Monte','0',0,1,16),(2911,'\0','2600708','Aliança','0',0,1,16),(2912,'\0','2602704','Buenos Aires','0',0,1,16),(2913,'\0','2603603','Camutanga','0',0,1,16),(2914,'\0','2604007','Carpina','0',0,1,16),(2915,'\0','2604601','Condado','0',0,1,16),(2916,'\0','2605509','Ferreiros','0',0,1,16),(2917,'\0','2606200','Goiana','0',0,1,16),(2918,'\0','2607653','Itambé','0',0,1,16),(2919,'\0','2607802','Itaquitinga','0',0,1,16),(2920,'\0','2608453','Lagoa do Carro','0',0,1,16),(2921,'\0','2608503','Lagoa do Itaenga','0',0,1,16),(2922,'\0','2609006','Macaparana','0',0,1,16),(2923,'\0','2609501','Nazaré da Mata','0',0,1,16),(2924,'\0','2610608','Paudalho','0',0,1,16),(2925,'\0','2615300','Timbaúba','0',0,1,16),(2926,'\0','2615508','Tracunhaém','0',0,1,16),(2927,'\0','2616308','Vicência','0',0,1,16),(2928,'\0','2604403','Chã de Alegria','0',0,1,16),(2929,'\0','2604502','Chã Grande','0',0,1,16),(2930,'\0','2606101','Glória do Goitá','0',0,1,16),(2931,'\0','2611309','Pombos','0',0,1,16),(2932,'\0','2616407','Vitória de Santo Antão','0',0,1,16),(2933,'\0','2600401','Água Preta','0',0,1,16),(2934,'\0','2600906','Amaraji','0',0,1,16),(2935,'\0','2601409','Barreiros','0',0,1,16),(2936,'\0','2601508','Belém de Maria','0',0,1,16),(2937,'\0','2604205','Catende','0',0,1,16),(2938,'\0','2604809','Cortês','0',0,1,16),(2939,'\0','2605202','Escada','0',0,1,16),(2940,'\0','2605905','Gameleira','0',0,1,16),(2941,'\0','2607950','Jaqueira','0',0,1,16),(2942,'\0','2608206','Joaquim Nabuco','0',0,1,16),(2943,'\0','2609204','Maraial','0',0,1,16),(2944,'\0','2610004','Palmares','0',0,1,16),(2945,'\0','2611408','Primavera','0',0,1,16),(2946,'\0','2611507','Quipapá','0',0,1,16),(2947,'\0','2611804','Ribeirão','0',0,1,16),(2948,'\0','2611903','Rio Formoso','0',0,1,16),(2949,'\0','2612901','São Benedito do Sul','0',0,1,16),(2950,'\0','2613404','São José da Coroa Grande','0',0,1,16),(2951,'\0','2614204','Sirinhaém','0',0,1,16),(2952,'\0','2614857','Tamandaré','0',0,1,16),(2953,'\0','2616506','Xexéu','0',0,1,16),(2954,'\0','2601052','Araçoiaba','0',0,1,16),(2955,'\0','2606804','Igarassu','0',0,1,16),(2956,'\0','2607604','Ilha de Itamaracá','0',0,1,16),(2957,'\0','2607752','Itapissuma','0',0,1,16),(2958,'\0','2600054','Abreu e Lima','0',0,1,16),(2959,'\0','2603454','Camaragibe','0',0,1,16),(2960,'\0','2607901','Jaboatão dos Guararapes','0',0,1,16),(2961,'\0','2609402','Moreno','0',0,1,16),(2962,'\0','2609600','Olinda','0',0,1,16),(2963,'\0','2610707','Paulista','0',0,1,16),(2964,'\0','2611606','Recife','0',0,1,16),(2965,'\0','2613701','São Lourenço da Mata','0',0,1,16),(2966,'\0','2602902','Cabo de Santo Agostinho','0',0,1,16),(2967,'\0','2607208','Ipojuca','0',0,1,16),(2968,'\0','2605459','Fernando de Noronha','0',0,1,16),(2969,'\0','2201200','Barras','0',0,1,17),(2970,'\0','2201507','Batalha','0',0,1,17),(2971,'\0','2201770','Boa Hora','0',0,1,17),(2972,'\0','2201960','Brasileira','0',0,1,17),(2973,'\0','2202059','Cabeceiras do Piauí','0',0,1,17),(2974,'\0','2202174','Campo Largo do Piauí','0',0,1,17),(2975,'\0','2203701','Esperantina','0',0,1,17),(2976,'\0','2205409','Joaquim Pires','0',0,1,17),(2977,'\0','2205458','Joca Marques','0',0,1,17),(2978,'\0','2205805','Luzilândia','0',0,1,17),(2979,'\0','2205854','Madeiro','0',0,1,17),(2980,'\0','2206100','Matias Olímpio','0',0,1,17),(2981,'\0','2206209','Miguel Alves','0',0,1,17),(2982,'\0','2206670','Morro do Chapéu do Piauí','0',0,1,17),(2983,'\0','2206803','Nossa Senhora dos Remédios','0',0,1,17),(2984,'\0','2208403','Piripiri','0',0,1,17),(2985,'\0','2208502','Porto','0',0,1,17),(2986,'\0','2209971','São João do Arraial','0',0,1,17),(2987,'\0','2201919','Bom Princípio do Piauí','0',0,1,17),(2988,'\0','2202000','Buriti dos Lopes','0',0,1,17),(2989,'\0','2202083','Cajueiro da Praia','0',0,1,17),(2990,'\0','2202539','Caraúbas do Piauí','0',0,1,17),(2991,'\0','2202653','Caxingó','0',0,1,17),(2992,'\0','2202703','Cocal','0',0,1,17),(2993,'\0','2202729','Cocal dos Alves','0',0,1,17),(2994,'\0','2204659','Ilha Grande','0',0,1,17),(2995,'\0','2205706','Luís Correia','0',0,1,17),(2996,'\0','2206696','Murici dos Portelas','0',0,1,17),(2997,'\0','2207702','Parnaíba','0',0,1,17),(2998,'\0','2208304','Piracuruca','0',0,1,17),(2999,'\0','2209872','São João da Fronteira','0',0,1,17),(3000,'\0','2210052','São José do Divino','0',0,1,17),(3001,'\0','2200400','Altos','0',0,1,17),(3002,'\0','2201606','Beneditinos','0',0,1,17),(3003,'\0','2202737','Coivaras','0',0,1,17),(3004,'\0','2203255','Curralinhos','0',0,1,17),(3005,'\0','2203305','Demerval Lobão','0',0,1,17),(3006,'\0','2205508','José de Freitas','0',0,1,17),(3007,'\0','2205557','Lagoa Alegre','0',0,1,17),(3008,'\0','2205581','Lagoa do Piauí','0',0,1,17),(3009,'\0','2206308','Miguel Leão','0',0,1,17),(3010,'\0','2206407','Monsenhor Gil','0',0,1,17),(3011,'\0','2207793','Pau D\'Arco do Piauí','0',0,1,17),(3012,'\0','2211001','Teresina','0',0,1,17),(3013,'\0','2211100','União','0',0,1,17),(3014,'\0','2200301','Alto Longá','0',0,1,17),(3015,'\0','2201051','Assunção do Piauí','0',0,1,17),(3016,'\0','2201945','Boqueirão do Piauí','0',0,1,17),(3017,'\0','2202026','Buriti dos Montes','0',0,1,17),(3018,'\0','2202208','Campo Maior','0',0,1,17),(3019,'\0','2202406','Capitão de Campos','0',0,1,17),(3020,'\0','2202604','Castelo do Piauí','0',0,1,17),(3021,'\0','2202711','Cocal de Telha','0',0,1,17),(3022,'\0','2203420','Domingos Mourão','0',0,1,17),(3023,'\0','2205276','Jatobá do Piauí','0',0,1,17),(3024,'\0','2205516','Juazeiro do Piauí','0',0,1,17),(3025,'\0','2205573','Lagoa de São Francisco','0',0,1,17),(3026,'\0','2206357','Milton Brandão','0',0,1,17),(3027,'\0','2206753','Nossa Senhora de Nazaré','0',0,1,17),(3028,'\0','2206951','Novo Santo Antônio','0',0,1,17),(3029,'\0','2207900','Pedro II','0',0,1,17),(3030,'\0','2209906','São João da Serra','0',0,1,17),(3031,'\0','2210409','São Miguel do Tapuio','0',0,1,17),(3032,'\0','2210656','Sigefredo Pacheco','0',0,1,17),(3033,'\0','2200103','Agricolândia','0',0,1,17),(3034,'\0','2200202','Água Branca','0',0,1,17),(3035,'\0','2200509','Amarante','0',0,1,17),(3036,'\0','2200608','Angical do Piauí','0',0,1,17),(3037,'\0','2201002','Arraial','0',0,1,17),(3038,'\0','2201408','Barro Duro','0',0,1,17),(3039,'\0','2204105','Francisco Ayres','0',0,1,17),(3040,'\0','2204600','Hugo Napoleão','0',0,1,17),(3041,'\0','2205250','Jardim do Mulato','0',0,1,17),(3042,'\0','2205540','Lagoinha do Piauí','0',0,1,17),(3043,'\0','2207108','Olho D\'Água do Piauí','0',0,1,17),(3044,'\0','2207504','Palmeirais','0',0,1,17),(3045,'\0','2207751','Passagem Franca do Piauí','0',0,1,17),(3046,'\0','2208809','Regeneração','0',0,1,17),(3047,'\0','2209450','Santo Antônio dos Milagres','0',0,1,17),(3048,'\0','2209807','São Gonçalo do Piauí','0',0,1,17),(3049,'\0','2210508','São Pedro do Piauí','0',0,1,17),(3050,'\0','2200905','Aroazes','0',0,1,17),(3051,'\0','2201176','Barra D\'Alcântara','0',0,1,17),(3052,'\0','2203503','Elesbão Veloso','0',0,1,17),(3053,'\0','2204006','Francinópolis','0',0,1,17),(3054,'\0','2204709','Inhuma','0',0,1,17),(3055,'\0','2205599','Lagoa do Sítio','0',0,1,17),(3056,'\0','2206902','Novo Oriente do Piauí','0',0,1,17),(3057,'\0','2208106','Pimenteiras','0',0,1,17),(3058,'\0','2208601','Prata do Piauí','0',0,1,17),(3059,'\0','2209153','Santa Cruz dos Milagres','0',0,1,17),(3060,'\0','2209609','São Félix do Piauí','0',0,1,17),(3061,'\0','2210383','São Miguel da Baixa Grande','0',0,1,17),(3062,'\0','2211308','Valença do Piauí','0',0,1,17),(3063,'\0','2211407','Várzea Grande','0',0,1,17),(3064,'\0','2201150','Baixa Grande do Ribeiro','0',0,1,17),(3065,'\0','2208908','Ribeiro Gonçalves','0',0,1,17),(3066,'\0','2209203','Santa Filomena','0',0,1,17),(3067,'\0','2211209','Uruçuí','0',0,1,17),(3068,'\0','2200806','Antônio Almeida','0',0,1,17),(3069,'\0','2201705','Bertolínia','0',0,1,17),(3070,'\0','2202752','Colônia do Gurguéia','0',0,1,17),(3071,'\0','2203602','Eliseu Martins','0',0,1,17),(3072,'\0','2205607','Landri Sales','0',0,1,17),(3073,'\0','2205904','Manoel Emídio','0',0,1,17),(3074,'\0','2206001','Marcos Parente','0',0,1,17),(3075,'\0','2208551','Porto Alegre do Piauí','0',0,1,17),(3076,'\0','2210631','Sebastião Leal','0',0,1,17),(3077,'\0','2202251','Canavieira','0',0,1,17),(3078,'\0','2203800','Flores do Piauí','0',0,1,17),(3079,'\0','2203909','Floriano','0',0,1,17),(3080,'\0','2204501','Guadalupe','0',0,1,17),(3081,'\0','2205102','Itaueira','0',0,1,17),(3082,'\0','2205300','Jerumenha','0',0,1,17),(3083,'\0','2206704','Nazaré do Piauí','0',0,1,17),(3084,'\0','2207850','Pavussu','0',0,1,17),(3085,'\0','2209005','Rio Grande do Piauí','0',0,1,17),(3086,'\0','2209708','São Francisco do Piauí','0',0,1,17),(3087,'\0','2210102','São José do Peixe','0',0,1,17),(3088,'\0','2210391','São Miguel do Fidalgo','0',0,1,17),(3089,'\0','2200459','Alvorada do Gurguéia','0',0,1,17),(3090,'\0','2201309','Barreiras do Piauí','0',0,1,17),(3091,'\0','2201903','Bom Jesus','0',0,1,17),(3092,'\0','2203107','Cristino Castro','0',0,1,17),(3093,'\0','2203230','Currais','0',0,1,17),(3094,'\0','2204402','Gilbués','0',0,1,17),(3095,'\0','2206605','Monte Alegre do Piauí','0',0,1,17),(3096,'\0','2207405','Palmeira do Piauí','0',0,1,17),(3097,'\0','2208700','Redenção do Gurguéia','0',0,1,17),(3098,'\0','2209302','Santa Luz','0',0,1,17),(3099,'\0','2209757','São Gonçalo do Gurguéia','0',0,1,17),(3100,'\0','2200707','Anísio de Abreu','0',0,1,17),(3101,'\0','2201929','Bonfim do Piauí','0',0,1,17),(3102,'\0','2201988','Brejo do Piauí','0',0,1,17),(3103,'\0','2202307','Canto do Buriti','0',0,1,17),(3104,'\0','2202505','Caracol','0',0,1,17),(3105,'\0','2202851','Coronel José Dias','0',0,1,17),(3106,'\0','2203354','Dirceu Arcoverde','0',0,1,17),(3107,'\0','2203453','Dom Inocêncio','0',0,1,17),(3108,'\0','2203750','Fartura do Piauí','0',0,1,17),(3109,'\0','2204550','Guaribas','0',0,1,17),(3110,'\0','2205532','Jurema','0',0,1,17),(3111,'\0','2207355','Pajeú do Piauí','0',0,1,17),(3112,'\0','2209559','São Braz do Piauí','0',0,1,17),(3113,'\0','2210359','São Lourenço do Piauí','0',0,1,17),(3114,'\0','2210607','São Raimundo Nonato','0',0,1,17),(3115,'\0','2210953','Tamboril do Piauí','0',0,1,17),(3116,'\0','2211357','Várzea Branca','0',0,1,17),(3117,'\0','2201101','Avelino Lopes','0',0,1,17),(3118,'\0','2202901','Corrente','0',0,1,17),(3119,'\0','2203008','Cristalândia do Piauí','0',0,1,17),(3120,'\0','2203206','Curimatá','0',0,1,17),(3121,'\0','2205524','Júlio Borges','0',0,1,17),(3122,'\0','2206654','Morro Cabeça no Tempo','0',0,1,17),(3123,'\0','2207603','Parnaguá','0',0,1,17),(3124,'\0','2208858','Riacho Frio','0',0,1,17),(3125,'\0','2210623','Sebastião Barros','0',0,1,17),(3126,'\0','2200954','Aroeiras do Itaim','0',0,1,17),(3127,'\0','2201804','Bocaina','0',0,1,17),(3128,'\0','2202075','Cajazeiras do Piauí','0',0,1,17),(3129,'\0','2202778','Colônia do Piauí','0',0,1,17),(3130,'\0','2203404','Dom Expedito Lopes','0',0,1,17),(3131,'\0','2204352','Geminiano','0',0,1,17),(3132,'\0','2204808','Ipiranga do Piauí','0',0,1,17),(3133,'\0','2207009','Oeiras','0',0,1,17),(3134,'\0','2207553','Paquetá','0',0,1,17),(3135,'\0','2208007','Picos','0',0,1,17),(3136,'\0','2209104','Santa Cruz do Piauí','0',0,1,17),(3137,'\0','2209351','Santana do Piauí','0',0,1,17),(3138,'\0','2209377','Santa Rosa do Piauí','0',0,1,17),(3139,'\0','2209856','São João da Canabrava','0',0,1,17),(3140,'\0','2209955','São João da Varjota','0',0,1,17),(3141,'\0','2210201','São José do Piauí','0',0,1,17),(3142,'\0','2210375','São Luis do Piauí','0',0,1,17),(3143,'\0','2210938','Sussuapara','0',0,1,17),(3144,'\0','2210979','Tanque do Piauí','0',0,1,17),(3145,'\0','2211704','Wall Ferraz','0',0,1,17),(3146,'\0','2200251','Alagoinha do Piauí','0',0,1,17),(3147,'\0','2200277','Alegrete do Piauí','0',0,1,17),(3148,'\0','2204204','Francisco Santos','0',0,1,17),(3149,'\0','2206506','Monsenhor Hipólito','0',0,1,17),(3150,'\0','2208205','Pio IX','0',0,1,17),(3151,'\0','2209401','Santo Antônio de Lisboa','0',0,1,17),(3152,'\0','2210300','São Julião','0',0,1,17),(3153,'\0','2200053','Acauã','0',0,1,17),(3154,'\0','2201556','Bela Vista do Piauí','0',0,1,17),(3155,'\0','2201572','Belém do Piauí','0',0,1,17),(3156,'\0','2201739','Betânia do Piauí','0',0,1,17),(3157,'\0','2202091','Caldeirão Grande do Piauí','0',0,1,17),(3158,'\0','2202109','Campinas do Piauí','0',0,1,17),(3159,'\0','2202117','Campo Alegre do Fidalgo','0',0,1,17),(3160,'\0','2202133','Campo Grande do Piauí','0',0,1,17),(3161,'\0','2202455','Capitão Gervásio Oliveira','0',0,1,17),(3162,'\0','2202554','Caridade do Piauí','0',0,1,17),(3163,'\0','2202802','Conceição do Canindé','0',0,1,17),(3164,'\0','2203271','Curral Novo do Piauí','0',0,1,17),(3165,'\0','2203859','Floresta do Piauí','0',0,1,17),(3166,'\0','2204154','Francisco Macedo','0',0,1,17),(3167,'\0','2204303','Fronteiras','0',0,1,17),(3168,'\0','2204907','Isaías Coelho','0',0,1,17),(3169,'\0','2205003','Itainópolis','0',0,1,17),(3170,'\0','2205151','Jacobina do Piauí','0',0,1,17),(3171,'\0','2205201','Jaicós','0',0,1,17),(3172,'\0','2205359','João Costa','0',0,1,17),(3173,'\0','2205565','Lagoa do Barro do Piauí','0',0,1,17),(3174,'\0','2205953','Marcolândia','0',0,1,17),(3175,'\0','2206050','Massapê do Piauí','0',0,1,17),(3176,'\0','2207207','Padre Marcos','0',0,1,17),(3177,'\0','2207306','Paes Landim','0',0,1,17),(3178,'\0','2207777','Patos do Piauí','0',0,1,17),(3179,'\0','2207801','Paulistana','0',0,1,17),(3180,'\0','2207934','Pedro Laurentino','0',0,1,17),(3181,'\0','2207959','Nova Santa Rita','0',0,1,17),(3182,'\0','2208650','Queimada Nova','0',0,1,17),(3183,'\0','2208874','Ribeira do Piauí','0',0,1,17),(3184,'\0','2209500','Santo Inácio do Piauí','0',0,1,17),(3185,'\0','2209658','São Francisco de Assis do Piauí','0',0,1,17),(3186,'\0','2210003','São João do Piauí','0',0,1,17),(3187,'\0','2210706','Simões','0',0,1,17),(3188,'\0','2210805','Simplício Mendes','0',0,1,17),(3189,'\0','2210904','Socorro do Piauí','0',0,1,17),(3190,'\0','2211506','Vera Mendes','0',0,1,17),(3191,'\0','2211605','Vila Nova do Piauí','0',0,1,17),(3192,'\0','4100608','Alto Paraná','0',0,1,18),(3193,'\0','4100905','Amaporã','0',0,1,18),(3194,'\0','4106704','Cruzeiro do Sul','0',0,1,18),(3195,'\0','4107108','Diamante do Norte','0',0,1,18),(3196,'\0','4108908','Guairaçá','0',0,1,18),(3197,'\0','4110300','Inajá','0',0,1,18),(3198,'\0','4111308','Itaúna do Sul','0',0,1,18),(3199,'\0','4112603','Jardim Olinda','0',0,1,18),(3200,'\0','4113502','Loanda','0',0,1,18),(3201,'\0','4115002','Marilena','0',0,1,18),(3202,'\0','4115903','Mirador','0',0,1,18),(3203,'\0','4116505','Nova Aliança do Ivaí','0',0,1,18),(3204,'\0','4117107','Nova Londrina','0',0,1,18),(3205,'\0','4118006','Paraíso do Norte','0',0,1,18),(3206,'\0','4118105','Paranacity','0',0,1,18),(3207,'\0','4118303','Paranapoema','0',0,1,18),(3208,'\0','4118402','Paranavaí','0',0,1,18),(3209,'\0','4119707','Planaltina do Paraná','0',0,1,18),(3210,'\0','4120200','Porto Rico','0',0,1,18),(3211,'\0','4121000','Querência do Norte','0',0,1,18),(3212,'\0','4123303','Santa Cruz de Monte Castelo','0',0,1,18),(3213,'\0','4123709','Santa Isabel do Ivaí','0',0,1,18),(3214,'\0','4123956','Santa Mônica','0',0,1,18),(3215,'\0','4124202','Santo Antônio do Caiuá','0',0,1,18),(3216,'\0','4124608','São Carlos do Ivaí','0',0,1,18),(3217,'\0','4124905','São João do Caiuá','0',0,1,18),(3218,'\0','4125902','São Pedro do Paraná','0',0,1,18),(3219,'\0','4126702','Tamboara','0',0,1,18),(3220,'\0','4127304','Terra Rica','0',0,1,18),(3221,'\0','4100509','Altônia','0',0,1,18),(3222,'\0','4100707','Alto Piquiri','0',0,1,18),(3223,'\0','4103370','Brasilândia do Sul','0',0,1,18),(3224,'\0','4103479','Cafezal do Sul','0',0,1,18),(3225,'\0','4106605','Cruzeiro do Oeste','0',0,1,18),(3226,'\0','4107256','Douradina','0',0,1,18),(3227,'\0','4107520','Esperança Nova','0',0,1,18),(3228,'\0','4108320','Francisco Alves','0',0,1,18),(3229,'\0','4109906','Icaraíma','0',0,1,18),(3230,'\0','4110607','Iporã','0',0,1,18),(3231,'\0','4111555','Ivaté','0',0,1,18),(3232,'\0','4114708','Maria Helena','0',0,1,18),(3233,'\0','4115101','Mariluz','0',0,1,18),(3234,'\0','4117206','Nova Olímpia','0',0,1,18),(3235,'\0','4118857','Perobal','0',0,1,18),(3236,'\0','4118907','Pérola','0',0,1,18),(3237,'\0','4125357','São Jorge do Patrocínio','0',0,1,18),(3238,'\0','4126900','Tapira','0',0,1,18),(3239,'\0','4128104','Umuarama','0',0,1,18),(3240,'\0','4128625','Alto Paraíso','0',0,1,18),(3241,'\0','4128807','Xambrê','0',0,1,18),(3242,'\0','4105508','Cianorte','0',0,1,18),(3243,'\0','4105607','Cidade Gaúcha','0',0,1,18),(3244,'\0','4109104','Guaporema','0',0,1,18),(3245,'\0','4110409','Indianópolis','0',0,1,18),(3246,'\0','4112405','Japurá','0',0,1,18),(3247,'\0','4113007','Jussara','0',0,1,18),(3248,'\0','4122602','Rondon','0',0,1,18),(3249,'\0','4125555','São Manoel do Paraná','0',0,1,18),(3250,'\0','4126108','São Tomé','0',0,1,18),(3251,'\0','4126801','Tapejara','0',0,1,18),(3252,'\0','4127908','Tuneiras do Oeste','0',0,1,18),(3253,'\0','4100459','Altamira do Paraná','0',0,1,18),(3254,'\0','4103008','Boa Esperança','0',0,1,18),(3255,'\0','4103909','Campina da Lagoa','0',0,1,18),(3256,'\0','4108601','Goioerê','0',0,1,18),(3257,'\0','4112207','Janiópolis','0',0,1,18),(3258,'\0','4112959','Juranda','0',0,1,18),(3259,'\0','4116109','Moreira Sales','0',0,1,18),(3260,'\0','4116802','Nova Cantu','0',0,1,18),(3261,'\0','4120655','Quarto Centenário','0',0,1,18),(3262,'\0','4121356','Rancho Alegre D\'Oeste','0',0,1,18),(3263,'\0','4128005','Ubiratã','0',0,1,18),(3264,'\0','4101705','Araruna','0',0,1,18),(3265,'\0','4102505','Barbosa Ferraz','0',0,1,18),(3266,'\0','4104303','Campo Mourão','0',0,1,18),(3267,'\0','4106555','Corumbataí do Sul','0',0,1,18),(3268,'\0','4107504','Engenheiro Beltrão','0',0,1,18),(3269,'\0','4107553','Farol','0',0,1,18),(3270,'\0','4107702','Fênix','0',0,1,18),(3271,'\0','4110805','Iretama','0',0,1,18),(3272,'\0','4113734','Luiziana','0',0,1,18),(3273,'\0','4114005','Mamborê','0',0,1,18),(3274,'\0','4118808','Peabiru','0',0,1,18),(3275,'\0','4121109','Quinta do Sol','0',0,1,18),(3276,'\0','4122503','Roncador','0',0,1,18),(3277,'\0','4127205','Terra Boa','0',0,1,18),(3278,'\0','4101150','Ângulo','0',0,1,18),(3279,'\0','4102109','Astorga','0',0,1,18),(3280,'\0','4102208','Atalaia','0',0,1,18),(3281,'\0','4103404','Cafeara','0',0,1,18),(3282,'\0','4105102','Centenário do Sul','0',0,1,18),(3283,'\0','4105904','Colorado','0',0,1,18),(3284,'\0','4108106','Flórida','0',0,1,18),(3285,'\0','4109203','Guaraci','0',0,1,18),(3286,'\0','4110003','Iguaraçu','0',0,1,18),(3287,'\0','4110904','Itaguajé','0',0,1,18),(3288,'\0','4111902','Jaguapitã','0',0,1,18),(3289,'\0','4113601','Lobato','0',0,1,18),(3290,'\0','4113809','Lupionópolis','0',0,1,18),(3291,'\0','4114104','Mandaguaçu','0',0,1,18),(3292,'\0','4116307','Munhoz de Melo','0',0,1,18),(3293,'\0','4116406','Nossa Senhora das Graças','0',0,1,18),(3294,'\0','4116901','Nova Esperança','0',0,1,18),(3295,'\0','4120408','Presidente Castelo Branco','0',0,1,18),(3296,'\0','4123402','Santa Fé','0',0,1,18),(3297,'\0','4123600','Santa Inês','0',0,1,18),(3298,'\0','4124509','Santo Inácio','0',0,1,18),(3299,'\0','4128302','Uniflor','0',0,1,18),(3300,'\0','4100806','Alvorada do Sul','0',0,1,18),(3301,'\0','4102802','Bela Vista do Paraíso','0',0,1,18),(3302,'\0','4108007','Florestópolis','0',0,1,18),(3303,'\0','4116000','Miraselva','0',0,1,18),(3304,'\0','4120002','Porecatu','0',0,1,18),(3305,'\0','4120333','Prado Ferreira','0',0,1,18),(3306,'\0','4120507','Primeiro de Maio','0',0,1,18),(3307,'\0','4126504','Sertanópolis','0',0,1,18),(3308,'\0','4107306','Doutor Camargo','0',0,1,18),(3309,'\0','4107801','Floraí','0',0,1,18),(3310,'\0','4107900','Floresta','0',0,1,18),(3311,'\0','4111100','Itambé','0',0,1,18),(3312,'\0','4111605','Ivatuba','0',0,1,18),(3313,'\0','4117404','Ourizona','0',0,1,18),(3314,'\0','4125308','São Jorge do Ivaí','0',0,1,18),(3315,'\0','4114203','Mandaguari','0',0,1,18),(3316,'\0','4114807','Marialva','0',0,1,18),(3317,'\0','4115200','Maringá','0',0,1,18),(3318,'\0','4117503','Paiçandu','0',0,1,18),(3319,'\0','4126256','Sarandi','0',0,1,18),(3320,'\0','4101408','Apucarana','0',0,1,18),(3321,'\0','4101507','Arapongas','0',0,1,18),(3322,'\0','4103503','Califórnia','0',0,1,18),(3323,'\0','4103800','Cambira','0',0,1,18),(3324,'\0','4112108','Jandaia do Sul','0',0,1,18),(3325,'\0','4114906','Marilândia do Sul','0',0,1,18),(3326,'\0','4115754','Mauá da Serra','0',0,1,18),(3327,'\0','4117297','Novo Itacolomi','0',0,1,18),(3328,'\0','4122701','Sabáudia','0',0,1,18),(3329,'\0','4103701','Cambé','0',0,1,18),(3330,'\0','4109807','Ibiporã','0',0,1,18),(3331,'\0','4113700','Londrina','0',0,1,18),(3332,'\0','4119657','Pitangueiras','0',0,1,18),(3333,'\0','4122404','Rolândia','0',0,1,18),(3334,'\0','4126678','Tamarana','0',0,1,18),(3335,'\0','4103206','Bom Sucesso','0',0,1,18),(3336,'\0','4103305','Borrazópolis','0',0,1,18),(3337,'\0','4106852','Cruzmaltina','0',0,1,18),(3338,'\0','4107603','Faxinal','0',0,1,18),(3339,'\0','4113106','Kaloré','0',0,1,18),(3340,'\0','4115507','Marumbi','0',0,1,18),(3341,'\0','4122107','Rio Bom','0',0,1,18),(3342,'\0','4101655','Arapuã','0',0,1,18),(3343,'\0','4101853','Ariranha do Ivaí','0',0,1,18),(3344,'\0','4104402','Cândido de Abreu','0',0,1,18),(3345,'\0','4108551','Godoy Moreira','0',0,1,18),(3346,'\0','4108700','Grandes Rios','0',0,1,18),(3347,'\0','4111506','Ivaiporã','0',0,1,18),(3348,'\0','4112504','Jardim Alegre','0',0,1,18),(3349,'\0','4113429','Lidianópolis','0',0,1,18),(3350,'\0','4113759','Lunardelli','0',0,1,18),(3351,'\0','4114500','Manoel Ribas','0',0,1,18),(3352,'\0','4117271','Nova Tebas','0',0,1,18),(3353,'\0','4122172','Rio Branco do Ivaí','0',0,1,18),(3354,'\0','4122651','Rosário do Ivaí','0',0,1,18),(3355,'\0','4125001','São João do Ivaí','0',0,1,18),(3356,'\0','4125803','São Pedro do Ivaí','0',0,1,18),(3357,'\0','4101903','Assaí','0',0,1,18),(3358,'\0','4112702','Jataizinho','0',0,1,18),(3359,'\0','4117214','Nova Santa Bárbara','0',0,1,18),(3360,'\0','4121307','Rancho Alegre','0',0,1,18),(3361,'\0','4123204','Santa Cecília do Pavão','0',0,1,18),(3362,'\0','4124707','São Jerônimo da Serra','0',0,1,18),(3363,'\0','4126009','São Sebastião da Amoreira','0',0,1,18),(3364,'\0','4128401','Uraí','0',0,1,18),(3365,'\0','4100103','Abatiá','0',0,1,18),(3366,'\0','4101101','Andirá','0',0,1,18),(3367,'\0','4102406','Bandeirantes','0',0,1,18),(3368,'\0','4106001','Congonhinhas','0',0,1,18),(3369,'\0','4106407','Cornélio Procópio','0',0,1,18),(3370,'\0','4111001','Itambaracá','0',0,1,18),(3371,'\0','4113403','Leópolis','0',0,1,18),(3372,'\0','4116604','Nova América da Colina','0',0,1,18),(3373,'\0','4117008','Nova Fátima','0',0,1,18),(3374,'\0','4121901','Ribeirão do Pinhal','0',0,1,18),(3375,'\0','4123105','Santa Amélia','0',0,1,18),(3376,'\0','4123907','Santa Mariana','0',0,1,18),(3377,'\0','4124301','Santo Antônio do Paraíso','0',0,1,18),(3378,'\0','4126405','Sertaneja','0',0,1,18),(3379,'\0','4102703','Barra do Jacaré','0',0,1,18),(3380,'\0','4103602','Cambará','0',0,1,18),(3381,'\0','4111803','Jacarezinho','0',0,1,18),(3382,'\0','4112900','Jundiaí do Sul','0',0,1,18),(3383,'\0','4121802','Ribeirão Claro','0',0,1,18),(3384,'\0','4124103','Santo Antônio da Platina','0',0,1,18),(3385,'\0','4106100','Conselheiro Mairinck','0',0,1,18),(3386,'\0','4107009','Curiúva','0',0,1,18),(3387,'\0','4107751','Figueira','0',0,1,18),(3388,'\0','4109708','Ibaiti','0',0,1,18),(3389,'\0','4111704','Jaboti','0',0,1,18),(3390,'\0','4112306','Japira','0',0,1,18),(3391,'\0','4119202','Pinhalão','0',0,1,18),(3392,'\0','4126207','Sapopema','0',0,1,18),(3393,'\0','4104709','Carlópolis','0',0,1,18),(3394,'\0','4109005','Guapirama','0',0,1,18),(3395,'\0','4112801','Joaquim Távora','0',0,1,18),(3396,'\0','4120705','Quatiguá','0',0,1,18),(3397,'\0','4122909','Salto do Itararé','0',0,1,18),(3398,'\0','4124004','Santana do Itararé','0',0,1,18),(3399,'\0','4125407','São José da Boa Vista','0',0,1,18),(3400,'\0','4126603','Siqueira Campos','0',0,1,18),(3401,'\0','4127809','Tomazina','0',0,1,18),(3402,'\0','4128500','Wenceslau Braz','0',0,1,18),(3403,'\0','4110078','Imbaú','0',0,1,18),(3404,'\0','4117305','Ortigueira','0',0,1,18),(3405,'\0','4121703','Reserva','0',0,1,18),(3406,'\0','4127106','Telêmaco Borba','0',0,1,18),(3407,'\0','4127502','Tibagi','0',0,1,18),(3408,'\0','4128534','Ventania','0',0,1,18),(3409,'\0','4101606','Arapoti','0',0,1,18),(3410,'\0','4112009','Jaguariaíva','0',0,1,18),(3411,'\0','4119400','Piraí do Sul','0',0,1,18),(3412,'\0','4126306','Sengés','0',0,1,18),(3413,'\0','4104659','Carambeí','0',0,1,18),(3414,'\0','4104907','Castro','0',0,1,18),(3415,'\0','4117701','Palmeira','0',0,1,18),(3416,'\0','4119905','Ponta Grossa','0',0,1,18),(3417,'\0','4102000','Assis Chateaubriand','0',0,1,18),(3418,'\0','4107157','Diamante D\'Oeste','0',0,1,18),(3419,'\0','4107538','Entre Rios do Oeste','0',0,1,18),(3420,'\0','4108205','Formosa do Oeste','0',0,1,18),(3421,'\0','4108809','Guaíra','0',0,1,18),(3422,'\0','4110656','Iracema do Oeste','0',0,1,18),(3423,'\0','4112751','Jesuítas','0',0,1,18),(3424,'\0','4114609','Marechal Cândido Rondon','0',0,1,18),(3425,'\0','4115358','Maripá','0',0,1,18),(3426,'\0','4115853','Mercedes','0',0,1,18),(3427,'\0','4117222','Nova Santa Rosa','0',0,1,18),(3428,'\0','4117453','Ouro Verde do Oeste','0',0,1,18),(3429,'\0','4117909','Palotina','0',0,1,18),(3430,'\0','4118451','Pato Bragado','0',0,1,18),(3431,'\0','4120853','Quatro Pontes','0',0,1,18),(3432,'\0','4123501','Santa Helena','0',0,1,18),(3433,'\0','4125456','São José das Palmeiras','0',0,1,18),(3434,'\0','4125753','São Pedro do Iguaçu','0',0,1,18),(3435,'\0','4127403','Terra Roxa','0',0,1,18),(3436,'\0','4127700','Toledo','0',0,1,18),(3437,'\0','4127957','Tupãssi','0',0,1,18),(3438,'\0','4101051','Anahy','0',0,1,18),(3439,'\0','4103057','Boa Vista da Aparecida','0',0,1,18),(3440,'\0','4103354','Braganey','0',0,1,18),(3441,'\0','4103453','Cafelândia','0',0,1,18),(3442,'\0','4104055','Campo Bonito','0',0,1,18),(3443,'\0','4104600','Capitão Leônidas Marques','0',0,1,18),(3444,'\0','4104808','Cascavel','0',0,1,18),(3445,'\0','4105003','Catanduvas','0',0,1,18),(3446,'\0','4106308','Corbélia','0',0,1,18),(3447,'\0','4107124','Diamante do Sul','0',0,1,18),(3448,'\0','4109302','Guaraniaçu','0',0,1,18),(3449,'\0','4109757','Ibema','0',0,1,18),(3450,'\0','4110052','Iguatu','0',0,1,18),(3451,'\0','4113452','Lindoeste','0',0,1,18),(3452,'\0','4116703','Nova Aurora','0',0,1,18),(3453,'\0','4123824','Santa Lúcia','0',0,1,18),(3454,'\0','4124020','Santa Tereza do Oeste','0',0,1,18),(3455,'\0','4127858','Três Barras do Paraná','0',0,1,18),(3456,'\0','4105300','Céu Azul','0',0,1,18),(3457,'\0','4108304','Foz do Iguaçu','0',0,1,18),(3458,'\0','4110953','Itaipulândia','0',0,1,18),(3459,'\0','4115606','Matelândia','0',0,1,18),(3460,'\0','4115804','Medianeira','0',0,1,18),(3461,'\0','4116059','Missal','0',0,1,18),(3462,'\0','4121257','Ramilândia','0',0,1,18),(3463,'\0','4124053','Santa Terezinha de Itaipu','0',0,1,18),(3464,'\0','4125704','São Miguel do Iguaçu','0',0,1,18),(3465,'\0','4126355','Serranópolis do Iguaçu','0',0,1,18),(3466,'\0','4128559','Vera Cruz do Oeste','0',0,1,18),(3467,'\0','4101002','Ampére','0',0,1,18),(3468,'\0','4102752','Bela Vista da Caroba','0',0,1,18),(3469,'\0','4104501','Capanema','0',0,1,18),(3470,'\0','4119004','Pérola d\'Oeste','0',0,1,18),(3471,'\0','4119806','Planalto','0',0,1,18),(3472,'\0','4120358','Pranchita','0',0,1,18),(3473,'\0','4121406','Realeza','0',0,1,18),(3474,'\0','4123808','Santa Izabel do Oeste','0',0,1,18),(3475,'\0','4102604','Barracão','0',0,1,18),(3476,'\0','4103024','Boa Esperança do Iguaçu','0',0,1,18),(3477,'\0','4103156','Bom Jesus do Sul','0',0,1,18),(3478,'\0','4106571','Cruzeiro do Iguaçu','0',0,1,18),(3479,'\0','4107207','Dois Vizinhos','0',0,1,18),(3480,'\0','4107405','Enéas Marques','0',0,1,18),(3481,'\0','4107850','Flor da Serra do Sul','0',0,1,18),(3482,'\0','4108403','Francisco Beltrão','0',0,1,18),(3483,'\0','4114351','Manfrinópolis','0',0,1,18),(3484,'\0','4115408','Marmeleiro','0',0,1,18),(3485,'\0','4116950','Nova Esperança do Sudoeste','0',0,1,18),(3486,'\0','4117255','Nova Prata do Iguaçu','0',0,1,18),(3487,'\0','4119251','Pinhal de São Bento','0',0,1,18),(3488,'\0','4121604','Renascença','0',0,1,18),(3489,'\0','4122800','Salgado Filho','0',0,1,18),(3490,'\0','4123006','Salto do Lontra','0',0,1,18),(3491,'\0','4124400','Santo Antônio do Sudoeste','0',0,1,18),(3492,'\0','4125209','São Jorge d\'Oeste','0',0,1,18),(3493,'\0','4128609','Verê','0',0,1,18),(3494,'\0','4103222','Bom Sucesso do Sul','0',0,1,18),(3495,'\0','4105409','Chopinzinho','0',0,1,18),(3496,'\0','4106506','Coronel Vivida','0',0,1,18),(3497,'\0','4111209','Itapejara d\'Oeste','0',0,1,18),(3498,'\0','4115309','Mariópolis','0',0,1,18),(3499,'\0','4118501','Pato Branco','0',0,1,18),(3500,'\0','4124806','São João','0',0,1,18),(3501,'\0','4126272','Saudade do Iguaçu','0',0,1,18),(3502,'\0','4126652','Sulina','0',0,1,18),(3503,'\0','4128708','Vitorino','0',0,1,18),(3504,'\0','4103040','Boa Ventura de São Roque','0',0,1,18),(3505,'\0','4113254','Laranjal','0',0,1,18),(3506,'\0','4115739','Mato Rico','0',0,1,18),(3507,'\0','4117800','Palmital','0',0,1,18),(3508,'\0','4119608','Pitanga','0',0,1,18),(3509,'\0','4123857','Santa Maria do Oeste','0',0,1,18),(3510,'\0','4103958','Campina do Simão','0',0,1,18),(3511,'\0','4104428','Candói','0',0,1,18),(3512,'\0','4104451','Cantagalo','0',0,1,18),(3513,'\0','4107546','Espigão Alto do Iguaçu','0',0,1,18),(3514,'\0','4108452','Foz do Jordão','0',0,1,18),(3515,'\0','4108650','Goioxim','0',0,1,18),(3516,'\0','4109401','Guarapuava','0',0,1,18),(3517,'\0','4110201','Inácio Martins','0',0,1,18),(3518,'\0','4113304','Laranjeiras do Sul','0',0,1,18),(3519,'\0','4115457','Marquinho','0',0,1,18),(3520,'\0','4117057','Nova Laranjeiras','0',0,1,18),(3521,'\0','4119301','Pinhão','0',0,1,18),(3522,'\0','4120150','Porto Barreiro','0',0,1,18),(3523,'\0','4120903','Quedas do Iguaçu','0',0,1,18),(3524,'\0','4121752','Reserva do Iguaçu','0',0,1,18),(3525,'\0','4122156','Rio Bonito do Iguaçu','0',0,1,18),(3526,'\0','4127965','Turvo','0',0,1,18),(3527,'\0','4128658','Virmond','0',0,1,18),(3528,'\0','4105706','Clevelândia','0',0,1,18),(3529,'\0','4106456','Coronel Domingos Soares','0',0,1,18),(3530,'\0','4109658','Honório Serpa','0',0,1,18),(3531,'\0','4114401','Mangueirinha','0',0,1,18),(3532,'\0','4117602','Palmas','0',0,1,18),(3533,'\0','4107736','Fernandes Pinheiro','0',0,1,18),(3534,'\0','4108957','Guamiranga','0',0,1,18),(3535,'\0','4110102','Imbituva','0',0,1,18),(3536,'\0','4110508','Ipiranga','0',0,1,18),(3537,'\0','4111407','Ivaí','0',0,1,18),(3538,'\0','4120606','Prudentópolis','0',0,1,18),(3539,'\0','4127007','Teixeira Soares','0',0,1,18),(3540,'\0','4110706','Irati','0',0,1,18),(3541,'\0','4113908','Mallet','0',0,1,18),(3542,'\0','4121505','Rebouças','0',0,1,18),(3543,'\0','4122008','Rio Azul','0',0,1,18),(3544,'\0','4102901','Bituruna','0',0,1,18),(3545,'\0','4106803','Cruz Machado','0',0,1,18),(3546,'\0','4108502','General Carneiro','0',0,1,18),(3547,'\0','4118600','Paula Freitas','0',0,1,18),(3548,'\0','4118709','Paulo Frontin','0',0,1,18),(3549,'\0','4120309','Porto Vitória','0',0,1,18),(3550,'\0','4128203','União da Vitória','0',0,1,18),(3551,'\0','4101309','Antônio Olinto','0',0,1,18),(3552,'\0','4125100','São João do Triunfo','0',0,1,18),(3553,'\0','4125605','São Mateus do Sul','0',0,1,18),(3554,'\0','4100202','Adrianópolis','0',0,1,18),(3555,'\0','4105201','Cerro Azul','0',0,1,18),(3556,'\0','4128633','Doutor Ulysses','0',0,1,18),(3557,'\0','4113205','Lapa','0',0,1,18),(3558,'\0','4120101','Porto Amazonas','0',0,1,18),(3559,'\0','4100400','Almirante Tamandaré','0',0,1,18),(3560,'\0','4101804','Araucária','0',0,1,18),(3561,'\0','4102307','Balsa Nova','0',0,1,18),(3562,'\0','4103107','Bocaiúva do Sul','0',0,1,18),(3563,'\0','4104006','Campina Grande do Sul','0',0,1,18),(3564,'\0','4104204','Campo Largo','0',0,1,18),(3565,'\0','4104253','Campo Magro','0',0,1,18),(3566,'\0','4105805','Colombo','0',0,1,18),(3567,'\0','4106209','Contenda','0',0,1,18),(3568,'\0','4106902','Curitiba','0',0,1,18),(3569,'\0','4107652','Fazenda Rio Grande','0',0,1,18),(3570,'\0','4111258','Itaperuçu','0',0,1,18),(3571,'\0','4114302','Mandirituba','0',0,1,18),(3572,'\0','4119152','Pinhais','0',0,1,18),(3573,'\0','4119509','Piraquara','0',0,1,18),(3574,'\0','4120804','Quatro Barras','0',0,1,18),(3575,'\0','4122206','Rio Branco do Sul','0',0,1,18),(3576,'\0','4125506','São José dos Pinhais','0',0,1,18),(3577,'\0','4127882','Tunas do Paraná','0',0,1,18),(3578,'\0','4101200','Antonina','0',0,1,18),(3579,'\0','4109500','Guaraqueçaba','0',0,1,18),(3580,'\0','4109609','Guaratuba','0',0,1,18),(3581,'\0','4115705','Matinhos','0',0,1,18),(3582,'\0','4116208','Morretes','0',0,1,18),(3583,'\0','4118204','Paranaguá','0',0,1,18),(3584,'\0','4119954','Pontal do Paraná','0',0,1,18),(3585,'\0','4100301','Agudos do Sul','0',0,1,18),(3586,'\0','4104105','Campo do Tenente','0',0,1,18),(3587,'\0','4119103','Piên','0',0,1,18),(3588,'\0','4121208','Quitandinha','0',0,1,18),(3589,'\0','4122305','Rio Negro','0',0,1,18),(3590,'\0','4127601','Tijucas do Sul','0',0,1,18),(3591,'\0','3300605','Bom Jesus do Itabapoana','0',0,1,19),(3592,'\0','3302056','Italva','0',0,1,19),(3593,'\0','3302205','Itaperuna','0',0,1,19),(3594,'\0','3302304','Laje do Muriaé','0',0,1,19),(3595,'\0','3303104','Natividade','0',0,1,19),(3596,'\0','3304102','Porciúncula','0',0,1,19),(3597,'\0','3306156','Varre-Sai','0',0,1,19),(3598,'\0','3300159','Aperibé','0',0,1,19),(3599,'\0','3300902','Cambuci','0',0,1,19),(3600,'\0','3302106','Itaocara','0',0,1,19),(3601,'\0','3303005','Miracema','0',0,1,19),(3602,'\0','3304706','Santo Antônio de Pádua','0',0,1,19),(3603,'\0','3305133','São José de Ubá','0',0,1,19),(3604,'\0','3301009','Campos dos Goytacazes','0',0,1,19),(3605,'\0','3301157','Cardoso Moreira','0',0,1,19),(3606,'\0','3304755','São Francisco de Itabapoana','0',0,1,19),(3607,'\0','3304805','São Fidélis','0',0,1,19),(3608,'\0','3305000','São João da Barra','0',0,1,19),(3609,'\0','3300936','Carapebus','0',0,1,19),(3610,'\0','3301405','Conceição de Macabu','0',0,1,19),(3611,'\0','3302403','Macaé','0',0,1,19),(3612,'\0','3304151','Quissamã','0',0,1,19),(3613,'\0','3300225','Areal','0',0,1,19),(3614,'\0','3300951','Comendador Levy Gasparian','0',0,1,19),(3615,'\0','3303708','Paraíba do Sul','0',0,1,19),(3616,'\0','3305406','Sapucaia','0',0,1,19),(3617,'\0','3306008','Três Rios','0',0,1,19),(3618,'\0','3301108','Cantagalo','0',0,1,19),(3619,'\0','3301207','Carmo','0',0,1,19),(3620,'\0','3301504','Cordeiro','0',0,1,19),(3621,'\0','3302452','Macuco','0',0,1,19),(3622,'\0','3300506','Bom Jardim','0',0,1,19),(3623,'\0','3301603','Duas Barras','0',0,1,19),(3624,'\0','3303401','Nova Friburgo','0',0,1,19),(3625,'\0','3305703','Sumidouro','0',0,1,19),(3626,'\0','3304607','Santa Maria Madalena','0',0,1,19),(3627,'\0','3305307','São Sebastião do Alto','0',0,1,19),(3628,'\0','3305901','Trajano de Morais','0',0,1,19),(3629,'\0','3301306','Casimiro de Abreu','0',0,1,19),(3630,'\0','3304524','Rio das Ostras','0',0,1,19),(3631,'\0','3305604','Silva Jardim','0',0,1,19),(3632,'\0','3300209','Araruama','0',0,1,19),(3633,'\0','3300233','Armação dos Búzios','0',0,1,19),(3634,'\0','3300258','Arraial do Cabo','0',0,1,19),(3635,'\0','3300704','Cabo Frio','0',0,1,19),(3636,'\0','3301876','Iguaba Grande','0',0,1,19),(3637,'\0','3305208','São Pedro da Aldeia','0',0,1,19),(3638,'\0','3305505','Saquarema','0',0,1,19),(3639,'\0','3300407','Barra Mansa','0',0,1,19),(3640,'\0','3302254','Itatiaia','0',0,1,19),(3641,'\0','3303955','Pinheiral','0',0,1,19),(3642,'\0','3304003','Piraí','0',0,1,19),(3643,'\0','3304110','Porto Real','0',0,1,19),(3644,'\0','3304128','Quatis','0',0,1,19),(3645,'\0','3304201','Resende','0',0,1,19),(3646,'\0','3304409','Rio Claro','0',0,1,19),(3647,'\0','3306305','Volta Redonda','0',0,1,19),(3648,'\0','3300308','Barra do Piraí','0',0,1,19),(3649,'\0','3304508','Rio das Flores','0',0,1,19),(3650,'\0','3306107','Valença','0',0,1,19),(3651,'\0','3300100','Angra dos Reis','0',0,1,19),(3652,'\0','3303807','Parati','0',0,1,19),(3653,'\0','3301801','Engenheiro Paulo de Frontin','0',0,1,19),(3654,'\0','3302809','Mendes','0',0,1,19),(3655,'\0','3302908','Miguel Pereira','0',0,1,19),(3656,'\0','3303609','Paracambi','0',0,1,19),(3657,'\0','3303856','Paty do Alferes','0',0,1,19),(3658,'\0','3306206','Vassouras','0',0,1,19),(3659,'\0','3303906','Petrópolis','0',0,1,19),(3660,'\0','3305158','São José do Vale do Rio Preto','0',0,1,19),(3661,'\0','3305802','Teresópolis','0',0,1,19),(3662,'\0','3300803','Cachoeiras de Macacu','0',0,1,19),(3663,'\0','3304300','Rio Bonito','0',0,1,19),(3664,'\0','3302007','Itaguaí','0',0,1,19),(3665,'\0','3302601','Mangaratiba','0',0,1,19),(3666,'\0','3305554','Seropédica','0',0,1,19),(3667,'\0','3300456','Belford Roxo','0',0,1,19),(3668,'\0','3301702','Duque de Caxias','0',0,1,19),(3669,'\0','3301850','Guapimirim','0',0,1,19),(3670,'\0','3301900','Itaboraí','0',0,1,19),(3671,'\0','3302270','Japeri','0',0,1,19),(3672,'\0','3302502','Magé','0',0,1,19),(3673,'\0','3302700','Maricá','0',0,1,19),(3674,'\0','3302858','Mesquita','0',0,1,19),(3675,'\0','3303203','Nilópolis','0',0,1,19),(3676,'\0','3303302','Niterói','0',0,1,19),(3677,'\0','3303500','Nova Iguaçu','0',0,1,19),(3678,'\0','3304144','Queimados','0',0,1,19),(3679,'\0','3304557','Rio de Janeiro','0',0,1,19),(3680,'\0','3304904','São Gonçalo','0',0,1,19),(3681,'\0','3305109','São João de Meriti','0',0,1,19),(3682,'\0','3305752','Tanguá','0',0,1,19),(3683,'\0','2401107','Areia Branca','0',0,1,20),(3684,'\0','2401453','Baraúna','0',0,1,20),(3685,'\0','2404408','Grossos','0',0,1,20),(3686,'\0','2408003','Mossoró','0',0,1,20),(3687,'\0','2411056','Tibau','0',0,1,20),(3688,'\0','2413359','Serra do Mel','0',0,1,20),(3689,'\0','2401008','Apodi','0',0,1,20),(3690,'\0','2402303','Caraúbas','0',0,1,20),(3691,'\0','2403707','Felipe Guerra','0',0,1,20),(3692,'\0','2404309','Governador Dix-Sept Rosado','0',0,1,20),(3693,'\0','2401305','Augusto Severo','0',0,1,20),(3694,'\0','2405207','Janduís','0',0,1,20),(3695,'\0','2407609','Messias Targino','0',0,1,20),(3696,'\0','2408706','Paraú','0',0,1,20),(3697,'\0','2414456','Triunfo Potiguar','0',0,1,20),(3698,'\0','2414605','Upanema','0',0,1,20),(3699,'\0','2400208','Açu','0',0,1,20),(3700,'\0','2400703','Alto do Rodrigues','0',0,1,20),(3701,'\0','2402501','Carnaubais','0',0,1,20),(3702,'\0','2404705','Ipanguaçu','0',0,1,20),(3703,'\0','2404853','Itajá','0',0,1,20),(3704,'\0','2406106','Jucurutu','0',0,1,20),(3705,'\0','2409902','Pendências','0',0,1,20),(3706,'\0','2410256','Porto do Mangue','0',0,1,20),(3707,'\0','2412807','São Rafael','0',0,1,20),(3708,'\0','2400406','Água Nova','0',0,1,20),(3709,'\0','2402907','Coronel João Pessoa','0',0,1,20),(3710,'\0','2403202','Doutor Severiano','0',0,1,20),(3711,'\0','2403301','Encanto','0',0,1,20),(3712,'\0','2407005','Luís Gomes','0',0,1,20),(3713,'\0','2407252','Major Sales','0',0,1,20),(3714,'\0','2410801','Riacho de Santana','0',0,1,20),(3715,'\0','2412500','São Miguel','0',0,1,20),(3716,'\0','2414753','Venha-Ver','0',0,1,20),(3717,'\0','2400505','Alexandria','0',0,1,20),(3718,'\0','2403905','Francisco Dantas','0',0,1,20),(3719,'\0','2404903','Itaú','0',0,1,20),(3720,'\0','2406007','José da Penha','0',0,1,20),(3721,'\0','2407302','Marcelino Vieira','0',0,1,20),(3722,'\0','2408607','Paraná','0',0,1,20),(3723,'\0','2409407','Pau dos Ferros','0',0,1,20),(3724,'\0','2410009','Pilões','0',0,1,20),(3725,'\0','2410207','Portalegre','0',0,1,20),(3726,'\0','2410504','Rafael Fernandes','0',0,1,20),(3727,'\0','2410702','Riacho da Cruz','0',0,1,20),(3728,'\0','2411007','Rodolfo Fernandes','0',0,1,20),(3729,'\0','2411908','São Francisco do Oeste','0',0,1,20),(3730,'\0','2413607','Severiano Melo','0',0,1,20),(3731,'\0','2413805','Taboleiro Grande','0',0,1,20),(3732,'\0','2414100','Tenente Ananias','0',0,1,20),(3733,'\0','2414902','Viçosa','0',0,1,20),(3734,'\0','2400604','Almino Afonso','0',0,1,20),(3735,'\0','2400901','Antônio Martins','0',0,1,20),(3736,'\0','2404002','Frutuoso Gomes','0',0,1,20),(3737,'\0','2405900','João Dias','0',0,1,20),(3738,'\0','2406908','Lucrécia','0',0,1,20),(3739,'\0','2407401','Martins','0',0,1,20),(3740,'\0','2408409','Olho-d\'Água do Borges','0',0,1,20),(3741,'\0','2409308','Patu','0',0,1,20),(3742,'\0','2410603','Rafael Godeiro','0',0,1,20),(3743,'\0','2413557','Serrinha dos Pintos','0',0,1,20),(3744,'\0','2414506','Umarizal','0',0,1,20),(3745,'\0','2401859','Caiçara do Norte','0',0,1,20),(3746,'\0','2404101','Galinhos','0',0,1,20),(3747,'\0','2404507','Guamaré','0',0,1,20),(3748,'\0','2407203','Macau','0',0,1,20),(3749,'\0','2411601','São Bento do Norte','0',0,1,20),(3750,'\0','2400307','Afonso Bezerra','0',0,1,20),(3751,'\0','2400802','Angicos','0',0,1,20),(3752,'\0','2401909','Caiçara do Rio do Vento','0',0,1,20),(3753,'\0','2403756','Fernando Pedroza','0',0,1,20),(3754,'\0','2405504','Jardim de Angicos','0',0,1,20),(3755,'\0','2406700','Lajes','0',0,1,20),(3756,'\0','2409605','Pedra Preta','0',0,1,20),(3757,'\0','2409704','Pedro Avelino','0',0,1,20),(3758,'\0','2401651','Bodó','0',0,1,20),(3759,'\0','2402709','Cerro Corá','0',0,1,20),(3760,'\0','2403806','Florânia','0',0,1,20),(3761,'\0','2406502','Lagoa Nova','0',0,1,20),(3762,'\0','2411403','Santana do Matos','0',0,1,20),(3763,'\0','2413003','São Vicente','0',0,1,20),(3764,'\0','2414159','Tenente Laurentino Cruz','0',0,1,20),(3765,'\0','2402006','Caicó','0',0,1,20),(3766,'\0','2404804','Ipueira','0',0,1,20),(3767,'\0','2405603','Jardim de Piranhas','0',0,1,20),(3768,'\0','2411809','São Fernando','0',0,1,20),(3769,'\0','2412104','São João do Sabugi','0',0,1,20),(3770,'\0','2413409','Serra Negra do Norte','0',0,1,20),(3771,'\0','2414308','Timbaúba dos Batistas','0',0,1,20),(3772,'\0','2400109','Acari','0',0,1,20),(3773,'\0','2402402','Carnaúba dos Dantas','0',0,1,20),(3774,'\0','2403004','Cruzeta','0',0,1,20),(3775,'\0','2403103','Currais Novos','0',0,1,20),(3776,'\0','2403400','Equador','0',0,1,20),(3777,'\0','2405702','Jardim do Seridó','0',0,1,20),(3778,'\0','2408508','Ouro Branco','0',0,1,20),(3779,'\0','2408904','Parelhas','0',0,1,20),(3780,'\0','2411429','Santana do Seridó','0',0,1,20),(3781,'\0','2412401','São José do Seridó','0',0,1,20),(3782,'\0','2401602','Bento Fernandes','0',0,1,20),(3783,'\0','2405108','Jandaíra','0',0,1,20),(3784,'\0','2405801','João Câmara','0',0,1,20),(3785,'\0','2408805','Parazinho','0',0,1,20),(3786,'\0','2410108','Poço Branco','0',0,1,20),(3787,'\0','2401503','Barcelona','0',0,1,20),(3788,'\0','2402105','Campo Redondo','0',0,1,20),(3789,'\0','2402808','Coronel Ezequiel','0',0,1,20),(3790,'\0','2405009','Jaçanã','0',0,1,20),(3791,'\0','2405405','Japi','0',0,1,20),(3792,'\0','2406403','Lagoa de Velhos','0',0,1,20),(3793,'\0','2406809','Lajes Pintadas','0',0,1,20),(3794,'\0','2407906','Monte das Gameleiras','0',0,1,20),(3795,'\0','2411106','Ruy Barbosa','0',0,1,20),(3796,'\0','2411205','Santa Cruz','0',0,1,20),(3797,'\0','2411700','São Bento do Trairí','0',0,1,20),(3798,'\0','2412302','São José do Campestre','0',0,1,20),(3799,'\0','2412906','São Tomé','0',0,1,20),(3800,'\0','2413300','Serra de São Bento','0',0,1,20),(3801,'\0','2413706','Sítio Novo','0',0,1,20),(3802,'\0','2414001','Tangará','0',0,1,20),(3803,'\0','2401701','Bom Jesus','0',0,1,20),(3804,'\0','2401800','Brejinho','0',0,1,20),(3805,'\0','2404606','Ielmo Marinho','0',0,1,20),(3806,'\0','2405306','Januário Cicco','0',0,1,20),(3807,'\0','2406155','Jundiá','0',0,1,20),(3808,'\0','2406205','Lagoa d\'Anta','0',0,1,20),(3809,'\0','2406304','Lagoa de Pedras','0',0,1,20),(3810,'\0','2406601','Lagoa Salgada','0',0,1,20),(3811,'\0','2407807','Monte Alegre','0',0,1,20),(3812,'\0','2408300','Nova Cruz','0',0,1,20),(3813,'\0','2409100','Passa e Fica','0',0,1,20),(3814,'\0','2409209','Passagem','0',0,1,20),(3815,'\0','2409332','Santa Maria','0',0,1,20),(3816,'\0','2410306','Presidente Juscelino','0',0,1,20),(3817,'\0','2410900','Riachuelo','0',0,1,20),(3818,'\0','2411502','Santo Antônio','0',0,1,20),(3819,'\0','2412609','São Paulo do Potengi','0',0,1,20),(3820,'\0','2412708','São Pedro','0',0,1,20),(3821,'\0','2413102','Senador Elói de Souza','0',0,1,20),(3822,'\0','2413508','Serrinha','0',0,1,20),(3823,'\0','2414704','Várzea','0',0,1,20),(3824,'\0','2414803','Vera Cruz','0',0,1,20),(3825,'\0','2407500','Maxaranguape','0',0,1,20),(3826,'\0','2408953','Rio do Fogo','0',0,1,20),(3827,'\0','2409506','Pedra Grande','0',0,1,20),(3828,'\0','2410405','Pureza','0',0,1,20),(3829,'\0','2412559','São Miguel do Gostoso','0',0,1,20),(3830,'\0','2413904','Taipu','0',0,1,20),(3831,'\0','2414407','Touros','0',0,1,20),(3832,'\0','2402600','Ceará-Mirim','0',0,1,20),(3833,'\0','2407104','Macaíba','0',0,1,20),(3834,'\0','2408201','Nísia Floresta','0',0,1,20),(3835,'\0','2412005','São Gonçalo do Amarante','0',0,1,20),(3836,'\0','2412203','São José de Mipibu','0',0,1,20),(3837,'\0','2403251','Parnamirim','0',0,1,20),(3838,'\0','2403608','Extremoz','0',0,1,20),(3839,'\0','2408102','Natal','0',0,1,20),(3840,'\0','2401206','Arês','0',0,1,20),(3841,'\0','2401404','Baía Formosa','0',0,1,20),(3842,'\0','2402204','Canguaretama','0',0,1,20),(3843,'\0','2403509','Espírito Santo','0',0,1,20),(3844,'\0','2404200','Goianinha','0',0,1,20),(3845,'\0','2407708','Montanhas','0',0,1,20),(3846,'\0','2409803','Pedro Velho','0',0,1,20),(3847,'\0','2413201','Senador Georgino Avelino','0',0,1,20),(3848,'\0','2414209','Tibau do Sul','0',0,1,20),(3849,'\0','2415008','Vila Flor','0',0,1,20),(3850,'\0','1100148','Nova Brasilândia D\'Oeste','0',0,1,21),(3851,'\0','1100320','São Miguel do Guaporé','0',0,1,21),(3852,'\0','1100346','Alvorada D\'Oeste','0',0,1,21),(3853,'\0','1101500','Seringueiras','0',0,1,21),(3854,'\0','1100015','Alta Floresta D\'Oeste','0',0,1,21),(3855,'\0','1100049','Cacoal','0',0,1,21),(3856,'\0','1100098','Espigão D\'Oeste','0',0,1,21),(3857,'\0','1100288','Rolim de Moura','0',0,1,21),(3858,'\0','1100296','Santa Luzia D\'Oeste','0',0,1,21),(3859,'\0','1100379','Alto Alegre dos Parecis','0',0,1,21),(3860,'\0','1100502','Novo Horizonte do Oeste','0',0,1,21),(3861,'\0','1100908','Castanheiras','0',0,1,21),(3862,'\0','1101203','Ministro Andreazza','0',0,1,21),(3863,'\0','1100189','Pimenta Bueno','0',0,1,21),(3864,'\0','1100304','Vilhena','0',0,1,21),(3865,'\0','1100924','Chupinguaia','0',0,1,21),(3866,'\0','1101450','Parecis','0',0,1,21),(3867,'\0','1101476','Primavera de Rondônia','0',0,1,21),(3868,'\0','1101484','São Felipe D\'Oeste','0',0,1,21),(3869,'\0','1100031','Cabixi','0',0,1,21),(3870,'\0','1100056','Cerejeiras','0',0,1,21),(3871,'\0','1100064','Colorado do Oeste','0',0,1,21),(3872,'\0','1100072','Corumbiara','0',0,1,21),(3873,'\0','1101468','Pimenteiras do Oeste','0',0,1,21),(3874,'\0','1100205','Porto Velho','0',0,1,21),(3875,'\0','1100338','Nova Mamoré','0',0,1,21),(3876,'\0','1100452','Buritis','0',0,1,21),(3877,'\0','1100700','Campo Novo de Rondônia','0',0,1,21),(3878,'\0','1100809','Candeias do Jamari','0',0,1,21),(3879,'\0','1100940','Cujubim','0',0,1,21),(3880,'\0','1101104','Itapuã do Oeste','0',0,1,21),(3881,'\0','1100080','Costa Marques','0',0,1,21),(3882,'\0','1100106','Guajará-Mirim','0',0,1,21),(3883,'\0','1101492','São Francisco do Guaporé','0',0,1,21),(3884,'\0','1100023','Ariquemes','0',0,1,21),(3885,'\0','1100130','Machadinho D\'Oeste','0',0,1,21),(3886,'\0','1100262','Rio Crespo','0',0,1,21),(3887,'\0','1100403','Alto Paraíso','0',0,1,21),(3888,'\0','1100601','Cacaulândia','0',0,1,21),(3889,'\0','1101401','Monte Negro','0',0,1,21),(3890,'\0','1101757','Vale do Anari','0',0,1,21),(3891,'\0','1100114','Jaru','0',0,1,21),(3892,'\0','1100122','Ji-Paraná','0',0,1,21),(3893,'\0','1100155','Ouro Preto do Oeste','0',0,1,21),(3894,'\0','1100254','Presidente Médici','0',0,1,21),(3895,'\0','1101005','Governador Jorge Teixeira','0',0,1,21),(3896,'\0','1101302','Mirante da Serra','0',0,1,21),(3897,'\0','1101435','Nova União','0',0,1,21),(3898,'\0','1101559','Teixeirópolis','0',0,1,21),(3899,'\0','1101609','Theobroma','0',0,1,21),(3900,'\0','1101708','Urupá','0',0,1,21),(3901,'\0','1101807','Vale do Paraíso','0',0,1,21),(3902,'\0','1400027','Amajari','0',0,1,22),(3903,'\0','1400050','Alto Alegre','0',0,1,22),(3904,'\0','1400100','Boa Vista','0',0,1,22),(3905,'\0','1400456','Pacaraima','0',0,1,22),(3906,'\0','1400159','Bonfim','0',0,1,22),(3907,'\0','1400175','Cantá','0',0,1,22),(3908,'\0','1400407','Normandia','0',0,1,22),(3909,'\0','1400704','Uiramutã','0',0,1,22),(3910,'\0','1400209','Caracaraí','0',0,1,22),(3911,'\0','1400282','Iracema','0',0,1,22),(3912,'\0','1400308','Mucajaí','0',0,1,22),(3913,'\0','1400233','Caroebe','0',0,1,22),(3914,'\0','1400472','Rorainópolis','0',0,1,22),(3915,'\0','1400506','São João da Baliza','0',0,1,22),(3916,'\0','1400605','São Luiz','0',0,1,22),(3917,'\0','4300307','Alecrim','0',0,1,23),(3918,'\0','4304309','Cândido Godói','0',0,1,23),(3919,'\0','4310405','Independência','0',0,1,23),(3920,'\0','4313425','Novo Machado','0',0,1,23),(3921,'\0','4315008','Porto Lucena','0',0,1,23),(3922,'\0','4315057','Porto Mauá','0',0,1,23),(3923,'\0','4315073','Porto Vera Cruz','0',0,1,23),(3924,'\0','4317202','Santa Rosa','0',0,1,23),(3925,'\0','4317905','Santo Cristo','0',0,1,23),(3926,'\0','4318499','São José do Inhacorá','0',0,1,23),(3927,'\0','4321808','Três de Maio','0',0,1,23),(3928,'\0','4322103','Tucunduva','0',0,1,23),(3929,'\0','4322301','Tuparendi','0',0,1,23),(3930,'\0','4301859','Barra do Guarita','0',0,1,23),(3931,'\0','4302204','Boa Vista do Buricá','0',0,1,23),(3932,'\0','4302378','Bom Progresso','0',0,1,23),(3933,'\0','4302600','Braga','0',0,1,23),(3934,'\0','4304002','Campo Novo','0',0,1,23),(3935,'\0','4306007','Crissiumal','0',0,1,23),(3936,'\0','4306320','Derrubadas','0',0,1,23),(3937,'\0','4306734','Doutor Maurício Cardoso','0',0,1,23),(3938,'\0','4307450','Esperança do Sul','0',0,1,23),(3939,'\0','4309605','Horizontina','0',0,1,23),(3940,'\0','4309704','Humaitá','0',0,1,23),(3941,'\0','4312302','Miraguaí','0',0,1,23),(3942,'\0','4313011','Nova Candelária','0',0,1,23),(3943,'\0','4315404','Redentora','0',0,1,23),(3944,'\0','4319109','São Martinho','0',0,1,23),(3945,'\0','4320230','Sede Nova','0',0,1,23),(3946,'\0','4321402','Tenente Portela','0',0,1,23),(3947,'\0','4321477','Tiradentes do Sul','0',0,1,23),(3948,'\0','4321907','Três Passos','0',0,1,23),(3949,'\0','4323705','Vista Gaúcha','0',0,1,23),(3950,'\0','4300505','Alpestre','0',0,1,23),(3951,'\0','4300646','Ametista do Sul','0',0,1,23),(3952,'\0','4303400','Caiçara','0',0,1,23),(3953,'\0','4305801','Constantina','0',0,1,23),(3954,'\0','4306072','Cristal do Sul','0',0,1,23),(3955,'\0','4306429','Dois Irmãos das Missões','0',0,1,23),(3956,'\0','4306924','Engenho Velho','0',0,1,23),(3957,'\0','4307302','Erval Seco','0',0,1,23),(3958,'\0','4308508','Frederico Westphalen','0',0,1,23),(3959,'\0','4309126','Gramado dos Loureiros','0',0,1,23),(3960,'\0','4310504','Iraí','0',0,1,23),(3961,'\0','4311601','Liberato Salzano','0',0,1,23),(3962,'\0','4312708','Nonoai','0',0,1,23),(3963,'\0','4313441','Novo Tiradentes','0',0,1,23),(3964,'\0','4313466','Novo Xingu','0',0,1,23),(3965,'\0','4313805','Palmitinho','0',0,1,23),(3966,'\0','4314498','Pinheirinho do Vale','0',0,1,23),(3967,'\0','4314704','Planalto','0',0,1,23),(3968,'\0','4315552','Rio dos Índios','0',0,1,23),(3969,'\0','4315909','Rodeio Bonito','0',0,1,23),(3970,'\0','4316204','Rondinha','0',0,1,23),(3971,'\0','4320206','Seberi','0',0,1,23),(3972,'\0','4321329','Taquaruçu do Sul','0',0,1,23),(3973,'\0','4321857','Três Palmeiras','0',0,1,23),(3974,'\0','4321956','Trindade do Sul','0',0,1,23),(3975,'\0','4323101','Vicente Dutra','0',0,1,23),(3976,'\0','4323507','Vista Alegre','0',0,1,23),(3977,'\0','4300901','Aratiba','0',0,1,23),(3978,'\0','4301552','Áurea','0',0,1,23),(3979,'\0','4301701','Barão de Cotegipe','0',0,1,23),(3980,'\0','4301925','Barra do Rio Azul','0',0,1,23),(3981,'\0','4302055','Benjamin Constant do Sul','0',0,1,23),(3982,'\0','4303806','Campinas do Sul','0',0,1,23),(3983,'\0','4304853','Carlos Gomes','0',0,1,23),(3984,'\0','4305116','Centenário','0',0,1,23),(3985,'\0','4306130','Cruzaltense','0',0,1,23),(3986,'\0','4306957','Entre Rios do Sul','0',0,1,23),(3987,'\0','4306973','Erebango','0',0,1,23),(3988,'\0','4307005','Erechim','0',0,1,23),(3989,'\0','4307203','Erval Grande','0',0,1,23),(3990,'\0','4307559','Estação','0',0,1,23),(3991,'\0','4308052','Faxinalzinho','0',0,1,23),(3992,'\0','4308250','Floriano Peixoto','0',0,1,23),(3993,'\0','4308706','Gaurama','0',0,1,23),(3994,'\0','4308904','Getúlio Vargas','0',0,1,23),(3995,'\0','4310462','Ipiranga do Sul','0',0,1,23),(3996,'\0','4310702','Itatiba do Sul','0',0,1,23),(3997,'\0','4310900','Jacutinga','0',0,1,23),(3998,'\0','4311908','Marcelino Ramos','0',0,1,23),(3999,'\0','4312005','Mariano Moro','0',0,1,23),(4000,'\0','4314134','Paulo Bento','0',0,1,23),(4001,'\0','4314787','Ponte Preta','0',0,1,23),(4002,'\0','4315313','Quatro Irmãos','0',0,1,23),(4003,'\0','4319703','São Valentim','0',0,1,23),(4004,'\0','4320602','Severiano de Almeida','0',0,1,23),(4005,'\0','4321634','Três Arroios','0',0,1,23),(4006,'\0','4322905','Viadutos','0',0,1,23),(4007,'\0','4301800','Barracão','0',0,1,23),(4008,'\0','4303202','Cacique Doble','0',0,1,23),(4009,'\0','4309803','Ibiaçá','0',0,1,23),(4010,'\0','4311700','Machadinho','0',0,1,23),(4011,'\0','4312203','Maximiliano de Almeida','0',0,1,23),(4012,'\0','4313607','Paim Filho','0',0,1,23),(4013,'\0','4316600','Sananduva','0',0,1,23),(4014,'\0','4317954','Santo Expedito do Sul','0',0,1,23),(4015,'\0','4318424','São João da Urtiga','0',0,1,23),(4016,'\0','4318606','São José do Ouro','0',0,1,23),(4017,'\0','4322186','Tupanci do Sul','0',0,1,23),(4018,'\0','4303301','Caibaté','0',0,1,23),(4019,'\0','4303707','Campina das Missões','0',0,1,23),(4020,'\0','4305207','Cerro Largo','0',0,1,23),(4021,'\0','4309506','Guarani das Missões','0',0,1,23),(4022,'\0','4312179','Mato Queimado','0',0,1,23),(4023,'\0','4315107','Porto Xavier','0',0,1,23),(4024,'\0','4316303','Roque Gonzales','0',0,1,23),(4025,'\0','4316477','Salvador das Missões','0',0,1,23),(4026,'\0','4319307','São Paulo das Missões','0',0,1,23),(4027,'\0','4319372','São Pedro do Butiá','0',0,1,23),(4028,'\0','4320578','Sete de Setembro','0',0,1,23),(4029,'\0','4302501','Bossoroca','0',0,1,23),(4030,'\0','4305009','Catuípe','0',0,1,23),(4031,'\0','4306353','Dezesseis de Novembro','0',0,1,23),(4032,'\0','4306932','Entre-Ijuís','0',0,1,23),(4033,'\0','4307831','Eugênio de Castro','0',0,1,23),(4034,'\0','4309001','Giruá','0',0,1,23),(4035,'\0','4314555','Pirapó','0',0,1,23),(4036,'\0','4315958','Rolador','0',0,1,23),(4037,'\0','4317509','Santo Ângelo','0',0,1,23),(4038,'\0','4317707','Santo Antônio das Missões','0',0,1,23),(4039,'\0','4318903','São Luiz Gonzaga','0',0,1,23),(4040,'\0','4319158','São Miguel das Missões','0',0,1,23),(4041,'\0','4319208','São Nicolau','0',0,1,23),(4042,'\0','4320321','Senador Salgado Filho','0',0,1,23),(4043,'\0','4322343','Ubiretama','0',0,1,23),(4044,'\0','4323754','Vitória das Missões','0',0,1,23),(4045,'\0','4300208','Ajuricaba','0',0,1,23),(4046,'\0','4300455','Alegria','0',0,1,23),(4047,'\0','4301503','Augusto Pestana','0',0,1,23),(4048,'\0','4302584','Bozano','0',0,1,23),(4049,'\0','4305405','Chiapetta','0',0,1,23),(4050,'\0','4305702','Condor','0',0,1,23),(4051,'\0','4305871','Coronel Barros','0',0,1,23),(4052,'\0','4305900','Coronel Bicaco','0',0,1,23),(4053,'\0','4310207','Ijuí','0',0,1,23),(4054,'\0','4310413','Inhacorá','0',0,1,23),(4055,'\0','4313334','Nova Ramada','0',0,1,23),(4056,'\0','4313904','Panambi','0',0,1,23),(4057,'\0','4314308','Pejuçara','0',0,1,23),(4058,'\0','4317806','Santo Augusto','0',0,1,23),(4059,'\0','4319737','São Valério do Sul','0',0,1,23),(4060,'\0','4300471','Almirante Tamandaré do Sul','0',0,1,23),(4061,'\0','4301958','Barra Funda','0',0,1,23),(4062,'\0','4302154','Boa Vista das Missões','0',0,1,23),(4063,'\0','4304705','Carazinho','0',0,1,23),(4064,'\0','4305157','Cerro Grande','0',0,1,23),(4065,'\0','4305306','Chapada','0',0,1,23),(4066,'\0','4305850','Coqueiros do Sul','0',0,1,23),(4067,'\0','4310850','Jaboticaba','0',0,1,23),(4068,'\0','4311429','Lajeado do Bugre','0',0,1,23),(4069,'\0','4312955','Nova Boa Vista','0',0,1,23),(4070,'\0','4313490','Novo Barreiro','0',0,1,23),(4071,'\0','4313706','Palmeira das Missões','0',0,1,23),(4072,'\0','4314456','Pinhal','0',0,1,23),(4073,'\0','4316428','Sagrada Família','0',0,1,23),(4074,'\0','4317756','Santo Antônio do Planalto','0',0,1,23),(4075,'\0','4318457','São José das Missões','0',0,1,23),(4076,'\0','4319364','São Pedro das Missões','0',0,1,23),(4077,'\0','4320107','Sarandi','0',0,1,23),(4078,'\0','4300059','Água Santa','0',0,1,23),(4079,'\0','4303558','Camargo','0',0,1,23),(4080,'\0','4304903','Casca','0',0,1,23),(4081,'\0','4304952','Caseiros','0',0,1,23),(4082,'\0','4305371','Charrua','0',0,1,23),(4083,'\0','4305504','Ciríaco','0',0,1,23),(4084,'\0','4305975','Coxilha','0',0,1,23),(4085,'\0','4306304','David Canabarro','0',0,1,23),(4086,'\0','4307054','Ernestina','0',0,1,23),(4087,'\0','4308854','Gentil','0',0,1,23),(4088,'\0','4309902','Ibiraiaras','0',0,1,23),(4089,'\0','4311809','Marau','0',0,1,23),(4090,'\0','4312138','Mato Castelhano','0',0,1,23),(4091,'\0','4312625','Muliterno','0',0,1,23),(4092,'\0','4312674','Nicolau Vergueiro','0',0,1,23),(4093,'\0','4314100','Passo Fundo','0',0,1,23),(4094,'\0','4314779','Pontão','0',0,1,23),(4095,'\0','4316105','Ronda Alta','0',0,1,23),(4096,'\0','4316733','Santa Cecília do Sul','0',0,1,23),(4097,'\0','4317558','Santo Antônio do Palma','0',0,1,23),(4098,'\0','4318051','São Domingos do Sul','0',0,1,23),(4099,'\0','4320503','Sertão','0',0,1,23),(4100,'\0','4320909','Tapejara','0',0,1,23),(4101,'\0','4322558','Vanini','0',0,1,23),(4102,'\0','4323358','Vila Lângaro','0',0,1,23),(4103,'\0','4323408','Vila Maria','0',0,1,23),(4104,'\0','4300554','Alto Alegre','0',0,1,23),(4105,'\0','4302220','Boa Vista do Cadeado','0',0,1,23),(4106,'\0','4302238','Boa Vista do Incra','0',0,1,23),(4107,'\0','4304101','Campos Borges','0',0,1,23),(4108,'\0','4306106','Cruz Alta','0',0,1,23),(4109,'\0','4307500','Espumoso','0',0,1,23),(4110,'\0','4308458','Fortaleza dos Valos','0',0,1,23),(4111,'\0','4310009','Ibirubá','0',0,1,23),(4112,'\0','4310876','Jacuizinho','0',0,1,23),(4113,'\0','4311155','Jóia','0',0,1,23),(4114,'\0','4315354','Quinze de Novembro','0',0,1,23),(4115,'\0','4316436','Saldanha Marinho','0',0,1,23),(4116,'\0','4316451','Salto do Jacuí','0',0,1,23),(4117,'\0','4316709','Santa Bárbara do Sul','0',0,1,23),(4118,'\0','4305603','Colorado','0',0,1,23),(4119,'\0','4311270','Lagoa dos Três Cantos','0',0,1,23),(4120,'\0','4312658','Não-Me-Toque','0',0,1,23),(4121,'\0','4320305','Selbach','0',0,1,23),(4122,'\0','4321006','Tapera','0',0,1,23),(4123,'\0','4321469','Tio Hugo','0',0,1,23),(4124,'\0','4323200','Victor Graeff','0',0,1,23),(4125,'\0','4302006','Barros Cassal','0',0,1,23),(4126,'\0','4308300','Fontoura Xavier','0',0,1,23),(4127,'\0','4309951','Ibirapuitã','0',0,1,23),(4128,'\0','4311254','Lagoão','0',0,1,23),(4129,'\0','4312427','Mormaço','0',0,1,23),(4130,'\0','4318465','São José do Herval','0',0,1,23),(4131,'\0','4320800','Soledade','0',0,1,23),(4132,'\0','4322152','Tunas','0',0,1,23),(4133,'\0','4300661','André da Rocha','0',0,1,23),(4134,'\0','4300703','Anta Gorda','0',0,1,23),(4135,'\0','4301404','Arvorezinha','0',0,1,23),(4136,'\0','4306452','Dois Lajeados','0',0,1,23),(4137,'\0','4309258','Guabiju','0',0,1,23),(4138,'\0','4309407','Guaporé','0',0,1,23),(4139,'\0','4310306','Ilópolis','0',0,1,23),(4140,'\0','4310579','Itapuca','0',0,1,23),(4141,'\0','4312351','Montauri','0',0,1,23),(4142,'\0','4312757','Nova Alvorada','0',0,1,23),(4143,'\0','4312807','Nova Araçá','0',0,1,23),(4144,'\0','4312906','Nova Bassano','0',0,1,23),(4145,'\0','4313300','Nova Prata','0',0,1,23),(4146,'\0','4314001','Paraí','0',0,1,23),(4147,'\0','4315172','Protásio Alves','0',0,1,23),(4148,'\0','4315206','Putinga','0',0,1,23),(4149,'\0','4318440','São Jorge','0',0,1,23),(4150,'\0','4319711','São Valentim do Sul','0',0,1,23),(4151,'\0','4320404','Serafina Corrêa','0',0,1,23),(4152,'\0','4322350','União da Serra','0',0,1,23),(4153,'\0','4323606','Vista Alegre do Prata','0',0,1,23),(4154,'\0','4302303','Bom Jesus','0',0,1,23),(4155,'\0','4303608','Cambará do Sul','0',0,1,23),(4156,'\0','4303673','Campestre da Serra','0',0,1,23),(4157,'\0','4304622','Capão Bonito do Sul','0',0,1,23),(4158,'\0','4307401','Esmeralda','0',0,1,23),(4159,'\0','4310439','Ipê','0',0,1,23),(4160,'\0','4311122','Jaquirana','0',0,1,23),(4161,'\0','4311304','Lagoa Vermelha','0',0,1,23),(4162,'\0','4312377','Monte Alegre dos Campos','0',0,1,23),(4163,'\0','4312617','Muitos Capões','0',0,1,23),(4164,'\0','4314464','Pinhal da Serra','0',0,1,23),(4165,'\0','4318200','São Francisco de Paula','0',0,1,23),(4166,'\0','4318622','São José dos Ausentes','0',0,1,23),(4167,'\0','4322509','Vacaria','0',0,1,23),(4168,'\0','4300802','Antônio Prado','0',0,1,23),(4169,'\0','4302105','Bento Gonçalves','0',0,1,23),(4170,'\0','4302253','Boa Vista do Sul','0',0,1,23),(4171,'\0','4304804','Carlos Barbosa','0',0,1,23),(4172,'\0','4305108','Caxias do Sul','0',0,1,23),(4173,'\0','4305934','Coronel Pilar','0',0,1,23),(4174,'\0','4305959','Cotiporã','0',0,1,23),(4175,'\0','4307864','Fagundes Varela','0',0,1,23),(4176,'\0','4307906','Farroupilha','0',0,1,23),(4177,'\0','4308201','Flores da Cunha','0',0,1,23),(4178,'\0','4308607','Garibaldi','0',0,1,23),(4179,'\0','4312385','Monte Belo do Sul','0',0,1,23),(4180,'\0','4313086','Nova Pádua','0',0,1,23),(4181,'\0','4313359','Nova Roma do Sul','0',0,1,23),(4182,'\0','4317251','Santa Tereza','0',0,1,23),(4183,'\0','4319000','São Marcos','0',0,1,23),(4184,'\0','4322806','Veranópolis','0',0,1,23),(4185,'\0','4323309','Vila Flores','0',0,1,23),(4186,'\0','4304655','Capão do Cipó','0',0,1,23),(4187,'\0','4310553','Itacurubi','0',0,1,23),(4188,'\0','4311130','Jari','0',0,1,23),(4189,'\0','4311205','Júlio de Castilhos','0',0,1,23),(4190,'\0','4314472','Pinhal Grande','0',0,1,23),(4191,'\0','4315321','Quevedos','0',0,1,23),(4192,'\0','4317400','Santiago','0',0,1,23),(4193,'\0','4322202','Tupanciretã','0',0,1,23),(4194,'\0','4322376','Unistalda','0',0,1,23),(4195,'\0','4302907','Cacequi','0',0,1,23),(4196,'\0','4306379','Dilermando de Aguiar','0',0,1,23),(4197,'\0','4310538','Itaara','0',0,1,23),(4198,'\0','4311106','Jaguari','0',0,1,23),(4199,'\0','4312104','Mata','0',0,1,23),(4200,'\0','4313037','Nova Esperança do Sul','0',0,1,23),(4201,'\0','4316907','Santa Maria','0',0,1,23),(4202,'\0','4319125','São Martinho da Serra','0',0,1,23),(4203,'\0','4319406','São Pedro do Sul','0',0,1,23),(4204,'\0','4319604','São Sepé','0',0,1,23),(4205,'\0','4319802','São Vicente do Sul','0',0,1,23),(4206,'\0','4321493','Toropi','0',0,1,23),(4207,'\0','4323457','Vila Nova do Sul','0',0,1,23),(4208,'\0','4300109','Agudo','0',0,1,23),(4209,'\0','4306700','Dona Francisca','0',0,1,23),(4210,'\0','4308003','Faxinal do Soturno','0',0,1,23),(4211,'\0','4308409','Formigueiro','0',0,1,23),(4212,'\0','4310751','Ivorá','0',0,1,23),(4213,'\0','4313102','Nova Palma','0',0,1,23),(4214,'\0','4315503','Restinga Seca','0',0,1,23),(4215,'\0','4318432','São João do Polêsine','0',0,1,23),(4216,'\0','4320651','Silveira Martins','0',0,1,23),(4217,'\0','4301206','Arroio do Tigre','0',0,1,23),(4218,'\0','4304200','Candelária','0',0,1,23),(4219,'\0','4307815','Estrela Velha','0',0,1,23),(4220,'\0','4309159','Gramado Xavier','0',0,1,23),(4221,'\0','4309571','Herveiras','0',0,1,23),(4222,'\0','4309753','Ibarama','0',0,1,23),(4223,'\0','4311239','Lagoa Bonita do Sul','0',0,1,23),(4224,'\0','4312153','Mato Leitão','0',0,1,23),(4225,'\0','4314068','Passa Sete','0',0,1,23),(4226,'\0','4316808','Santa Cruz do Sul','0',0,1,23),(4227,'\0','4320263','Segredo','0',0,1,23),(4228,'\0','4320677','Sinimbu','0',0,1,23),(4229,'\0','4320701','Sobradinho','0',0,1,23),(4230,'\0','4322533','Vale do Sol','0',0,1,23),(4231,'\0','4322608','Venâncio Aires','0',0,1,23),(4232,'\0','4322707','Vera Cruz','0',0,1,23),(4233,'\0','4301008','Arroio do Meio','0',0,1,23),(4234,'\0','4302402','Bom Retiro do Sul','0',0,1,23),(4235,'\0','4302451','Boqueirão do Leão','0',0,1,23),(4236,'\0','4304614','Canudos do Vale','0',0,1,23),(4237,'\0','4304697','Capitão','0',0,1,23),(4238,'\0','4305587','Colinas','0',0,1,23),(4239,'\0','4305835','Coqueiro Baixo','0',0,1,23),(4240,'\0','4306205','Cruzeiro do Sul','0',0,1,23),(4241,'\0','4306759','Doutor Ricardo','0',0,1,23),(4242,'\0','4306809','Encantado','0',0,1,23),(4243,'\0','4307807','Estrela','0',0,1,23),(4244,'\0','4308078','Fazenda Vilanova','0',0,1,23),(4245,'\0','4308433','Forquetinha','0',0,1,23),(4246,'\0','4310363','Imigrante','0',0,1,23),(4247,'\0','4311403','Lajeado','0',0,1,23),(4248,'\0','4312054','Marques de Souza','0',0,1,23),(4249,'\0','4312609','Muçum','0',0,1,23),(4250,'\0','4313003','Nova Bréscia','0',0,1,23),(4251,'\0','4314159','Paverama','0',0,1,23),(4252,'\0','4315131','Pouso Novo','0',0,1,23),(4253,'\0','4315156','Progresso','0',0,1,23),(4254,'\0','4315453','Relvado','0',0,1,23),(4255,'\0','4315800','Roca Sales','0',0,1,23),(4256,'\0','4316758','Santa Clara do Sul','0',0,1,23),(4257,'\0','4320453','Sério','0',0,1,23),(4258,'\0','4320859','Tabaí','0',0,1,23),(4259,'\0','4321303','Taquari','0',0,1,23),(4260,'\0','4321451','Teutônia','0',0,1,23),(4261,'\0','4321626','Travesseiro','0',0,1,23),(4262,'\0','4322855','Vespasiano Correa','0',0,1,23),(4263,'\0','4323770','Westfalia','0',0,1,23),(4264,'\0','4303004','Cachoeira do Sul','0',0,1,23),(4265,'\0','4305132','Cerro Branco','0',0,1,23),(4266,'\0','4313391','Novo Cabrais','0',0,1,23),(4267,'\0','4313953','Pantano Grande','0',0,1,23),(4268,'\0','4314027','Paraíso do Sul','0',0,1,23),(4269,'\0','4314076','Passo do Sobrado','0',0,1,23),(4270,'\0','4315701','Rio Pardo','0',0,1,23),(4271,'\0','4300570','Alto Feliz','0',0,1,23),(4272,'\0','4301651','Barão','0',0,1,23),(4273,'\0','4302352','Bom Princípio','0',0,1,23),(4274,'\0','4302659','Brochier','0',0,1,23),(4275,'\0','4304689','Capela de Santana','0',0,1,23),(4276,'\0','4308102','Feliz','0',0,1,23),(4277,'\0','4309555','Harmonia','0',0,1,23),(4278,'\0','4311643','Linha Nova','0',0,1,23),(4279,'\0','4311791','Maratá','0',0,1,23),(4280,'\0','4312401','Montenegro','0',0,1,23),(4281,'\0','4314035','Pareci Novo','0',0,1,23),(4282,'\0','4314753','Poço das Antas','0',0,1,23),(4283,'\0','4314803','Portão','0',0,1,23),(4284,'\0','4316501','Salvador do Sul','0',0,1,23),(4285,'\0','4318481','São José do Hortêncio','0',0,1,23),(4286,'\0','4318614','São José do Sul','0',0,1,23),(4287,'\0','4319356','São Pedro da Serra','0',0,1,23),(4288,'\0','4319505','São Sebastião do Caí','0',0,1,23),(4289,'\0','4319752','São Vendelino','0',0,1,23),(4290,'\0','4322251','Tupandi','0',0,1,23),(4291,'\0','4322541','Vale Real','0',0,1,23),(4292,'\0','4304408','Canela','0',0,1,23),(4293,'\0','4306403','Dois Irmãos','0',0,1,23),(4294,'\0','4309100','Gramado','0',0,1,23),(4295,'\0','4310108','Igrejinha','0',0,1,23),(4296,'\0','4310801','Ivoti','0',0,1,23),(4297,'\0','4311627','Lindolfo Collor','0',0,1,23),(4298,'\0','4312476','Morro Reuter','0',0,1,23),(4299,'\0','4313201','Nova Petrópolis','0',0,1,23),(4300,'\0','4314423','Picada Café','0',0,1,23),(4301,'\0','4315149','Presidente Lucena','0',0,1,23),(4302,'\0','4315750','Riozinho','0',0,1,23),(4303,'\0','4316006','Rolante','0',0,1,23),(4304,'\0','4316956','Santa Maria do Herval','0',0,1,23),(4305,'\0','4321204','Taquara','0',0,1,23),(4306,'\0','4321709','Três Coroas','0',0,1,23),(4307,'\0','4301107','Arroio dos Ratos','0',0,1,23),(4308,'\0','4301750','Barão do Triunfo','0',0,1,23),(4309,'\0','4302709','Butiá','0',0,1,23),(4310,'\0','4305355','Charqueadas','0',0,1,23),(4311,'\0','4308805','General Câmara','0',0,1,23),(4312,'\0','4312252','Minas do Leão','0',0,1,23),(4313,'\0','4318408','São Jerônimo','0',0,1,23),(4314,'\0','4322004','Triunfo','0',0,1,23),(4315,'\0','4322525','Vale Verde','0',0,1,23),(4316,'\0','4300604','Alvorada','0',0,1,23),(4317,'\0','4300877','Araricá','0',0,1,23),(4318,'\0','4303103','Cachoeirinha','0',0,1,23),(4319,'\0','4303905','Campo Bom','0',0,1,23),(4320,'\0','4304606','Canoas','0',0,1,23),(4321,'\0','4306767','Eldorado do Sul','0',0,1,23),(4322,'\0','4307609','Estância Velha','0',0,1,23),(4323,'\0','4307708','Esteio','0',0,1,23),(4324,'\0','4309050','Glorinha','0',0,1,23),(4325,'\0','4309209','Gravataí','0',0,1,23),(4326,'\0','4309308','Guaíba','0',0,1,23),(4327,'\0','4311981','Mariana Pimentel','0',0,1,23),(4328,'\0','4313060','Nova Hartz','0',0,1,23),(4329,'\0','4313375','Nova Santa Rita','0',0,1,23),(4330,'\0','4313409','Novo Hamburgo','0',0,1,23),(4331,'\0','4314050','Parobé','0',0,1,23),(4332,'\0','4314902','Porto Alegre','0',0,1,23),(4333,'\0','4318705','São Leopoldo','0',0,1,23),(4334,'\0','4319901','Sapiranga','0',0,1,23),(4335,'\0','4320008','Sapucaia do Sul','0',0,1,23),(4336,'\0','4320552','Sertão Santana','0',0,1,23),(4337,'\0','4323002','Viamão','0',0,1,23),(4338,'\0','4301057','Arroio do Sal','0',0,1,23),(4339,'\0','4301636','Balneário Pinhal','0',0,1,23),(4340,'\0','4304630','Capão da Canoa','0',0,1,23),(4341,'\0','4304671','Capivari do Sul','0',0,1,23),(4342,'\0','4304713','Caraá','0',0,1,23),(4343,'\0','4305454','Cidreira','0',0,1,23),(4344,'\0','4306551','Dom Pedro de Alcântara','0',0,1,23),(4345,'\0','4310330','Imbé','0',0,1,23),(4346,'\0','4310652','Itati','0',0,1,23),(4347,'\0','4311734','Mampituba','0',0,1,23),(4348,'\0','4311775','Maquiné','0',0,1,23),(4349,'\0','4312443','Morrinhos do Sul','0',0,1,23),(4350,'\0','4312500','Mostardas','0',0,1,23),(4351,'\0','4313508','Osório','0',0,1,23),(4352,'\0','4313656','Palmares do Sul','0',0,1,23),(4353,'\0','4317608','Santo Antônio da Patrulha','0',0,1,23),(4354,'\0','4321352','Tavares','0',0,1,23),(4355,'\0','4321436','Terra de Areia','0',0,1,23),(4356,'\0','4321501','Torres','0',0,1,23),(4357,'\0','4321600','Tramandaí','0',0,1,23),(4358,'\0','4321667','Três Cachoeiras','0',0,1,23),(4359,'\0','4321832','Três Forquilhas','0',0,1,23),(4360,'\0','4323804','Xangri-lá','0',0,1,23),(4361,'\0','4300851','Arambaré','0',0,1,23),(4362,'\0','4301909','Barra do Ribeiro','0',0,1,23),(4363,'\0','4303509','Camaquã','0',0,1,23),(4364,'\0','4305173','Cerro Grande do Sul','0',0,1,23),(4365,'\0','4305447','Chuvisca','0',0,1,23),(4366,'\0','4306502','Dom Feliciano','0',0,1,23),(4367,'\0','4320354','Sentinela do Sul','0',0,1,23),(4368,'\0','4321105','Tapes','0',0,1,23),(4369,'\0','4300406','Alegrete','0',0,1,23),(4370,'\0','4301875','Barra do Quaraí','0',0,1,23),(4371,'\0','4308656','Garruchos','0',0,1,23),(4372,'\0','4310603','Itaqui','0',0,1,23),(4373,'\0','4311718','Maçambara','0',0,1,23),(4374,'\0','4311759','Manoel Viana','0',0,1,23),(4375,'\0','4315305','Quaraí','0',0,1,23),(4376,'\0','4318002','São Borja','0',0,1,23),(4377,'\0','4318101','São Francisco de Assis','0',0,1,23),(4378,'\0','4322400','Uruguaiana','0',0,1,23),(4379,'\0','4316402','Rosário do Sul','0',0,1,23),(4380,'\0','4316972','Santa Margarida do Sul','0',0,1,23),(4381,'\0','4317103','Santana do Livramento','0',0,1,23),(4382,'\0','4318309','São Gabriel','0',0,1,23),(4383,'\0','4300034','Aceguá','0',0,1,23),(4384,'\0','4301602','Bagé','0',0,1,23),(4385,'\0','4306601','Dom Pedrito','0',0,1,23),(4386,'\0','4309654','Hulha Negra','0',0,1,23),(4387,'\0','4311502','Lavras do Sul','0',0,1,23),(4388,'\0','4300638','Amaral Ferrador','0',0,1,23),(4389,'\0','4302808','Caçapava do Sul','0',0,1,23),(4390,'\0','4304358','Candiota','0',0,1,23),(4391,'\0','4306908','Encruzilhada do Sul','0',0,1,23),(4392,'\0','4314175','Pedras Altas','0',0,1,23),(4393,'\0','4314506','Pinheiro Machado','0',0,1,23),(4394,'\0','4314605','Piratini','0',0,1,23),(4395,'\0','4317004','Santana da Boa Vista','0',0,1,23),(4396,'\0','4301073','Arroio do Padre','0',0,1,23),(4397,'\0','4304507','Canguçu','0',0,1,23),(4398,'\0','4304663','Capão do Leão','0',0,1,23),(4399,'\0','4305124','Cerrito','0',0,1,23),(4400,'\0','4306056','Cristal','0',0,1,23),(4401,'\0','4312450','Morro Redondo','0',0,1,23),(4402,'\0','4314209','Pedro Osório','0',0,1,23),(4403,'\0','4314407','Pelotas','0',0,1,23),(4404,'\0','4318804','São Lourenço do Sul','0',0,1,23),(4405,'\0','4322327','Turuçu','0',0,1,23),(4406,'\0','4301305','Arroio Grande','0',0,1,23),(4407,'\0','4307104','Herval','0',0,1,23),(4408,'\0','4311007','Jaguarão','0',0,1,23),(4409,'\0','4305439','Chuí','0',0,1,23),(4410,'\0','4315602','Rio Grande','0',0,1,23),(4411,'\0','4317301','Santa Vitória do Palmar','0',0,1,23),(4412,'\0','4318507','São José do Norte','0',0,1,23),(4413,'\0','4200804','Anchieta','0',0,1,24),(4414,'\0','4202081','Bandeirante','0',0,1,24),(4415,'\0','4202099','Barra Bonita','0',0,1,24),(4416,'\0','4202156','Belmonte','0',0,1,24),(4417,'\0','4204905','Descanso','0',0,1,24),(4418,'\0','4205001','Dionísio Cerqueira','0',0,1,24),(4419,'\0','4206405','Guaraciaba','0',0,1,24),(4420,'\0','4206603','Guarujá do Sul','0',0,1,24),(4421,'\0','4207650','Iporã do Oeste','0',0,1,24),(4422,'\0','4208401','Itapiranga','0',0,1,24),(4423,'\0','4211009','Mondaí','0',0,1,24),(4424,'\0','4212007','Palma Sola','0',0,1,24),(4425,'\0','4212239','Paraíso','0',0,1,24),(4426,'\0','4214151','Princesa','0',0,1,24),(4427,'\0','4215075','Riqueza','0',0,1,24),(4428,'\0','4215208','Romelândia','0',0,1,24),(4429,'\0','4215554','Santa Helena','0',0,1,24),(4430,'\0','4216255','São João do Oeste','0',0,1,24),(4431,'\0','4216701','São José do Cedro','0',0,1,24),(4432,'\0','4217204','São Miguel do Oeste','0',0,1,24),(4433,'\0','4218756','Tunápolis','0',0,1,24),(4434,'\0','4200507','Águas de Chapecó','0',0,1,24),(4435,'\0','4200556','Águas Frias','0',0,1,24),(4436,'\0','4202578','Bom Jesus do Oeste','0',0,1,24),(4437,'\0','4203105','Caibi','0',0,1,24),(4438,'\0','4203501','Campo Erê','0',0,1,24),(4439,'\0','4204103','Caxambu do Sul','0',0,1,24),(4440,'\0','4204202','Chapecó','0',0,1,24),(4441,'\0','4204350','Cordilheira Alta','0',0,1,24),(4442,'\0','4204400','Coronel Freitas','0',0,1,24),(4443,'\0','4204707','Cunha Porã','0',0,1,24),(4444,'\0','4204756','Cunhataí','0',0,1,24),(4445,'\0','4205357','Flor do Sertão','0',0,1,24),(4446,'\0','4205431','Formosa do Sul','0',0,1,24),(4447,'\0','4206652','Guatambú','0',0,1,24),(4448,'\0','4207759','Iraceminha','0',0,1,24),(4449,'\0','4207858','Irati','0',0,1,24),(4450,'\0','4208955','Jardinópolis','0',0,1,24),(4451,'\0','4210506','Maravilha','0',0,1,24),(4452,'\0','4210902','Modelo','0',0,1,24),(4453,'\0','4211405','Nova Erechim','0',0,1,24),(4454,'\0','4211454','Nova Itaberaba','0',0,1,24),(4455,'\0','4211652','Novo Horizonte','0',0,1,24),(4456,'\0','4212106','Palmitos','0',0,1,24),(4457,'\0','4212908','Pinhalzinho','0',0,1,24),(4458,'\0','4213153','Planalto Alegre','0',0,1,24),(4459,'\0','4214201','Quilombo','0',0,1,24),(4460,'\0','4215356','Saltinho','0',0,1,24),(4461,'\0','4215687','Santa Terezinha do Progresso','0',0,1,24),(4462,'\0','4215695','Santiago do Sul','0',0,1,24),(4463,'\0','4215752','São Bernardino','0',0,1,24),(4464,'\0','4216008','São Carlos','0',0,1,24),(4465,'\0','4216909','São Lourenço do Oeste','0',0,1,24),(4466,'\0','4217154','São Miguel da Boa Vista','0',0,1,24),(4467,'\0','4217303','Saudades','0',0,1,24),(4468,'\0','4217550','Serra Alta','0',0,1,24),(4469,'\0','4217758','Sul Brasil','0',0,1,24),(4470,'\0','4217956','Tigrinhos','0',0,1,24),(4471,'\0','4218855','União do Oeste','0',0,1,24),(4472,'\0','4200101','Abelardo Luz','0',0,1,24),(4473,'\0','4202537','Bom Jesus','0',0,1,24),(4474,'\0','4204459','Coronel Martins','0',0,1,24),(4475,'\0','4205175','Entre Rios','0',0,1,24),(4476,'\0','4205308','Faxinal dos Guedes','0',0,1,24),(4477,'\0','4205605','Galvão','0',0,1,24),(4478,'\0','4207684','Ipuaçu','0',0,1,24),(4479,'\0','4209177','Jupiá','0',0,1,24),(4480,'\0','4209458','Lajeado Grande','0',0,1,24),(4481,'\0','4210555','Marema','0',0,1,24),(4482,'\0','4211850','Ouro Verde','0',0,1,24),(4483,'\0','4212270','Passos Maia','0',0,1,24),(4484,'\0','4213401','Ponte Serrada','0',0,1,24),(4485,'\0','4216107','São Domingos','0',0,1,24),(4486,'\0','4219101','Vargeão','0',0,1,24),(4487,'\0','4219507','Xanxerê','0',0,1,24),(4488,'\0','4219705','Xaxim','0',0,1,24),(4489,'\0','4200408','Água Doce','0',0,1,24),(4490,'\0','4201604','Arroio Trinta','0',0,1,24),(4491,'\0','4203006','Caçador','0',0,1,24),(4492,'\0','4203154','Calmon','0',0,1,24),(4493,'\0','4203907','Capinzal','0',0,1,24),(4494,'\0','4204004','Catanduvas','0',0,1,24),(4495,'\0','4205209','Erval Velho','0',0,1,24),(4496,'\0','4205506','Fraiburgo','0',0,1,24),(4497,'\0','4206702','Herval d\'Oeste','0',0,1,24),(4498,'\0','4206751','Ibiam','0',0,1,24),(4499,'\0','4206801','Ibicaré','0',0,1,24),(4500,'\0','4207577','Iomerê','0',0,1,24),(4501,'\0','4208609','Jaborá','0',0,1,24),(4502,'\0','4209003','Joaçaba','0',0,1,24),(4503,'\0','4209201','Lacerdópolis','0',0,1,24),(4504,'\0','4209706','Lebon Régis','0',0,1,24),(4505,'\0','4210035','Luzerna','0',0,1,24),(4506,'\0','4210050','Macieira','0',0,1,24),(4507,'\0','4210704','Matos Costa','0',0,1,24),(4508,'\0','4211801','Ouro','0',0,1,24),(4509,'\0','4213005','Pinheiro Preto','0',0,1,24),(4510,'\0','4214409','Rio das Antas','0',0,1,24),(4511,'\0','4215406','Salto Veloso','0',0,1,24),(4512,'\0','4217907','Tangará','0',0,1,24),(4513,'\0','4218509','Treze Tílias','0',0,1,24),(4514,'\0','4219176','Vargem Bonita','0',0,1,24),(4515,'\0','4219309','Videira','0',0,1,24),(4516,'\0','4200754','Alto Bela Vista','0',0,1,24),(4517,'\0','4201273','Arabutã','0',0,1,24),(4518,'\0','4201653','Arvoredo','0',0,1,24),(4519,'\0','4204301','Concórdia','0',0,1,24),(4520,'\0','4207601','Ipira','0',0,1,24),(4521,'\0','4207700','Ipumirim','0',0,1,24),(4522,'\0','4207809','Irani','0',0,1,24),(4523,'\0','4208005','Itá','0',0,1,24),(4524,'\0','4209854','Lindóia do Sul','0',0,1,24),(4525,'\0','4211876','Paial','0',0,1,24),(4526,'\0','4212601','Peritiba','0',0,1,24),(4527,'\0','4213104','Piratuba','0',0,1,24),(4528,'\0','4213906','Presidente Castello Branco','0',0,1,24),(4529,'\0','4217501','Seara','0',0,1,24),(4530,'\0','4219606','Xavantina','0',0,1,24),(4531,'\0','4202131','Bela Vista do Toldo','0',0,1,24),(4532,'\0','4203808','Canoinhas','0',0,1,24),(4533,'\0','4207908','Irineópolis','0',0,1,24),(4534,'\0','4208104','Itaiópolis','0',0,1,24),(4535,'\0','4210100','Mafra','0',0,1,24),(4536,'\0','4210308','Major Vieira','0',0,1,24),(4537,'\0','4211108','Monte Castelo','0',0,1,24),(4538,'\0','4212205','Papanduva','0',0,1,24),(4539,'\0','4213609','Porto União','0',0,1,24),(4540,'\0','4215679','Santa Terezinha','0',0,1,24),(4541,'\0','4218251','Timbó Grande','0',0,1,24),(4542,'\0','4218301','Três Barras','0',0,1,24),(4543,'\0','4203303','Campo Alegre','0',0,1,24),(4544,'\0','4215000','Rio Negrinho','0',0,1,24),(4545,'\0','4215802','São Bento do Sul','0',0,1,24),(4546,'\0','4201307','Araquari','0',0,1,24),(4547,'\0','4202057','Balneário Barra do Sul','0',0,1,24),(4548,'\0','4204509','Corupá','0',0,1,24),(4549,'\0','4205803','Garuva','0',0,1,24),(4550,'\0','4206504','Guaramirim','0',0,1,24),(4551,'\0','4208450','Itapoá','0',0,1,24),(4552,'\0','4208906','Jaraguá do Sul','0',0,1,24),(4553,'\0','4209102','Joinville','0',0,1,24),(4554,'\0','4210605','Massaranduba','0',0,1,24),(4555,'\0','4216206','São Francisco do Sul','0',0,1,24),(4556,'\0','4217402','Schroeder','0',0,1,24),(4557,'\0','4200051','Abdon Batista','0',0,1,24),(4558,'\0','4202875','Brunópolis','0',0,1,24),(4559,'\0','4203600','Campos Novos','0',0,1,24),(4560,'\0','4204806','Curitibanos','0',0,1,24),(4561,'\0','4205555','Frei Rogério','0',0,1,24),(4562,'\0','4211058','Monte Carlo','0',0,1,24),(4563,'\0','4213302','Ponte Alta','0',0,1,24),(4564,'\0','4213351','Ponte Alta do Norte','0',0,1,24),(4565,'\0','4215505','Santa Cecília','0',0,1,24),(4566,'\0','4216057','São Cristovão do Sul','0',0,1,24),(4567,'\0','4219150','Vargem','0',0,1,24),(4568,'\0','4219853','Zortéa','0',0,1,24),(4569,'\0','4201000','Anita Garibaldi','0',0,1,24),(4570,'\0','4202438','Bocaina do Sul','0',0,1,24),(4571,'\0','4202503','Bom Jardim da Serra','0',0,1,24),(4572,'\0','4202602','Bom Retiro','0',0,1,24),(4573,'\0','4203253','Capão Alto','0',0,1,24),(4574,'\0','4203402','Campo Belo do Sul','0',0,1,24),(4575,'\0','4204152','Celso Ramos','0',0,1,24),(4576,'\0','4204178','Cerro Negro','0',0,1,24),(4577,'\0','4204558','Correia Pinto','0',0,1,24),(4578,'\0','4209300','Lages','0',0,1,24),(4579,'\0','4211751','Otacílio Costa','0',0,1,24),(4580,'\0','4211892','Painel','0',0,1,24),(4581,'\0','4212056','Palmeira','0',0,1,24),(4582,'\0','4215059','Rio Rufino','0',0,1,24),(4583,'\0','4216503','São Joaquim','0',0,1,24),(4584,'\0','4216800','São José do Cerrito','0',0,1,24),(4585,'\0','4218905','Urubici','0',0,1,24),(4586,'\0','4218954','Urupema','0',0,1,24),(4587,'\0','4200309','Agronômica','0',0,1,24),(4588,'\0','4201901','Aurora','0',0,1,24),(4589,'\0','4202859','Braço do Trombudo','0',0,1,24),(4590,'\0','4205100','Dona Emma','0',0,1,24),(4591,'\0','4206900','Ibirama','0',0,1,24),(4592,'\0','4209151','José Boiteux','0',0,1,24),(4593,'\0','4209508','Laurentino','0',0,1,24),(4594,'\0','4209904','Lontras','0',0,1,24),(4595,'\0','4210852','Mirim Doce','0',0,1,24),(4596,'\0','4213708','Pouso Redondo','0',0,1,24),(4597,'\0','4214003','Presidente Getúlio','0',0,1,24),(4598,'\0','4214102','Presidente Nereu','0',0,1,24),(4599,'\0','4214508','Rio do Campo','0',0,1,24),(4600,'\0','4214607','Rio do Oeste','0',0,1,24),(4601,'\0','4214805','Rio do Sul','0',0,1,24),(4602,'\0','4215307','Salete','0',0,1,24),(4603,'\0','4217808','Taió','0',0,1,24),(4604,'\0','4218608','Trombudo Central','0',0,1,24),(4605,'\0','4219358','Vitor Meireles','0',0,1,24),(4606,'\0','4219408','Witmarsum','0',0,1,24),(4607,'\0','4201257','Apiúna','0',0,1,24),(4608,'\0','4201703','Ascurra','0',0,1,24),(4609,'\0','4202206','Benedito Novo','0',0,1,24),(4610,'\0','4202404','Blumenau','0',0,1,24),(4611,'\0','4202701','Botuverá','0',0,1,24),(4612,'\0','4202909','Brusque','0',0,1,24),(4613,'\0','4205159','Doutor Pedrinho','0',0,1,24),(4614,'\0','4205902','Gaspar','0',0,1,24),(4615,'\0','4206306','Guabiruba','0',0,1,24),(4616,'\0','4207502','Indaial','0',0,1,24),(4617,'\0','4210001','Luiz Alves','0',0,1,24),(4618,'\0','4213203','Pomerode','0',0,1,24),(4619,'\0','4214706','Rio dos Cedros','0',0,1,24),(4620,'\0','4215109','Rodeio','0',0,1,24),(4621,'\0','4218202','Timbó','0',0,1,24),(4622,'\0','4202008','Balneário Camboriú','0',0,1,24),(4623,'\0','4202107','Barra Velha','0',0,1,24),(4624,'\0','4202453','Bombinhas','0',0,1,24),(4625,'\0','4203204','Camboriú','0',0,1,24),(4626,'\0','4207106','Ilhota','0',0,1,24),(4627,'\0','4208203','Itajaí','0',0,1,24),(4628,'\0','4208302','Itapema','0',0,1,24),(4629,'\0','4211306','Navegantes','0',0,1,24),(4630,'\0','4212502','Penha','0',0,1,24),(4631,'\0','4212809','Balneário Piçarras','0',0,1,24),(4632,'\0','4213500','Porto Belo','0',0,1,24),(4633,'\0','4216354','São João do Itaperiú','0',0,1,24),(4634,'\0','4200200','Agrolândia','0',0,1,24),(4635,'\0','4201802','Atalanta','0',0,1,24),(4636,'\0','4204194','Chapadão do Lageado','0',0,1,24),(4637,'\0','4207403','Imbuia','0',0,1,24),(4638,'\0','4208500','Ituporanga','0',0,1,24),(4639,'\0','4212700','Petrolândia','0',0,1,24),(4640,'\0','4219200','Vidal Ramos','0',0,1,24),(4641,'\0','4200903','Angelina','0',0,1,24),(4642,'\0','4203709','Canelinha','0',0,1,24),(4643,'\0','4209805','Leoberto Leal','0',0,1,24),(4644,'\0','4210209','Major Gercino','0',0,1,24),(4645,'\0','4211504','Nova Trento','0',0,1,24),(4646,'\0','4216305','São João Batista','0',0,1,24),(4647,'\0','4218004','Tijucas','0',0,1,24),(4648,'\0','4201208','Antônio Carlos','0',0,1,24),(4649,'\0','4202305','Biguaçu','0',0,1,24),(4650,'\0','4205407','Florianópolis','0',0,1,24),(4651,'\0','4206009','Governador Celso Ramos','0',0,1,24),(4652,'\0','4211900','Palhoça','0',0,1,24),(4653,'\0','4212304','Paulo Lopes','0',0,1,24),(4654,'\0','4215703','Santo Amaro da Imperatriz','0',0,1,24),(4655,'\0','4216602','São José','0',0,1,24),(4656,'\0','4217253','São Pedro de Alcântara','0',0,1,24),(4657,'\0','4200606','Águas Mornas','0',0,1,24),(4658,'\0','4200705','Alfredo Wagner','0',0,1,24),(4659,'\0','4201109','Anitápolis','0',0,1,24),(4660,'\0','4214300','Rancho Queimado','0',0,1,24),(4661,'\0','4215901','São Bonifácio','0',0,1,24),(4662,'\0','4201505','Armazém','0',0,1,24),(4663,'\0','4202800','Braço do Norte','0',0,1,24),(4664,'\0','4203956','Capivari de Baixo','0',0,1,24),(4665,'\0','4205704','Garopaba','0',0,1,24),(4666,'\0','4206108','Grão Pará','0',0,1,24),(4667,'\0','4206207','Gravatal','0',0,1,24),(4668,'\0','4207205','Imaruí','0',0,1,24),(4669,'\0','4207304','Imbituba','0',0,1,24),(4670,'\0','4208807','Jaguaruna','0',0,1,24),(4671,'\0','4209409','Laguna','0',0,1,24),(4672,'\0','4211702','Orleans','0',0,1,24),(4673,'\0','4212403','Pedras Grandes','0',0,1,24),(4674,'\0','4214904','Rio Fortuna','0',0,1,24),(4675,'\0','4215455','Sangão','0',0,1,24),(4676,'\0','4215604','Santa Rosa de Lima','0',0,1,24),(4677,'\0','4217006','São Ludgero','0',0,1,24),(4678,'\0','4217105','São Martinho','0',0,1,24),(4679,'\0','4218400','Treze de Maio','0',0,1,24),(4680,'\0','4218707','Tubarão','0',0,1,24),(4681,'\0','4204251','Cocal do Sul','0',0,1,24),(4682,'\0','4204608','Criciúma','0',0,1,24),(4683,'\0','4205456','Forquilhinha','0',0,1,24),(4684,'\0','4207007','Içara','0',0,1,24),(4685,'\0','4209607','Lauro Muller','0',0,1,24),(4686,'\0','4211207','Morro da Fumaça','0',0,1,24),(4687,'\0','4211603','Nova Veneza','0',0,1,24),(4688,'\0','4217600','Siderópolis','0',0,1,24),(4689,'\0','4218350','Treviso','0',0,1,24),(4690,'\0','4219002','Urussanga','0',0,1,24),(4691,'\0','4201406','Araranguá','0',0,1,24),(4692,'\0','4201950','Balneário Arroio do Silva','0',0,1,24),(4693,'\0','4202073','Balneário Gaivota','0',0,1,24),(4694,'\0','4205191','Ermo','0',0,1,24),(4695,'\0','4208708','Jacinto Machado','0',0,1,24),(4696,'\0','4210407','Maracajá','0',0,1,24),(4697,'\0','4210803','Meleiro','0',0,1,24),(4698,'\0','4211256','Morro Grande','0',0,1,24),(4699,'\0','4212254','Passo de Torres','0',0,1,24),(4700,'\0','4213807','Praia Grande','0',0,1,24),(4701,'\0','4215653','Santa Rosa do Sul','0',0,1,24),(4702,'\0','4216404','São João do Sul','0',0,1,24),(4703,'\0','4217709','Sombrio','0',0,1,24),(4704,'\0','4218103','Timbé do Sul','0',0,1,24),(4705,'\0','4218806','Turvo','0',0,1,24),(4706,'\0','2801207','Canindé de São Francisco','0',0,1,25),(4707,'\0','2802205','Feira Nova','0',0,1,25),(4708,'\0','2802403','Gararu','0',0,1,25),(4709,'\0','2802601','Gracho Cardoso','0',0,1,25),(4710,'\0','2803104','Itabi','0',0,1,25),(4711,'\0','2804201','Monte Alegre de Sergipe','0',0,1,25),(4712,'\0','2804508','Nossa Senhora da Glória','0',0,1,25),(4713,'\0','2805406','Poço Redondo','0',0,1,25),(4714,'\0','2805604','Porto da Folha','0',0,1,25),(4715,'\0','2801405','Carira','0',0,1,25),(4716,'\0','2802304','Frei Paulo','0',0,1,25),(4717,'\0','2804458','Nossa Senhora Aparecida','0',0,1,25),(4718,'\0','2805000','Pedra Mole','0',0,1,25),(4719,'\0','2805208','Pinhão','0',0,1,25),(4720,'\0','2806008','Ribeirópolis','0',0,1,25),(4721,'\0','2800209','Aquidabã','0',0,1,25),(4722,'\0','2801900','Cumbe','0',0,1,25),(4723,'\0','2803807','Malhada dos Bois','0',0,1,25),(4724,'\0','2804300','Muribeca','0',0,1,25),(4725,'\0','2804607','Nossa Senhora das Dores','0',0,1,25),(4726,'\0','2807006','São Miguel do Aleixo','0',0,1,25),(4727,'\0','2800506','Areia Branca','0',0,1,25),(4728,'\0','2801009','Campo do Brito','0',0,1,25),(4729,'\0','2802908','Itabaiana','0',0,1,25),(4730,'\0','2803708','Macambira','0',0,1,25),(4731,'\0','2803906','Malhador','0',0,1,25),(4732,'\0','2804102','Moita Bonita','0',0,1,25),(4733,'\0','2806800','São Domingos','0',0,1,25),(4734,'\0','2805505','Poço Verde','0',0,1,25),(4735,'\0','2807105','Simão Dias','0',0,1,25),(4736,'\0','2807402','Tobias Barreto','0',0,1,25),(4737,'\0','2803500','Lagarto','0',0,1,25),(4738,'\0','2805802','Riachão do Dantas','0',0,1,25),(4739,'\0','2800100','Amparo de São Francisco','0',0,1,25),(4740,'\0','2800704','Brejo Grande','0',0,1,25),(4741,'\0','2801108','Canhoba','0',0,1,25),(4742,'\0','2801603','Cedro de São João','0',0,1,25),(4743,'\0','2802700','Ilha das Flores','0',0,1,25),(4744,'\0','2804409','Neópolis','0',0,1,25),(4745,'\0','2804706','Nossa Senhora de Lourdes','0',0,1,25),(4746,'\0','2805703','Propriá','0',0,1,25),(4747,'\0','2806404','Santana do São Francisco','0',0,1,25),(4748,'\0','2807303','Telha','0',0,1,25),(4749,'\0','2801306','Capela','0',0,1,25),(4750,'\0','2802007','Divina Pastora','0',0,1,25),(4751,'\0','2806503','Santa Rosa de Lima','0',0,1,25),(4752,'\0','2807204','Siriri','0',0,1,25),(4753,'\0','2803302','Japaratuba','0',0,1,25),(4754,'\0','2803401','Japoatã','0',0,1,25),(4755,'\0','2804904','Pacatuba','0',0,1,25),(4756,'\0','2805307','Pirambu','0',0,1,25),(4757,'\0','2806909','São Francisco','0',0,1,25),(4758,'\0','2801504','Carmópolis','0',0,1,25),(4759,'\0','2802502','General Maynard','0',0,1,25),(4760,'\0','2803609','Laranjeiras','0',0,1,25),(4761,'\0','2804003','Maruim','0',0,1,25),(4762,'\0','2805901','Riachuelo','0',0,1,25),(4763,'\0','2806107','Rosário do Catete','0',0,1,25),(4764,'\0','2806602','Santo Amaro das Brotas','0',0,1,25),(4765,'\0','2800308','Aracaju','0',0,1,25),(4766,'\0','2800605','Barra dos Coqueiros','0',0,1,25),(4767,'\0','2804805','Nossa Senhora do Socorro','0',0,1,25),(4768,'\0','2806701','São Cristóvão','0',0,1,25),(4769,'\0','2800407','Arauá','0',0,1,25),(4770,'\0','2800670','Boquim','0',0,1,25),(4771,'\0','2801702','Cristinápolis','0',0,1,25),(4772,'\0','2803005','Itabaianinha','0',0,1,25),(4773,'\0','2805109','Pedrinhas','0',0,1,25),(4774,'\0','2806206','Salgado','0',0,1,25),(4775,'\0','2807501','Tomar do Geru','0',0,1,25),(4776,'\0','2807600','Umbaúba','0',0,1,25),(4777,'\0','2802106','Estância','0',0,1,25),(4778,'\0','2802809','Indiaroba','0',0,1,25),(4779,'\0','2803203','Itaporanga d\'Ajuda','0',0,1,25),(4780,'\0','2806305','Santa Luzia do Itanhy','0',0,1,25),(4781,'\0','3502606','Aparecida d\'Oeste','0',0,1,26),(4782,'\0','3503950','Aspásia','0',0,1,26),(4783,'\0','3513850','Dirce Reis','0',0,1,26),(4784,'\0','3514205','Dolcinópolis','0',0,1,26),(4785,'\0','3524808','Jales','0',0,1,26),(4786,'\0','3529104','Marinópolis','0',0,1,26),(4787,'\0','3529658','Mesópolis','0',0,1,26),(4788,'\0','3532843','Nova Canaã Paulista','0',0,1,26),(4789,'\0','3535200','Palmeira d\'Oeste','0',0,1,26),(4790,'\0','3535903','Paranapuã','0',0,1,26),(4791,'\0','3540259','Pontalinda','0',0,1,26),(4792,'\0','3540408','Populina','0',0,1,26),(4793,'\0','3544509','Rubinéia','0',0,1,26),(4794,'\0','3545704','Santa Albertina','0',0,1,26),(4795,'\0','3546108','Santa Clara d\'Oeste','0',0,1,26),(4796,'\0','3546603','Santa Fé do Sul','0',0,1,26),(4797,'\0','3547205','Santana da Ponte Pensa','0',0,1,26),(4798,'\0','3547403','Santa Rita d\'Oeste','0',0,1,26),(4799,'\0','3547650','Santa Salete','0',0,1,26),(4800,'\0','3549003','São Francisco','0',0,1,26),(4801,'\0','3554904','Três Fronteiras','0',0,1,26),(4802,'\0','3555802','Urânia','0',0,1,26),(4803,'\0','3556958','Vitória Brasil','0',0,1,26),(4804,'\0','3515202','Estrela d\'Oeste','0',0,1,26),(4805,'\0','3515509','Fernandópolis','0',0,1,26),(4806,'\0','3518008','Guarani d\'Oeste','0',0,1,26),(4807,'\0','3520707','Indiaporã','0',0,1,26),(4808,'\0','3528205','Macedônia','0',0,1,26),(4809,'\0','3529609','Meridiano','0',0,1,26),(4810,'\0','3530003','Mira Estrela','0',0,1,26),(4811,'\0','3534757','Ouroeste','0',0,1,26),(4812,'\0','3536901','Pedranópolis','0',0,1,26),(4813,'\0','3549201','São João das Duas Pontes','0',0,1,26),(4814,'\0','3555307','Turmalina','0',0,1,26),(4815,'\0','3501202','Álvares Florence','0',0,1,26),(4816,'\0','3501806','Américo de Campos','0',0,1,26),(4817,'\0','3510708','Cardoso','0',0,1,26),(4818,'\0','3512902','Cosmorama','0',0,1,26),(4819,'\0','3536257','Parisi','0',0,1,26),(4820,'\0','3540309','Pontes Gestal','0',0,1,26),(4821,'\0','3544202','Riolândia','0',0,1,26),(4822,'\0','3556107','Valentim Gentil','0',0,1,26),(4823,'\0','3557105','Votuporanga','0',0,1,26),(4824,'\0','3500204','Adolfo','0',0,1,26),(4825,'\0','3500907','Altair','0',0,1,26),(4826,'\0','3504602','Bady Bassitt','0',0,1,26),(4827,'\0','3504800','Bálsamo','0',0,1,26),(4828,'\0','3511300','Cedral','0',0,1,26),(4829,'\0','3517505','Guapiaçu','0',0,1,26),(4830,'\0','3517901','Guaraci','0',0,1,26),(4831,'\0','3519402','Ibirá','0',0,1,26),(4832,'\0','3519808','Icém','0',0,1,26),(4833,'\0','3521150','Ipiguá','0',0,1,26),(4834,'\0','3524501','Jaci','0',0,1,26),(4835,'\0','3525706','José Bonifácio','0',0,1,26),(4836,'\0','3529500','Mendonça','0',0,1,26),(4837,'\0','3530300','Mirassol','0',0,1,26),(4838,'\0','3530409','Mirassolândia','0',0,1,26),(4839,'\0','3532801','Nova Aliança','0',0,1,26),(4840,'\0','3533007','Nova Granada','0',0,1,26),(4841,'\0','3533908','Olímpia','0',0,1,26),(4842,'\0','3534005','Onda Verde','0',0,1,26),(4843,'\0','3534203','Orindiúva','0',0,1,26),(4844,'\0','3535002','Palestina','0',0,1,26),(4845,'\0','3536604','Paulo de Faria','0',0,1,26),(4846,'\0','3539608','Planalto','0',0,1,26),(4847,'\0','3540804','Potirendaba','0',0,1,26),(4848,'\0','3549805','São José do Rio Preto','0',0,1,26),(4849,'\0','3553401','Tanabi','0',0,1,26),(4850,'\0','3555356','Ubarana','0',0,1,26),(4851,'\0','3555604','Uchoa','0',0,1,26),(4852,'\0','3557154','Zacarias','0',0,1,26),(4853,'\0','3503703','Ariranha','0',0,1,26),(4854,'\0','3509304','Cajobi','0',0,1,26),(4855,'\0','3511102','Catanduva','0',0,1,26),(4856,'\0','3511201','Catiguá','0',0,1,26),(4857,'\0','3514924','Elisiário','0',0,1,26),(4858,'\0','3514957','Embaúba','0',0,1,26),(4859,'\0','3533254','Novais','0',0,1,26),(4860,'\0','3535101','Palmares Paulista','0',0,1,26),(4861,'\0','3535705','Paraíso','0',0,1,26),(4862,'\0','3538105','Pindorama','0',0,1,26),(4863,'\0','3545605','Santa Adélia','0',0,1,26),(4864,'\0','3551900','Severínia','0',0,1,26),(4865,'\0','3552601','Tabapuã','0',0,1,26),(4866,'\0','3504206','Auriflama','0',0,1,26),(4867,'\0','3515905','Floreal','0',0,1,26),(4868,'\0','3516804','Gastão Vidigal','0',0,1,26),(4869,'\0','3516903','General Salgado','0',0,1,26),(4870,'\0','3518909','Guzolândia','0',0,1,26),(4871,'\0','3528304','Magda','0',0,1,26),(4872,'\0','3532868','Nova Castilho','0',0,1,26),(4873,'\0','3533304','Nova Luzitânia','0',0,1,26),(4874,'\0','3549250','São João de Iracema','0',0,1,26),(4875,'\0','3528106','Macaubal','0',0,1,26),(4876,'\0','3531001','Monções','0',0,1,26),(4877,'\0','3531407','Monte Aprazível','0',0,1,26),(4878,'\0','3532504','Neves Paulista','0',0,1,26),(4879,'\0','3532603','Nhandeara','0',0,1,26),(4880,'\0','3532702','Nipoã','0',0,1,26),(4881,'\0','3539905','Poloni','0',0,1,26),(4882,'\0','3551306','Sebastianópolis do Sul','0',0,1,26),(4883,'\0','3555703','União Paulista','0',0,1,26),(4884,'\0','3521507','Irapuã','0',0,1,26),(4885,'\0','3521903','Itajobi','0',0,1,26),(4886,'\0','3528858','Marapoama','0',0,1,26),(4887,'\0','3533502','Novo Horizonte','0',0,1,26),(4888,'\0','3544806','Sales','0',0,1,26),(4889,'\0','3556008','Urupês','0',0,1,26),(4890,'\0','3505500','Barretos','0',0,1,26),(4891,'\0','3512001','Colina','0',0,1,26),(4892,'\0','3512100','Colômbia','0',0,1,26),(4893,'\0','3517406','Guaíra','0',0,1,26),(4894,'\0','3521309','Ipuã','0',0,1,26),(4895,'\0','3524204','Jaborandi','0',0,1,26),(4896,'\0','3529708','Miguelópolis','0',0,1,26),(4897,'\0','3531902','Morro Agudo','0',0,1,26),(4898,'\0','3533601','Nuporanga','0',0,1,26),(4899,'\0','3534302','Orlândia','0',0,1,26),(4900,'\0','3544905','Sales Oliveira','0',0,1,26),(4901,'\0','3549409','São Joaquim da Barra','0',0,1,26),(4902,'\0','3503000','Aramina','0',0,1,26),(4903,'\0','3508207','Buritizal','0',0,1,26),(4904,'\0','3517703','Guará','0',0,1,26),(4905,'\0','3520103','Igarapava','0',0,1,26),(4906,'\0','3524105','Ituverava','0',0,1,26),(4907,'\0','3513207','Cristais Paulista','0',0,1,26),(4908,'\0','3516200','Franca','0',0,1,26),(4909,'\0','3523701','Itirapuã','0',0,1,26),(4910,'\0','3525409','Jeriquara','0',0,1,26),(4911,'\0','3536307','Patrocínio Paulista','0',0,1,26),(4912,'\0','3537008','Pedregulho','0',0,1,26),(4913,'\0','3542701','Restinga','0',0,1,26),(4914,'\0','3543105','Ribeirão Corrente','0',0,1,26),(4915,'\0','3543600','Rifaina','0',0,1,26),(4916,'\0','3549508','São José da Bela Vista','0',0,1,26),(4917,'\0','3506102','Bebedouro','0',0,1,26),(4918,'\0','3510104','Cândido Rodrigues','0',0,1,26),(4919,'\0','3515608','Fernando Prestes','0',0,1,26),(4920,'\0','3518602','Guariba','0',0,1,26),(4921,'\0','3524303','Jaboticabal','0',0,1,26),(4922,'\0','3531308','Monte Alto','0',0,1,26),(4923,'\0','3531506','Monte Azul Paulista','0',0,1,26),(4924,'\0','3539004','Pirangi','0',0,1,26),(4925,'\0','3539509','Pitangueiras','0',0,1,26),(4926,'\0','3546504','Santa Ernestina','0',0,1,26),(4927,'\0','3553104','Taiaçu','0',0,1,26),(4928,'\0','3553203','Taiúva','0',0,1,26),(4929,'\0','3553658','Taquaral','0',0,1,26),(4930,'\0','3553708','Taquaritinga','0',0,1,26),(4931,'\0','3554409','Terra Roxa','0',0,1,26),(4932,'\0','3556800','Viradouro','0',0,1,26),(4933,'\0','3556909','Vista Alegre do Alto','0',0,1,26),(4934,'\0','3505609','Barrinha','0',0,1,26),(4935,'\0','3507803','Brodowski','0',0,1,26),(4936,'\0','3513108','Cravinhos','0',0,1,26),(4937,'\0','3514601','Dumont','0',0,1,26),(4938,'\0','3518859','Guatapará','0',0,1,26),(4939,'\0','3525102','Jardinópolis','0',0,1,26),(4940,'\0','3527603','Luís Antônio','0',0,1,26),(4941,'\0','3540200','Pontal','0',0,1,26),(4942,'\0','3540903','Pradópolis','0',0,1,26),(4943,'\0','3543402','Ribeirão Preto','0',0,1,26),(4944,'\0','3547502','Santa Rita do Passa Quatro','0',0,1,26),(4945,'\0','3547601','Santa Rosa de Viterbo','0',0,1,26),(4946,'\0','3550902','São Simão','0',0,1,26),(4947,'\0','3551405','Serra Azul','0',0,1,26),(4948,'\0','3551504','Serrana','0',0,1,26),(4949,'\0','3551702','Sertãozinho','0',0,1,26),(4950,'\0','3501004','Altinópolis','0',0,1,26),(4951,'\0','3505906','Batatais','0',0,1,26),(4952,'\0','3509403','Cajuru','0',0,1,26),(4953,'\0','3510906','Cássia dos Coqueiros','0',0,1,26),(4954,'\0','3546256','Santa Cruz da Esperança','0',0,1,26),(4955,'\0','3547908','Santo Antônio da Alegria','0',0,1,26),(4956,'\0','3502101','Andradina','0',0,1,26),(4957,'\0','3511003','Castilho','0',0,1,26),(4958,'\0','3517802','Guaraçaí','0',0,1,26),(4959,'\0','3520442','Ilha Solteira','0',0,1,26),(4960,'\0','3523008','Itapura','0',0,1,26),(4961,'\0','3530102','Mirandópolis','0',0,1,26),(4962,'\0','3532108','Murutinga do Sul','0',0,1,26),(4963,'\0','3533205','Nova Independência','0',0,1,26),(4964,'\0','3537404','Pereira Barreto','0',0,1,26),(4965,'\0','3552304','Sud Mennucci','0',0,1,26),(4966,'\0','3552551','Suzanápolis','0',0,1,26),(4967,'\0','3502804','Araçatuba','0',0,1,26),(4968,'\0','3506201','Bento de Abreu','0',0,1,26),(4969,'\0','3518206','Guararapes','0',0,1,26),(4970,'\0','3526506','Lavínia','0',0,1,26),(4971,'\0','3544400','Rubiácea','0',0,1,26),(4972,'\0','3548054','Santo Antônio do Aracanguá','0',0,1,26),(4973,'\0','3556305','Valparaíso','0',0,1,26),(4974,'\0','3501103','Alto Alegre','0',0,1,26),(4975,'\0','3504404','Avanhandava','0',0,1,26),(4976,'\0','3505104','Barbosa','0',0,1,26),(4977,'\0','3506409','Bilac','0',0,1,26),(4978,'\0','3506508','Birigui','0',0,1,26),(4979,'\0','3507704','Braúna','0',0,1,26),(4980,'\0','3507753','Brejo Alegre','0',0,1,26),(4981,'\0','3508108','Buritama','0',0,1,26),(4982,'\0','3511904','Clementina','0',0,1,26),(4983,'\0','3512506','Coroados','0',0,1,26),(4984,'\0','3516507','Gabriel Monteiro','0',0,1,26),(4985,'\0','3517109','Glicério','0',0,1,26),(4986,'\0','3527256','Lourdes','0',0,1,26),(4987,'\0','3527702','Luiziânia','0',0,1,26),(4988,'\0','3537305','Penápolis','0',0,1,26),(4989,'\0','3537701','Piacatu','0',0,1,26),(4990,'\0','3548401','Santópolis do Aguapeí','0',0,1,26),(4991,'\0','3555208','Turiúba','0',0,1,26),(4992,'\0','3508801','Cafelândia','0',0,1,26),(4993,'\0','3517000','Getulina','0',0,1,26),(4994,'\0','3517208','Guaiçara','0',0,1,26),(4995,'\0','3517307','Guaimbê','0',0,1,26),(4996,'\0','3525805','Júlio Mesquita','0',0,1,26),(4997,'\0','3527108','Lins','0',0,1,26),(4998,'\0','3541604','Promissão','0',0,1,26),(4999,'\0','3544608','Sabino','0',0,1,26),(5000,'\0','3500709','Agudos','0',0,1,26),(5001,'\0','3503406','Arealva','0',0,1,26),(5002,'\0','3503604','Areiópolis','0',0,1,26),(5003,'\0','3504305','Avaí','0',0,1,26),(5004,'\0','3504701','Balbinos','0',0,1,26),(5005,'\0','3506003','Bauru','0',0,1,26),(5006,'\0','3507456','Borebi','0',0,1,26),(5007,'\0','3508306','Cabrália Paulista','0',0,1,26),(5008,'\0','3514502','Duartina','0',0,1,26),(5009,'\0','3518107','Guarantã','0',0,1,26),(5010,'\0','3519105','Iacanga','0',0,1,26),(5011,'\0','3526803','Lençóis Paulista','0',0,1,26),(5012,'\0','3527504','Lucianópolis','0',0,1,26),(5013,'\0','3536570','Paulistânia','0',0,1,26),(5014,'\0','3538907','Pirajuí','0',0,1,26),(5015,'\0','3539400','Piratininga','0',0,1,26),(5016,'\0','3540101','Pongaí','0',0,1,26),(5017,'\0','3541109','Presidente Alves','0',0,1,26),(5018,'\0','3542503','Reginópolis','0',0,1,26),(5019,'\0','3555505','Ubirajara','0',0,1,26),(5020,'\0','3555901','Uru','0',0,1,26),(5021,'\0','3505203','Bariri','0',0,1,26),(5022,'\0','3505302','Barra Bonita','0',0,1,26),(5023,'\0','3506805','Bocaina','0',0,1,26),(5024,'\0','3507308','Boracéia','0',0,1,26),(5025,'\0','3514106','Dois Córregos','0',0,1,26),(5026,'\0','3520004','Igaraçu do Tietê','0',0,1,26),(5027,'\0','3522000','Itaju','0',0,1,26),(5028,'\0','3522901','Itapuí','0',0,1,26),(5029,'\0','3525300','Jaú','0',0,1,26),(5030,'\0','3528007','Macatuba','0',0,1,26),(5031,'\0','3529807','Mineiros do Tietê','0',0,1,26),(5032,'\0','3536703','Pederneiras','0',0,1,26),(5033,'\0','3500550','Águas de Santa Bárbara','0',0,1,26),(5034,'\0','3503109','Arandu','0',0,1,26),(5035,'\0','3504503','Avaré','0',0,1,26),(5036,'\0','3511409','Cerqueira César','0',0,1,26),(5037,'\0','3519253','Iaras','0',0,1,26),(5038,'\0','3521804','Itaí','0',0,1,26),(5039,'\0','3523503','Itatinga','0',0,1,26),(5040,'\0','3535804','Paranapanema','0',0,1,26),(5041,'\0','3502309','Anhembi','0',0,1,26),(5042,'\0','3506904','Bofete','0',0,1,26),(5043,'\0','3507506','Botucatu','0',0,1,26),(5044,'\0','3512308','Conchas','0',0,1,26),(5045,'\0','3536109','Pardinho','0',0,1,26),(5046,'\0','3541059','Pratânia','0',0,1,26),(5047,'\0','3550100','São Manuel','0',0,1,26),(5048,'\0','3501707','Américo Brasiliense','0',0,1,26),(5049,'\0','3503208','Araraquara','0',0,1,26),(5050,'\0','3506706','Boa Esperança do Sul','0',0,1,26),(5051,'\0','3507407','Borborema','0',0,1,26),(5052,'\0','3514007','Dobrada','0',0,1,26),(5053,'\0','3516853','Gavião Peixoto','0',0,1,26),(5054,'\0','3519600','Ibitinga','0',0,1,26),(5055,'\0','3522703','Itápolis','0',0,1,26),(5056,'\0','3529302','Matão','0',0,1,26),(5057,'\0','3532058','Motuca','0',0,1,26),(5058,'\0','3532900','Nova Europa','0',0,1,26),(5059,'\0','3543709','Rincão','0',0,1,26),(5060,'\0','3546900','Santa Lúcia','0',0,1,26),(5061,'\0','3552700','Tabatinga','0',0,1,26),(5062,'\0','3554755','Trabiju','0',0,1,26),(5063,'\0','3502002','Analândia','0',0,1,26),(5064,'\0','3513702','Descalvado','0',0,1,26),(5065,'\0','3514304','Dourado','0',0,1,26),(5066,'\0','3519303','Ibaté','0',0,1,26),(5067,'\0','3542909','Ribeirão Bonito','0',0,1,26),(5068,'\0','3548906','São Carlos','0',0,1,26),(5069,'\0','3507902','Brotas','0',0,1,26),(5070,'\0','3512704','Corumbataí','0',0,1,26),(5071,'\0','3521101','Ipeúna','0',0,1,26),(5072,'\0','3523602','Itirapina','0',0,1,26),(5073,'\0','3543907','Rio Claro','0',0,1,26),(5074,'\0','3554706','Torrinha','0',0,1,26),(5075,'\0','3503307','Araras','0',0,1,26),(5076,'\0','3512209','Conchal','0',0,1,26),(5077,'\0','3512407','Cordeirópolis','0',0,1,26),(5078,'\0','3521408','Iracemápolis','0',0,1,26),(5079,'\0','3526704','Leme','0',0,1,26),(5080,'\0','3526902','Limeira','0',0,1,26),(5081,'\0','3546207','Santa Cruz da Conceição','0',0,1,26),(5082,'\0','3546702','Santa Gertrudes','0',0,1,26),(5083,'\0','3500600','Águas de São Pedro','0',0,1,26),(5084,'\0','3510401','Capivari','0',0,1,26),(5085,'\0','3511706','Charqueada','0',0,1,26),(5086,'\0','3525854','Jumirim','0',0,1,26),(5087,'\0','3530904','Mombuca','0',0,1,26),(5088,'\0','3538709','Piracicaba','0',0,1,26),(5089,'\0','3542107','Rafard','0',0,1,26),(5090,'\0','3544004','Rio das Pedras','0',0,1,26),(5091,'\0','3545159','Saltinho','0',0,1,26),(5092,'\0','3547007','Santa Maria da Serra','0',0,1,26),(5093,'\0','3550407','São Pedro','0',0,1,26),(5094,'\0','3554508','Tietê','0',0,1,26),(5095,'\0','3500303','Aguaí','0',0,1,26),(5096,'\0','3539301','Pirassununga','0',0,1,26),(5097,'\0','3540705','Porto Ferreira','0',0,1,26),(5098,'\0','3546306','Santa Cruz das Palmeiras','0',0,1,26),(5099,'\0','3500402','Águas da Prata','0',0,1,26),(5100,'\0','3508702','Caconde','0',0,1,26),(5101,'\0','3510807','Casa Branca','0',0,1,26),(5102,'\0','3513900','Divinolândia','0',0,1,26),(5103,'\0','3515186','Espírito Santo do Pinhal','0',0,1,26),(5104,'\0','3523800','Itobi','0',0,1,26),(5105,'\0','3530508','Mococa','0',0,1,26),(5106,'\0','3548104','Santo Antônio do Jardim','0',0,1,26),(5107,'\0','3549102','São João da Boa Vista','0',0,1,26),(5108,'\0','3549706','São José do Rio Pardo','0',0,1,26),(5109,'\0','3550803','São Sebastião da Grama','0',0,1,26),(5110,'\0','3553302','Tambaú','0',0,1,26),(5111,'\0','3553609','Tapiratiba','0',0,1,26),(5112,'\0','3556404','Vargem Grande do Sul','0',0,1,26),(5113,'\0','3503802','Artur Nogueira','0',0,1,26),(5114,'\0','3515152','Engenheiro Coelho','0',0,1,26),(5115,'\0','3522604','Itapira','0',0,1,26),(5116,'\0','3530706','Mogi Guaçu','0',0,1,26),(5117,'\0','3530805','Moji Mirim','0',0,1,26),(5118,'\0','3548005','Santo Antônio de Posse','0',0,1,26),(5119,'\0','3557303','Estiva Gerbi','0',0,1,26),(5120,'\0','3501608','Americana','0',0,1,26),(5121,'\0','3509502','Campinas','0',0,1,26),(5122,'\0','3512803','Cosmópolis','0',0,1,26),(5123,'\0','3514908','Elias Fausto','0',0,1,26),(5124,'\0','3519055','Holambra','0',0,1,26),(5125,'\0','3519071','Hortolândia','0',0,1,26),(5126,'\0','3520509','Indaiatuba','0',0,1,26),(5127,'\0','3524709','Jaguariúna','0',0,1,26),(5128,'\0','3531803','Monte Mor','0',0,1,26),(5129,'\0','3533403','Nova Odessa','0',0,1,26),(5130,'\0','3536505','Paulínia','0',0,1,26),(5131,'\0','3537107','Pedreira','0',0,1,26),(5132,'\0','3545803','Santa Bárbara d\'Oeste','0',0,1,26),(5133,'\0','3552403','Sumaré','0',0,1,26),(5134,'\0','3556206','Valinhos','0',0,1,26),(5135,'\0','3556701','Vinhedo','0',0,1,26),(5136,'\0','3500501','Águas de Lindóia','0',0,1,26),(5137,'\0','3501905','Amparo','0',0,1,26),(5138,'\0','3527009','Lindóia','0',0,1,26),(5139,'\0','3531209','Monte Alegre do Sul','0',0,1,26),(5140,'\0','3536802','Pedra Bela','0',0,1,26),(5141,'\0','3538204','Pinhalzinho','0',0,1,26),(5142,'\0','3551603','Serra Negra','0',0,1,26),(5143,'\0','3552106','Socorro','0',0,1,26),(5144,'\0','3514403','Dracena','0',0,1,26),(5145,'\0','3526001','Junqueirópolis','0',0,1,26),(5146,'\0','3531605','Monte Castelo','0',0,1,26),(5147,'\0','3533106','Nova Guataporanga','0',0,1,26),(5148,'\0','3534807','Ouro Verde','0',0,1,26),(5149,'\0','3535408','Panorama','0',0,1,26),(5150,'\0','3536406','Paulicéia','0',0,1,26),(5151,'\0','3547106','Santa Mercedes','0',0,1,26),(5152,'\0','3549300','São João do Pau d\'Alho','0',0,1,26),(5153,'\0','3555109','Tupi Paulista','0',0,1,26),(5154,'\0','3500105','Adamantina','0',0,1,26),(5155,'\0','3515806','Flora Rica','0',0,1,26),(5156,'\0','3516002','Flórida Paulista','0',0,1,26),(5157,'\0','3520806','Inúbia Paulista','0',0,1,26),(5158,'\0','3521606','Irapuru','0',0,1,26),(5159,'\0','3527405','Lucélia','0',0,1,26),(5160,'\0','3528908','Mariápolis','0',0,1,26),(5161,'\0','3534609','Osvaldo Cruz','0',0,1,26),(5162,'\0','3534906','Pacaembu','0',0,1,26),(5163,'\0','3536000','Parapuã','0',0,1,26),(5164,'\0','3540853','Pracinha','0',0,1,26),(5165,'\0','3543808','Rinópolis','0',0,1,26),(5166,'\0','3544707','Sagres','0',0,1,26),(5167,'\0','3545100','Salmourão','0',0,1,26),(5168,'\0','3500808','Alfredo Marcondes','0',0,1,26),(5169,'\0','3501301','Álvares Machado','0',0,1,26),(5170,'\0','3502408','Anhumas','0',0,1,26),(5171,'\0','3508900','Caiabu','0',0,1,26),(5172,'\0','3509106','Caiuá','0',0,1,26),(5173,'\0','3515129','Emilianópolis','0',0,1,26),(5174,'\0','3515301','Estrela do Norte','0',0,1,26),(5175,'\0','3515350','Euclides da Cunha Paulista','0',0,1,26),(5176,'\0','3520608','Indiana','0',0,1,26),(5177,'\0','3525607','João Ramalho','0',0,1,26),(5178,'\0','3528700','Marabá Paulista','0',0,1,26),(5179,'\0','3529203','Martinópolis','0',0,1,26),(5180,'\0','3530201','Mirante do Paranapanema','0',0,1,26),(5181,'\0','3532207','Narandiba','0',0,1,26),(5182,'\0','3538303','Piquerobi','0',0,1,26),(5183,'\0','3539202','Pirapozinho','0',0,1,26),(5184,'\0','3541208','Presidente Bernardes','0',0,1,26),(5185,'\0','3541307','Presidente Epitácio','0',0,1,26),(5186,'\0','3541406','Presidente Prudente','0',0,1,26),(5187,'\0','3541505','Presidente Venceslau','0',0,1,26),(5188,'\0','3542206','Rancharia','0',0,1,26),(5189,'\0','3542404','Regente Feijó','0',0,1,26),(5190,'\0','3543238','Ribeirão dos Índios','0',0,1,26),(5191,'\0','3544251','Rosana','0',0,1,26),(5192,'\0','3545506','Sandovalina','0',0,1,26),(5193,'\0','3547700','Santo Anastácio','0',0,1,26),(5194,'\0','3548302','Santo Expedito','0',0,1,26),(5195,'\0','3552908','Taciba','0',0,1,26),(5196,'\0','3553906','Tarabai','0',0,1,26),(5197,'\0','3554300','Teodoro Sampaio','0',0,1,26),(5198,'\0','3503356','Arco-Íris','0',0,1,26),(5199,'\0','3505807','Bastos','0',0,1,26),(5200,'\0','3519006','Herculândia','0',0,1,26),(5201,'\0','3519204','Iacri','0',0,1,26),(5202,'\0','3541802','Queiroz','0',0,1,26),(5203,'\0','3542008','Quintana','0',0,1,26),(5204,'\0','3555000','Tupã','0',0,1,26),(5205,'\0','3501400','Álvaro de Carvalho','0',0,1,26),(5206,'\0','3501509','Alvinlândia','0',0,1,26),(5207,'\0','3514700','Echaporã','0',0,1,26),(5208,'\0','3515657','Fernão','0',0,1,26),(5209,'\0','3516606','Gália','0',0,1,26),(5210,'\0','3516705','Garça','0',0,1,26),(5211,'\0','3527801','Lupércio','0',0,1,26),(5212,'\0','3529005','Marília','0',0,1,26),(5213,'\0','3533700','Ocauçu','0',0,1,26),(5214,'\0','3534104','Oriente','0',0,1,26),(5215,'\0','3534500','Oscar Bressane','0',0,1,26),(5216,'\0','3540002','Pompéia','0',0,1,26),(5217,'\0','3556602','Vera Cruz','0',0,1,26),(5218,'\0','3504008','Assis','0',0,1,26),(5219,'\0','3507209','Borá','0',0,1,26),(5220,'\0','3509809','Campos Novos Paulista','0',0,1,26),(5221,'\0','3510005','Cândido Mota','0',0,1,26),(5222,'\0','3513306','Cruzália','0',0,1,26),(5223,'\0','3516101','Florínia','0',0,1,26),(5224,'\0','3519501','Ibirarema','0',0,1,26),(5225,'\0','3519907','Iepê','0',0,1,26),(5226,'\0','3527900','Lutécia','0',0,1,26),(5227,'\0','3528809','Maracaí','0',0,1,26),(5228,'\0','3532157','Nantes','0',0,1,26),(5229,'\0','3535309','Palmital','0',0,1,26),(5230,'\0','3535507','Paraguaçu Paulista','0',0,1,26),(5231,'\0','3537156','Pedrinhas Paulista','0',0,1,26),(5232,'\0','3539707','Platina','0',0,1,26),(5233,'\0','3541703','Quatá','0',0,1,26),(5234,'\0','3553955','Tarumã','0',0,1,26),(5235,'\0','3506300','Bernardino de Campos','0',0,1,26),(5236,'\0','3510153','Canitar','0',0,1,26),(5237,'\0','3515194','Espírito Santo do Turvo','0',0,1,26),(5238,'\0','3515400','Fartura','0',0,1,26),(5239,'\0','3520905','Ipaussu','0',0,1,26),(5240,'\0','3528601','Manduri','0',0,1,26),(5241,'\0','3533809','Óleo','0',0,1,26),(5242,'\0','3534708','Ourinhos','0',0,1,26),(5243,'\0','3538808','Piraju','0',0,1,26),(5244,'\0','3543204','Ribeirão do Sul','0',0,1,26),(5245,'\0','3545407','Salto Grande','0',0,1,26),(5246,'\0','3546405','Santa Cruz do Rio Pardo','0',0,1,26),(5247,'\0','3550506','São Pedro do Turvo','0',0,1,26),(5248,'\0','3551207','Sarutaiá','0',0,1,26),(5249,'\0','3553005','Taguaí','0',0,1,26),(5250,'\0','3554201','Tejupá','0',0,1,26),(5251,'\0','3554607','Timburi','0',0,1,26),(5252,'\0','3557204','Chavantes','0',0,1,26),(5253,'\0','3505005','Barão de Antonina','0',0,1,26),(5254,'\0','3507159','Bom Sucesso de Itararé','0',0,1,26),(5255,'\0','3508009','Buri','0',0,1,26),(5256,'\0','3512605','Coronel Macedo','0',0,1,26),(5257,'\0','3521705','Itaberá','0',0,1,26),(5258,'\0','3522406','Itapeva','0',0,1,26),(5259,'\0','3522802','Itaporanga','0',0,1,26),(5260,'\0','3523206','Itararé','0',0,1,26),(5261,'\0','3532827','Nova Campina','0',0,1,26),(5262,'\0','3543501','Riversul','0',0,1,26),(5263,'\0','3553807','Taquarituba','0',0,1,26),(5264,'\0','3553856','Taquarivaí','0',0,1,26),(5265,'\0','3500758','Alambari','0',0,1,26),(5266,'\0','3502200','Angatuba','0',0,1,26),(5267,'\0','3509452','Campina do Monte Alegre','0',0,1,26),(5268,'\0','3518503','Guareí','0',0,1,26),(5269,'\0','3522307','Itapetininga','0',0,1,26),(5270,'\0','3507001','Boituva','0',0,1,26),(5271,'\0','3511508','Cerquilho','0',0,1,26),(5272,'\0','3511607','Cesário Lange','0',0,1,26),(5273,'\0','3526407','Laranjal Paulista','0',0,1,26),(5274,'\0','3537503','Pereiras','0',0,1,26),(5275,'\0','3540507','Porangaba','0',0,1,26),(5276,'\0','3541653','Quadra','0',0,1,26),(5277,'\0','3554003','Tatuí','0',0,1,26),(5278,'\0','3554656','Torre de Pedra','0',0,1,26),(5279,'\0','3502705','Apiaí','0',0,1,26),(5280,'\0','3505351','Barra do Chapéu','0',0,1,26),(5281,'\0','3510203','Capão Bonito','0',0,1,26),(5282,'\0','3517604','Guapiara','0',0,1,26),(5283,'\0','3521200','Iporanga','0',0,1,26),(5284,'\0','3522158','Itaóca','0',0,1,26),(5285,'\0','3522653','Itapirapuã Paulista','0',0,1,26),(5286,'\0','3542800','Ribeira','0',0,1,26),(5287,'\0','3543006','Ribeirão Branco','0',0,1,26),(5288,'\0','3543253','Ribeirão Grande','0',0,1,26),(5289,'\0','3519709','Ibiúna','0',0,1,26),(5290,'\0','3537800','Piedade','0',0,1,26),(5291,'\0','3537909','Pilar do Sul','0',0,1,26),(5292,'\0','3550209','São Miguel Arcanjo','0',0,1,26),(5293,'\0','3553500','Tapiraí','0',0,1,26),(5294,'\0','3501152','Alumínio','0',0,1,26),(5295,'\0','3502754','Araçariguama','0',0,1,26),(5296,'\0','3502903','Araçoiaba da Serra','0',0,1,26),(5297,'\0','3508405','Cabreúva','0',0,1,26),(5298,'\0','3510302','Capela do Alto','0',0,1,26),(5299,'\0','3521002','Iperó','0',0,1,26),(5300,'\0','3523909','Itu','0',0,1,26),(5301,'\0','3528403','Mairinque','0',0,1,26),(5302,'\0','3540606','Porto Feliz','0',0,1,26),(5303,'\0','3545209','Salto','0',0,1,26),(5304,'\0','3545308','Salto de Pirapora','0',0,1,26),(5305,'\0','3550605','São Roque','0',0,1,26),(5306,'\0','3551108','Sarapuí','0',0,1,26),(5307,'\0','3552205','Sorocaba','0',0,1,26),(5308,'\0','3557006','Votorantim','0',0,1,26),(5309,'\0','3509601','Campo Limpo Paulista','0',0,1,26),(5310,'\0','3524006','Itupeva','0',0,1,26),(5311,'\0','3525904','Jundiaí','0',0,1,26),(5312,'\0','3527306','Louveira','0',0,1,26),(5313,'\0','3556503','Várzea Paulista','0',0,1,26),(5314,'\0','3504107','Atibaia','0',0,1,26),(5315,'\0','3507100','Bom Jesus dos Perdões','0',0,1,26),(5316,'\0','3507605','Bragança Paulista','0',0,1,26),(5317,'\0','3523404','Itatiba','0',0,1,26),(5318,'\0','3525201','Jarinu','0',0,1,26),(5319,'\0','3525508','Joanópolis','0',0,1,26),(5320,'\0','3532009','Morungaba','0',0,1,26),(5321,'\0','3532405','Nazaré Paulista','0',0,1,26),(5322,'\0','3538600','Piracaia','0',0,1,26),(5323,'\0','3554953','Tuiuti','0',0,1,26),(5324,'\0','3556354','Vargem','0',0,1,26),(5325,'\0','3509700','Campos do Jordão','0',0,1,26),(5326,'\0','3531704','Monteiro Lobato','0',0,1,26),(5327,'\0','3548203','Santo Antônio do Pinhal','0',0,1,26),(5328,'\0','3548609','São Bento do Sapucaí','0',0,1,26),(5329,'\0','3508504','Caçapava','0',0,1,26),(5330,'\0','3520202','Igaratá','0',0,1,26),(5331,'\0','3524402','Jacareí','0',0,1,26),(5332,'\0','3538006','Pindamonhangaba','0',0,1,26),(5333,'\0','3546009','Santa Branca','0',0,1,26),(5334,'\0','3549904','São José dos Campos','0',0,1,26),(5335,'\0','3554102','Taubaté','0',0,1,26),(5336,'\0','3554805','Tremembé','0',0,1,26),(5337,'\0','3502507','Aparecida','0',0,1,26),(5338,'\0','3508603','Cachoeira Paulista','0',0,1,26),(5339,'\0','3509957','Canas','0',0,1,26),(5340,'\0','3513405','Cruzeiro','0',0,1,26),(5341,'\0','3518404','Guaratinguetá','0',0,1,26),(5342,'\0','3526605','Lavrinhas','0',0,1,26),(5343,'\0','3527207','Lorena','0',0,1,26),(5344,'\0','3538501','Piquete','0',0,1,26),(5345,'\0','3540754','Potim','0',0,1,26),(5346,'\0','3541901','Queluz','0',0,1,26),(5347,'\0','3544301','Roseira','0',0,1,26),(5348,'\0','3503158','Arapeí','0',0,1,26),(5349,'\0','3503505','Areias','0',0,1,26),(5350,'\0','3504909','Bananal','0',0,1,26),(5351,'\0','3549607','São José do Barreiro','0',0,1,26),(5352,'\0','3552007','Silveiras','0',0,1,26),(5353,'\0','3513603','Cunha','0',0,1,26),(5354,'\0','3524907','Jambeiro','0',0,1,26),(5355,'\0','3526308','Lagoinha','0',0,1,26),(5356,'\0','3532306','Natividade da Serra','0',0,1,26),(5357,'\0','3535606','Paraibuna','0',0,1,26),(5358,'\0','3542305','Redenção da Serra','0',0,1,26),(5359,'\0','3550001','São Luís do Paraitinga','0',0,1,26),(5360,'\0','3510500','Caraguatatuba','0',0,1,26),(5361,'\0','3520400','Ilhabela','0',0,1,26),(5362,'\0','3550704','São Sebastião','0',0,1,26),(5363,'\0','3555406','Ubatuba','0',0,1,26),(5364,'\0','3505401','Barra do Turvo','0',0,1,26),(5365,'\0','3509254','Cajati','0',0,1,26),(5366,'\0','3509908','Cananéia','0',0,1,26),(5367,'\0','3514809','Eldorado','0',0,1,26),(5368,'\0','3520301','Iguape','0',0,1,26),(5369,'\0','3520426','Ilha Comprida','0',0,1,26),(5370,'\0','3524600','Jacupiranga','0',0,1,26),(5371,'\0','3526100','Juquiá','0',0,1,26),(5372,'\0','3529906','Miracatu','0',0,1,26),(5373,'\0','3536208','Pariquera-Açu','0',0,1,26),(5374,'\0','3542602','Registro','0',0,1,26),(5375,'\0','3551801','Sete Barras','0',0,1,26),(5376,'\0','3522109','Itanhaém','0',0,1,26),(5377,'\0','3523305','Itariri','0',0,1,26),(5378,'\0','3531100','Mongaguá','0',0,1,26),(5379,'\0','3537206','Pedro de Toledo','0',0,1,26),(5380,'\0','3537602','Peruíbe','0',0,1,26),(5381,'\0','3505708','Barueri','0',0,1,26),(5382,'\0','3509205','Cajamar','0',0,1,26),(5383,'\0','3510609','Carapicuíba','0',0,1,26),(5384,'\0','3522505','Itapevi','0',0,1,26),(5385,'\0','3525003','Jandira','0',0,1,26),(5386,'\0','3534401','Osasco','0',0,1,26),(5387,'\0','3539103','Pirapora do Bom Jesus','0',0,1,26),(5388,'\0','3547304','Santana de Parnaíba','0',0,1,26),(5389,'\0','3509007','Caieiras','0',0,1,26),(5390,'\0','3516309','Francisco Morato','0',0,1,26),(5391,'\0','3516408','Franco da Rocha','0',0,1,26),(5392,'\0','3528502','Mairiporã','0',0,1,26),(5393,'\0','3503901','Arujá','0',0,1,26),(5394,'\0','3518800','Guarulhos','0',0,1,26),(5395,'\0','3546801','Santa Isabel','0',0,1,26),(5396,'\0','3513009','Cotia','0',0,1,26),(5397,'\0','3515004','Embu','0',0,1,26),(5398,'\0','3515103','Embu-Guaçu','0',0,1,26),(5399,'\0','3522208','Itapecerica da Serra','0',0,1,26),(5400,'\0','3526209','Juquitiba','0',0,1,26),(5401,'\0','3549953','São Lourenço da Serra','0',0,1,26),(5402,'\0','3552809','Taboão da Serra','0',0,1,26),(5403,'\0','3556453','Vargem Grande Paulista','0',0,1,26),(5404,'\0','3513801','Diadema','0',0,1,26),(5405,'\0','3529401','Mauá','0',0,1,26),(5406,'\0','3543303','Ribeirão Pires','0',0,1,26),(5407,'\0','3544103','Rio Grande da Serra','0',0,1,26),(5408,'\0','3547809','Santo André','0',0,1,26),(5409,'\0','3548708','São Bernardo do Campo','0',0,1,26),(5410,'\0','3548807','São Caetano do Sul','0',0,1,26),(5411,'\0','3550308','São Paulo','0',0,1,26),(5412,'\0','3506607','Biritiba-Mirim','0',0,1,26),(5413,'\0','3515707','Ferraz de Vasconcelos','0',0,1,26),(5414,'\0','3518305','Guararema','0',0,1,26),(5415,'\0','3523107','Itaquaquecetuba','0',0,1,26),(5416,'\0','3530607','Mogi das Cruzes','0',0,1,26),(5417,'\0','3539806','Poá','0',0,1,26),(5418,'\0','3545001','Salesópolis','0',0,1,26),(5419,'\0','3552502','Suzano','0',0,1,26),(5420,'\0','3506359','Bertioga','0',0,1,26),(5421,'\0','3513504','Cubatão','0',0,1,26),(5422,'\0','3518701','Guarujá','0',0,1,26),(5423,'\0','3541000','Praia Grande','0',0,1,26),(5424,'\0','3548500','Santos','0',0,1,26),(5425,'\0','3551009','São Vicente','0',0,1,26),(5426,'\0','1700301','Aguiarnópolis','0',0,1,27),(5427,'\0','1701002','Ananás','0',0,1,27),(5428,'\0','1701051','Angico','0',0,1,27),(5429,'\0','1702208','Araguatins','0',0,1,27),(5430,'\0','1702554','Augustinópolis','0',0,1,27),(5431,'\0','1702901','Axixá do Tocantins','0',0,1,27),(5432,'\0','1703800','Buriti do Tocantins','0',0,1,27),(5433,'\0','1703826','Cachoeirinha','0',0,1,27),(5434,'\0','1703891','Carrasco Bonito','0',0,1,27),(5435,'\0','1706506','Darcinópolis','0',0,1,27),(5436,'\0','1707405','Esperantina','0',0,1,27),(5437,'\0','1710706','Itaguatins','0',0,1,27),(5438,'\0','1712454','Luzinópolis','0',0,1,27),(5439,'\0','1712801','Maurilândia do Tocantins','0',0,1,27),(5440,'\0','1713809','Palmeiras do Tocantins','0',0,1,27),(5441,'\0','1714302','Nazaré','0',0,1,27),(5442,'\0','1718303','Praia Norte','0',0,1,27),(5443,'\0','1718550','Riachinho','0',0,1,27),(5444,'\0','1718808','Sampaio','0',0,1,27),(5445,'\0','1720002','Santa Terezinha do Tocantins','0',0,1,27),(5446,'\0','1720101','São Bento do Tocantins','0',0,1,27),(5447,'\0','1720200','São Miguel do Tocantins','0',0,1,27),(5448,'\0','1720309','São Sebastião do Tocantins','0',0,1,27),(5449,'\0','1720804','Sítio Novo do Tocantins','0',0,1,27),(5450,'\0','1721208','Tocantinópolis','0',0,1,27),(5451,'\0','1701309','Aragominas','0',0,1,27),(5452,'\0','1702109','Araguaína','0',0,1,27),(5453,'\0','1702158','Araguanã','0',0,1,27),(5454,'\0','1702307','Arapoema','0',0,1,27),(5455,'\0','1703008','Babaçulândia','0',0,1,27),(5456,'\0','1703057','Bandeirantes do Tocantins','0',0,1,27),(5457,'\0','1703883','Carmolândia','0',0,1,27),(5458,'\0','1705508','Colinas do Tocantins','0',0,1,27),(5459,'\0','1707702','Filadélfia','0',0,1,27),(5460,'\0','1713957','Muricilândia','0',0,1,27),(5461,'\0','1714880','Nova Olinda','0',0,1,27),(5462,'\0','1715705','Palmeirante','0',0,1,27),(5463,'\0','1716307','Pau D\'Arco','0',0,1,27),(5464,'\0','1717206','Piraquê','0',0,1,27),(5465,'\0','1718865','Santa Fé do Araguaia','0',0,1,27),(5466,'\0','1722081','Wanderlândia','0',0,1,27),(5467,'\0','1722107','Xambioá','0',0,1,27),(5468,'\0','1700251','Abreulândia','0',0,1,27),(5469,'\0','1701903','Araguacema','0',0,1,27),(5470,'\0','1703107','Barrolândia','0',0,1,27),(5471,'\0','1703206','Bernardo Sayão','0',0,1,27),(5472,'\0','1703602','Brasilândia do Tocantins','0',0,1,27),(5473,'\0','1703909','Caseara','0',0,1,27),(5474,'\0','1706001','Couto de Magalhães','0',0,1,27),(5475,'\0','1707108','Divinópolis do Tocantins','0',0,1,27),(5476,'\0','1707207','Dois Irmãos do Tocantins','0',0,1,27),(5477,'\0','1708254','Fortaleza do Tabocão','0',0,1,27),(5478,'\0','1708304','Goianorte','0',0,1,27),(5479,'\0','1709302','Guaraí','0',0,1,27),(5480,'\0','1711100','Itaporã do Tocantins','0',0,1,27),(5481,'\0','1711803','Juarina','0',0,1,27),(5482,'\0','1712504','Marianópolis do Tocantins','0',0,1,27),(5483,'\0','1713205','Miracema do Tocantins','0',0,1,27),(5484,'\0','1713304','Miranorte','0',0,1,27),(5485,'\0','1713700','Monte Santo do Tocantins','0',0,1,27),(5486,'\0','1716653','Pequizeiro','0',0,1,27),(5487,'\0','1716703','Colméia','0',0,1,27),(5488,'\0','1718402','Presidente Kennedy','0',0,1,27),(5489,'\0','1718709','Rio dos Bois','0',0,1,27),(5490,'\0','1721257','Tupirama','0',0,1,27),(5491,'\0','1721307','Tupiratins','0',0,1,27),(5492,'\0','1702000','Araguaçu','0',0,1,27),(5493,'\0','1704600','Chapada de Areia','0',0,1,27),(5494,'\0','1706100','Cristalândia','0',0,1,27),(5495,'\0','1707306','Dueré','0',0,1,27),(5496,'\0','1707553','Fátima','0',0,1,27),(5497,'\0','1708205','Formoso do Araguaia','0',0,1,27),(5498,'\0','1711902','Lagoa da Confusão','0',0,1,27),(5499,'\0','1715002','Nova Rosalândia','0',0,1,27),(5500,'\0','1715507','Oliveira de Fátima','0',0,1,27),(5501,'\0','1716109','Paraíso do Tocantins','0',0,1,27),(5502,'\0','1717503','Pium','0',0,1,27),(5503,'\0','1718451','Pugmil','0',0,1,27),(5504,'\0','1718840','Sandolândia','0',0,1,27),(5505,'\0','1700350','Aliança do Tocantins','0',0,1,27),(5506,'\0','1700707','Alvorada','0',0,1,27),(5507,'\0','1703701','Brejinho de Nazaré','0',0,1,27),(5508,'\0','1703867','Cariri do Tocantins','0',0,1,27),(5509,'\0','1706258','Crixás do Tocantins','0',0,1,27),(5510,'\0','1707652','Figueirópolis','0',0,1,27),(5511,'\0','1709500','Gurupi','0',0,1,27),(5512,'\0','1711506','Jaú do Tocantins','0',0,1,27),(5513,'\0','1715754','Palmeirópolis','0',0,1,27),(5514,'\0','1716604','Peixe','0',0,1,27),(5515,'\0','1718899','Santa Rita do Tocantins','0',0,1,27),(5516,'\0','1720259','São Salvador do Tocantins','0',0,1,27),(5517,'\0','1720853','Sucupira','0',0,1,27),(5518,'\0','1720978','Talismã','0',0,1,27),(5519,'\0','1701101','Aparecida do Rio Negro','0',0,1,27),(5520,'\0','1703305','Bom Jesus do Tocantins','0',0,1,27),(5521,'\0','1709807','Ipueiras','0',0,1,27),(5522,'\0','1712009','Lajeado','0',0,1,27),(5523,'\0','1713601','Monte do Carmo','0',0,1,27),(5524,'\0','1716505','Pedro Afonso','0',0,1,27),(5525,'\0','1718204','Porto Nacional','0',0,1,27),(5526,'\0','1718881','Santa Maria do Tocantins','0',0,1,27),(5527,'\0','1720655','Silvanópolis','0',0,1,27),(5528,'\0','1721000','Palmas','0',0,1,27),(5529,'\0','1721109','Tocantínia','0',0,1,27),(5530,'\0','1703073','Barra do Ouro','0',0,1,27),(5531,'\0','1703842','Campos Lindos','0',0,1,27),(5532,'\0','1704105','Centenário','0',0,1,27),(5533,'\0','1709005','Goiatins','0',0,1,27),(5534,'\0','1710508','Itacajá','0',0,1,27),(5535,'\0','1710904','Itapiratins','0',0,1,27),(5536,'\0','1711951','Lagoa do Tocantins','0',0,1,27),(5537,'\0','1712405','Lizarda','0',0,1,27),(5538,'\0','1712702','Mateiros','0',0,1,27),(5539,'\0','1715101','Novo Acordo','0',0,1,27),(5540,'\0','1717909','Ponte Alta do Tocantins','0',0,1,27),(5541,'\0','1718501','Recursolândia','0',0,1,27),(5542,'\0','1718758','Rio Sono','0',0,1,27),(5543,'\0','1719004','Santa Tereza do Tocantins','0',0,1,27),(5544,'\0','1720150','São Félix do Tocantins','0',0,1,27),(5545,'\0','1700400','Almas','0',0,1,27),(5546,'\0','1702406','Arraias','0',0,1,27),(5547,'\0','1702703','Aurora do Tocantins','0',0,1,27),(5548,'\0','1705102','Chapada da Natividade','0',0,1,27),(5549,'\0','1705557','Combinado','0',0,1,27),(5550,'\0','1705607','Conceição do Tocantins','0',0,1,27),(5551,'\0','1707009','Dianópolis','0',0,1,27),(5552,'\0','1712157','Lavandeira','0',0,1,27),(5553,'\0','1714203','Natividade','0',0,1,27),(5554,'\0','1715150','Novo Alegre','0',0,1,27),(5555,'\0','1715259','Novo Jardim','0',0,1,27),(5556,'\0','1716208','Paranã','0',0,1,27),(5557,'\0','1717008','Pindorama do Tocantins','0',0,1,27),(5558,'\0','1717800','Ponte Alta do Bom Jesus','0',0,1,27),(5559,'\0','1718006','Porto Alegre do Tocantins','0',0,1,27),(5560,'\0','1718659','Rio da Conceição','0',0,1,27),(5561,'\0','1718907','Santa Rosa do Tocantins','0',0,1,27),(5562,'\0','1720499','São Valério da Natividade','0',0,1,27),(5563,'\0','1720903','Taguatinga','0',0,1,27),(5564,'\0','1720937','Taipas do Tocantins','0',0,1,27);
/*!40000 ALTER TABLE `core_city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_contextGroup`
--

DROP TABLE IF EXISTS `core_contextGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_contextGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contextGroupCode` varchar(32) DEFAULT NULL,
  `contextGroupDesc` varchar(2048) DEFAULT NULL,
  `contextGroupName` varchar(128) DEFAULT NULL,
  `contextGroupType` varchar(255) DEFAULT NULL,
  `groupType` char(1) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `contextId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`contextGroupCode`),
  KEY `FKE4055AB0AFF118AB` (`contextId`),
  CONSTRAINT `FKE4055AB0AFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_contextGroup`
--

LOCK TABLES `core_contextGroup` WRITE;
/*!40000 ALTER TABLE `core_contextGroup` DISABLE KEYS */;
INSERT INTO `core_contextGroup` VALUES (1,'ADMIN',NULL,'Administradores','SYS','S',0,0,1),(2,'USER',NULL,'Usuários','SYS','A',0,0,1);
/*!40000 ALTER TABLE `core_contextGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_country`
--

DROP TABLE IF EXISTS `core_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countryCode` varchar(7) DEFAULT NULL,
  `countryName` varchar(64) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`countryCode`),
  KEY `FK96379EF6C8732260` (`operatorId`),
  CONSTRAINT `FK96379EF6C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_country`
--

LOCK TABLES `core_country` WRITE;
/*!40000 ALTER TABLE `core_country` DISABLE KEYS */;
INSERT INTO `core_country` VALUES (1,'0132','AFEGANISTAO',1),(2,'0175','ALBANIA, REPUBLICA DA',1),(3,'0230','ALEMANHA',1),(4,'0310','BURKINA FASO',1),(5,'0370','ANDORRA',1),(6,'0400','ANGOLA',1),(7,'0418','ANGUILLA',1),(8,'0434','ANTIGUA E BARBUDA',1),(9,'0477','ANTILHAS HOLANDESAS',1),(10,'0531','ARABIA SAUDITA',1),(11,'0590','ARGELIA',1),(12,'0639','ARGENTINA',1),(13,'0647','ARMENIA, REPUBLICA DA',1),(14,'0655','ARUBA',1),(15,'0698','AUSTRALIA',1),(16,'0728','AUSTRIA',1),(17,'0736','AZERBAIJAO, REPUBLICA DO',1),(18,'0779','BAHAMAS, ILHAS',1),(19,'0809','BAHREIN, ILHAS',1),(20,'0817','BANGLADESH',1),(21,'0833','BARBADOS',1),(22,'0850','BELARUS, REPUBLICA DA',1),(23,'0876','BELGICA',1),(24,'0884','BELIZE',1),(25,'0906','BERMUDAS',1),(26,'0930','MIANMAR (BIRMANIA)',1),(27,'0973','BOLIVIA, ESTADO PLURINACIONAL DA',1),(28,'0981','BOSNIA-HERZEGOVINA (REPUBLICA DA',1),(29,'1015','BOTSUANA',1),(30,'1058','BRASIL',1),(31,'1082','BRUNEI',1),(32,'1112','BULGARIA, REPUBLICA DA',1),(33,'1155','BURUNDI',1),(34,'1198','BUTAO',1),(35,'1279','CABO VERDE, REPUBLICA DE',1),(36,'1376','CAYMAN, ILHAS',1),(37,'1414','CAMBOJA',1),(38,'1457','CAMAROES',1),(39,'1490','CANADA',1),(40,'1504','GUERNSEY, ILHA DO CANAL (INCLUI',1),(41,'1508','JERSEY, ILHA DO CANAL',1),(42,'1511','CANARIAS, ILHAS',1),(43,'1538','CAZAQUISTAO, REPUBLICA DO',1),(44,'1546','CATAR',1),(45,'1589','CHILE',1),(46,'1600','CHINA, REPUBLICA POPULAR',1),(47,'1619','FORMOSA (TAIWAN)',1),(48,'1635','CHIPRE',1),(49,'1651','COCOS(KEELING), ILHAS',1),(50,'1694','COLOMBIA',1),(51,'1732','COMORES, ILHAS',1),(52,'1775','CONGO',1),(53,'1830','COOK, ILHAS',1),(54,'1872','COREIA (DO NORTE), REP.POP.DEMOC',1),(55,'1902','COREIA (DO SUL), REPUBLICA DA',1),(56,'1937','COSTA DO MARFIM',1),(57,'1953','CROACIA (REPUBLICA DA)',1),(58,'1961','COSTA RICA',1),(59,'1988','COVEITE',1),(60,'1996','CUBA',1),(61,'2291','BENIN',1),(62,'2321','DINAMARCA',1),(63,'2356','DOMINICA,ILHA',1),(64,'2399','EQUADOR',1),(65,'2402','EGITO',1),(66,'2437','ERITREIA',1),(67,'2445','EMIRADOS ARABES UNIDOS',1),(68,'2453','ESPANHA',1),(69,'2461','ESLOVENIA, REPUBLICA DA',1),(70,'2470','ESLOVACA, REPUBLICA',1),(71,'2496','ESTADOS UNIDOS',1),(72,'2518','ESTONIA, REPUBLICA DA',1),(73,'2534','ETIOPIA',1),(74,'2550','FALKLAND (ILHAS MALVINAS)',1),(75,'2593','FEROE, ILHAS',1),(76,'2674','FILIPINAS',1),(77,'2712','FINLANDIA',1),(78,'2755','FRANCA',1),(79,'2810','GABAO',1),(80,'2852','GAMBIA',1),(81,'2895','GANA',1),(82,'2917','GEORGIA, REPUBLICA DA',1),(83,'2933','GIBRALTAR',1),(84,'2976','GRANADA',1),(85,'3018','GRECIA',1),(86,'3050','GROENLANDIA',1),(87,'3093','GUADALUPE',1),(88,'3131','GUAM',1),(89,'3174','GUATEMALA',1),(90,'3255','GUIANA FRANCESA',1),(91,'3298','GUINE',1),(92,'3310','GUINE-EQUATORIAL',1),(93,'3344','GUINE-BISSAU',1),(94,'3379','GUIANA',1),(95,'3417','HAITI',1),(96,'3450','HONDURAS',1),(97,'3514','HONG KONG',1),(98,'3557','HUNGRIA, REPUBLICA DA',1),(99,'3573','IEMEN',1),(100,'3595','MAN, ILHA DE',1),(101,'3611','INDIA',1),(102,'3654','INDONESIA',1),(103,'3697','IRAQUE',1),(104,'3727','IRA, REPUBLICA ISLAMICA DO',1),(105,'3751','IRLANDA',1),(106,'3794','ISLANDIA',1),(107,'3832','ISRAEL',1),(108,'3867','ITALIA',1),(109,'3913','JAMAICA',1),(110,'3964','JOHNSTON, ILHAS',1),(111,'3999','JAPAO',1),(112,'4030','JORDANIA',1),(113,'4111','KIRIBATI',1),(114,'4200','LAOS, REP.POP.DEMOCR.DO',1),(115,'4260','LESOTO',1),(116,'4278','LETONIA, REPUBLICA DA',1),(117,'4316','LIBANO',1),(118,'4340','LIBERIA',1),(119,'4383','LIBIA',1),(120,'4405','LIECHTENSTEIN',1),(121,'4421','LITUANIA, REPUBLICA DA',1),(122,'4456','LUXEMBURGO',1),(123,'4472','MACAU',1),(124,'4499','MACEDONIA, ANT.REP.IUGOSLAVA',1),(125,'4502','MADAGASCAR',1),(126,'4525','MADEIRA, ILHA DA',1),(127,'4553','MALASIA',1),(128,'4588','MALAVI',1),(129,'4618','MALDIVAS',1),(130,'4642','MALI',1),(131,'4677','MALTA',1),(132,'4723','MARIANAS DO NORTE',1),(133,'4740','MARROCOS',1),(134,'4766','MARSHALL,ILHAS',1),(135,'4774','MARTINICA',1),(136,'4855','MAURICIO',1),(137,'4880','MAURITANIA',1),(138,'4885','MAYOTTE (ILHAS FRANCESAS)',1),(139,'4901','MIDWAY, ILHAS',1),(140,'4936','MEXICO',1),(141,'4944','MOLDAVIA, REPUBLICA DA',1),(142,'4952','MONACO',1),(143,'4979','MONGOLIA',1),(144,'4985','MONTENEGRO',1),(145,'4995','MICRONESIA',1),(146,'5010','MONTSERRAT,ILHAS',1),(147,'5053','MOCAMBIQUE',1),(148,'5070','NAMIBIA',1),(149,'5088','NAURU',1),(150,'5118','CHRISTMAS, ILHA (NAVIDAD)',1),(151,'5177','NEPAL',1),(152,'5215','NICARAGUA',1),(153,'5258','NIGER',1),(154,'5282','NIGERIA',1),(155,'5312','NIUE, ILHA',1),(156,'5355','NORFOLK, ILHA',1),(157,'5380','NORUEGA',1),(158,'5428','NOVA CALEDONIA',1),(159,'5452','PAPUA NOVA GUINE',1),(160,'5487','NOVA ZELANDIA',1),(161,'5517','VANUATU',1),(162,'5568','OMA',1),(163,'5665','PACIFICO, ILHAS DO (POSSESSAO DO',1),(164,'5738','PAISES BAIXOS (HOLANDA)',1),(165,'5754','PALAU',1),(166,'5762','PAQUISTAO',1),(167,'5800','PANAMA',1),(168,'5860','PARAGUAI',1),(169,'5894','PERU',1),(170,'5932','PITCAIRN, ILHA',1),(171,'5991','POLINESIA FRANCESA',1),(172,'6033','POLONIA, REPUBLICA DA',1),(173,'6076','PORTUGAL',1),(174,'6114','PORTO RICO',1),(175,'6238','QUENIA',1),(176,'6254','QUIRGUIZ, REPUBLICA',1),(177,'6289','REINO UNIDO',1),(178,'6408','REPUBLICA CENTRO-AFRICANA',1),(179,'6475','REPUBLICA DOMINICANA',1),(180,'6602','REUNIAO, ILHA',1),(181,'6653','ZIMBABUE',1),(182,'6700','ROMENIA',1),(183,'6750','RUANDA',1),(184,'6769','RUSSIA, FEDERACAO DA',1),(185,'6777','SALOMAO, ILHAS',1),(186,'6858','SAARA OCIDENTAL',1),(187,'6874','EL SALVADOR',1),(188,'6904','SAMOA',1),(189,'6912','SAMOA AMERICANA',1),(190,'6955','SAO CRISTOVAO E NEVES, ILHAS',1),(191,'6971','SAN MARINO',1),(192,'7005','SAO PEDRO E MIQUELON',1),(193,'7056','SAO VICENTE E GRANADINAS',1),(194,'7102','SANTA HELENA',1),(195,'7153','SANTA LUCIA',1),(196,'7200','SAO TOME E PRINCIPE, ILHAS',1),(197,'7285','SENEGAL',1),(198,'7315','SEYCHELLES',1),(199,'7358','SERRA LEOA',1),(200,'7370','SERVIA',1),(201,'7412','CINGAPURA',1),(202,'7447','SIRIA, REPUBLICA ARABE DA',1),(203,'7480','SOMALIA',1),(204,'7501','SRI LANKA',1),(205,'7544','SUAZILANDIA',1),(206,'7560','AFRICA DO SUL',1),(207,'7595','SUDAO',1),(208,'7641','SUECIA',1),(209,'7676','SUICA',1),(210,'7706','SURINAME',1),(211,'7722','TADJIQUISTAO, REPUBLICA DO',1),(212,'7765','TAILANDIA',1),(213,'7803','TANZANIA, REP.UNIDA DA',1),(214,'7820','TERRITORIO BRIT.OC.INDICO',1),(215,'7838','DJIBUTI',1),(216,'7889','CHADE',1),(217,'7919','TCHECA, REPUBLICA',1),(218,'7951','TIMOR LESTE',1),(219,'8001','TOGO',1),(220,'8052','TOQUELAU, ILHAS',1),(221,'8109','TONGA',1),(222,'8150','TRINIDAD E TOBAGO',1),(223,'8206','TUNISIA',1),(224,'8230','TURCAS E CAICOS, ILHAS',1),(225,'8249','TURCOMENISTAO, REPUBLICA DO',1),(226,'8273','TURQUIA',1),(227,'8281','TUVALU',1),(228,'8311','UCRANIA',1),(229,'8338','UGANDA',1),(230,'8451','URUGUAI',1),(231,'8478','UZBEQUISTAO, REPUBLICA DO',1),(232,'8486','VATICANO, EST.DA CIDADE DO',1),(233,'8508','VENEZUELA',1),(234,'8583','VIETNA',1),(235,'8630','VIRGENS, ILHAS (BRITANICAS)',1),(236,'8664','VIRGENS, ILHAS (E.U.A.)',1),(237,'8702','FIJI',1),(238,'8737','WAKE, ILHA',1),(239,'8885','CONGO, REPUBLICA DEMOCRATICA DO',1),(240,'8907','ZAMBIA',1);
/*!40000 ALTER TABLE `core_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_credential`
--

DROP TABLE IF EXISTS `core_credential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_credential` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credentialState` char(1) NOT NULL,
  `encription` char(1) NOT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `lastModified` datetime DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identityId` (`identityId`),
  KEY `FK695E4F77D7E1414` (`identityId`),
  CONSTRAINT `FK695E4F77D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_credential`
--

LOCK TABLES `core_credential` WRITE;
/*!40000 ALTER TABLE `core_credential` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_credential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_currency`
--

DROP TABLE IF EXISTS `core_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currencyCode` varchar(8) DEFAULT NULL,
  `currencyName` varchar(64) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `contextId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`currencyCode`),
  KEY `FK693494B1AFF118AB` (`contextId`),
  CONSTRAINT `FK693494B1AFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_currency`
--

LOCK TABLES `core_currency` WRITE;
/*!40000 ALTER TABLE `core_currency` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_entity`
--

DROP TABLE IF EXISTS `core_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_entity` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activityState` char(1) NOT NULL,
  `alias` varchar(32) DEFAULT NULL,
  `customColors` varchar(128) DEFAULT NULL,
  `customProperties` varchar(128) DEFAULT NULL,
  `customStyle` varchar(128) DEFAULT NULL,
  `entityDomain` varchar(128) DEFAULT NULL,
  `entityType` char(1) NOT NULL,
  `externalLogoUrl` varchar(128) DEFAULT NULL,
  `installDate` datetime DEFAULT NULL,
  `nature` varchar(128) DEFAULT NULL,
  `summary` varchar(1024) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `cityId` int(11) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`alias`),
  KEY `FKD6A73083522AF4AE` (`cityId`),
  KEY `FKD6A73083C8732260` (`operatorId`),
  CONSTRAINT `FKD6A73083C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FKD6A73083522AF4AE` FOREIGN KEY (`cityId`) REFERENCES `core_city` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_entity`
--

LOCK TABLES `core_entity` WRITE;
/*!40000 ALTER TABLE `core_entity` DISABLE KEYS */;
INSERT INTO `core_entity` VALUES ('0',1,'A','primecontrol.com.br','','','','','C','','2015-09-30 07:36:39','','',0,3568,1);
/*!40000 ALTER TABLE `core_entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_entityCalendar`
--

DROP TABLE IF EXISTS `core_entityCalendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_entityCalendar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `calendarCode` varchar(12) DEFAULT NULL,
  `calendarName` varchar(64) DEFAULT NULL,
  `calendarType` char(1) DEFAULT NULL,
  `duration` int(11) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`calendarCode`),
  KEY `FKECB55CE14E55E05E` (`entityId`),
  CONSTRAINT `FKECB55CE14E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_entityCalendar`
--

LOCK TABLES `core_entityCalendar` WRITE;
/*!40000 ALTER TABLE `core_entityCalendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_entityCalendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_event`
--

DROP TABLE IF EXISTS `core_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contentAsString` varchar(4096) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `nextCheckDate` datetime DEFAULT NULL,
  `publicNumber` bigint(20) NOT NULL,
  `resolution` char(1) NOT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`publicNumber`),
  KEY `FK8B1111FAC8732260` (`operatorId`),
  CONSTRAINT `FK8B1111FAC8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_event`
--

LOCK TABLES `core_event` WRITE;
/*!40000 ALTER TABLE `core_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_feature`
--

DROP TABLE IF EXISTS `core_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_feature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `constraints` varchar(128) DEFAULT NULL,
  `featureCode` varchar(32) DEFAULT NULL,
  `featureDesc` varchar(1024) DEFAULT NULL,
  `featureName` varchar(128) DEFAULT NULL,
  `featureType` char(1) DEFAULT NULL,
  `osConstraints` int(11) DEFAULT NULL,
  `policies` varchar(512) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `contextId` int(11) DEFAULT NULL,
  `contextGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`featureCode`),
  KEY `FK22C2C25660C3D3D8` (`contextGroupId`),
  KEY `FK22C2C256AFF118AB` (`contextId`),
  CONSTRAINT `FK22C2C256AFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FK22C2C25660C3D3D8` FOREIGN KEY (`contextGroupId`) REFERENCES `core_contextGroup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_feature`
--

LOCK TABLES `core_feature` WRITE;
/*!40000 ALTER TABLE `core_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_identity`
--

DROP TABLE IF EXISTS `core_identity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_identity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime DEFAULT NULL,
  `displayName` varchar(64) DEFAULT NULL,
  `identityType` char(1) NOT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `notification` char(1) NOT NULL,
  `optionalSourceAlias` varchar(20) DEFAULT NULL,
  `appellation` char(1) NOT NULL,
  `birthDate` datetime DEFAULT NULL,
  `firstName` varchar(64) DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `imageUrl` varchar(128) DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `PIN_1` varchar(20) DEFAULT NULL,
  `PIN_2` varchar(20) DEFAULT NULL,
  `PIT_1` char(1) DEFAULT NULL,
  `PIT_2` char(1) DEFAULT NULL,
  `profileUrl` varchar(128) DEFAULT NULL,
  `principal` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `principal` (`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_identity`
--

LOCK TABLES `core_identity` WRITE;
/*!40000 ALTER TABLE `core_identity` DISABLE KEYS */;
INSERT INTO `core_identity` VALUES (1,'2015-09-30 07:35:59','Everton','P',NULL,'A','','0','1969-12-31 21:00:00','Everton','N','','Arantes','','','N','N','','admin@primecontrol.com.br');
/*!40000 ALTER TABLE `core_identity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_identityContact`
--

DROP TABLE IF EXISTS `core_identityContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_identityContact` (
  `identityId` int(11) NOT NULL,
  `contactAddress` varchar(64) DEFAULT NULL,
  `contactType` char(1) NOT NULL,
  `sequence` int(11) NOT NULL,
  PRIMARY KEY (`identityId`,`sequence`),
  KEY `FKDD5B80E27D7E1414` (`identityId`),
  CONSTRAINT `FKDD5B80E27D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_identityContact`
--

LOCK TABLES `core_identityContact` WRITE;
/*!40000 ALTER TABLE `core_identityContact` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_identityContact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_identityPhone`
--

DROP TABLE IF EXISTS `core_identityPhone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_identityPhone` (
  `identityId` int(11) NOT NULL,
  `areaCode` varchar(3) DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `phoneType` char(1) NOT NULL,
  `sequence` int(11) NOT NULL,
  PRIMARY KEY (`identityId`,`sequence`),
  KEY `FKD693E2B07D7E1414` (`identityId`),
  CONSTRAINT `FKD693E2B07D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_identityPhone`
--

LOCK TABLES `core_identityPhone` WRITE;
/*!40000 ALTER TABLE `core_identityPhone` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_identityPhone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_identitydata`
--

DROP TABLE IF EXISTS `core_identitydata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_identitydata` (
  `photo` longblob,
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9B9A2608DDEEDAD6` (`id`),
  CONSTRAINT `FK9B9A2608DDEEDAD6` FOREIGN KEY (`id`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_identitydata`
--

LOCK TABLES `core_identitydata` WRITE;
/*!40000 ALTER TABLE `core_identitydata` DISABLE KEYS */;
INSERT INTO `core_identitydata` VALUES ('',1);
/*!40000 ALTER TABLE `core_identitydata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_internalenum`
--

DROP TABLE IF EXISTS `core_internalenum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_internalenum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastNumber` bigint(20) NOT NULL,
  `startNumber` int(11) NOT NULL,
  `typeName` varchar(24) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`typeName`),
  KEY `FK9E0909DE4E55E05E` (`entityId`),
  CONSTRAINT `FK9E0909DE4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_internalenum`
--

LOCK TABLES `core_internalenum` WRITE;
/*!40000 ALTER TABLE `core_internalenum` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_internalenum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_keytype1`
--

DROP TABLE IF EXISTS `core_keytype1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_keytype1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyCode` varchar(20) DEFAULT NULL,
  `keyGroup` char(1) DEFAULT NULL,
  `keyName` varchar(48) DEFAULT NULL,
  `purpose` varchar(255) DEFAULT NULL,
  `synonyms` varchar(512) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`keyCode`),
  KEY `FK65F181D8C8732260` (`operatorId`),
  CONSTRAINT `FK65F181D8C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_keytype1`
--

LOCK TABLES `core_keytype1` WRITE;
/*!40000 ALTER TABLE `core_keytype1` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_keytype1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_lead`
--

DROP TABLE IF EXISTS `core_lead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_lead` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(64) DEFAULT NULL,
  `ipAddress` varchar(39) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `principal` varchar(64) DEFAULT NULL,
  `token` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_lead`
--

LOCK TABLES `core_lead` WRITE;
/*!40000 ALTER TABLE `core_lead` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_lead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_operator`
--

DROP TABLE IF EXISTS `core_operator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_operator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operatorName` varchar(20) DEFAULT NULL,
  `defaultEncoding` varchar(20) DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `operationMode` char(1) DEFAULT NULL,
  `operatorSourceMailAddress` varchar(64) DEFAULT NULL,
  `preferredDateFormat` varchar(12) DEFAULT NULL,
  `preferredTimeFormat` varchar(12) DEFAULT NULL,
  `rfc822TimeZone` varchar(5) DEFAULT NULL,
  `operatorHostAddress` varchar(64) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorName` (`operatorName`),
  KEY `FK2912CD44E3C18E6` (`parentId`),
  CONSTRAINT `FK2912CD44E3C18E6` FOREIGN KEY (`parentId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_operator`
--

LOCK TABLES `core_operator` WRITE;
/*!40000 ALTER TABLE `core_operator` DISABLE KEYS */;
INSERT INTO `core_operator` VALUES (1,'DEFAULT','ISO-8859-1','pt_BR','L','operator@helianto.org',NULL,NULL,NULL,'http://www.helianto.org',NULL);
/*!40000 ALTER TABLE `core_operator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_parameter`
--

DROP TABLE IF EXISTS `core_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_parameter` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parameterName` varchar(48) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `parameterPattern` varchar(128) DEFAULT NULL,
  `parameterType` varchar(32) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`parameterName`),
  KEY `FKAAAA309C8732260` (`operatorId`),
  CONSTRAINT `FKAAAA309C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_parameter`
--

LOCK TABLES `core_parameter` WRITE;
/*!40000 ALTER TABLE `core_parameter` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_parameter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_privateKey`
--

DROP TABLE IF EXISTS `core_privateKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_privateKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `privateKey` varchar(2048) DEFAULT NULL,
  `credentialId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `credentialId` (`credentialId`),
  KEY `FKBF7F6A7C6B1235C6` (`credentialId`),
  CONSTRAINT `FKBF7F6A7C6B1235C6` FOREIGN KEY (`credentialId`) REFERENCES `core_credential` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_privateKey`
--

LOCK TABLES `core_privateKey` WRITE;
/*!40000 ALTER TABLE `core_privateKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_privateKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_providerAuth`
--

DROP TABLE IF EXISTS `core_providerAuth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_providerAuth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providerType` varchar(20) DEFAULT NULL,
  `providerUserId` varchar(40) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identityId` (`identityId`,`providerType`),
  KEY `FK89C24BD97D7E1414` (`identityId`),
  CONSTRAINT `FK89C24BD97D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_providerAuth`
--

LOCK TABLES `core_providerAuth` WRITE;
/*!40000 ALTER TABLE `core_providerAuth` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_providerAuth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_province`
--

DROP TABLE IF EXISTS `core_province`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_province` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` char(1) NOT NULL,
  `provinceCode` varchar(12) DEFAULT NULL,
  `provinceName` varchar(32) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`provinceCode`),
  KEY `FKC0CCFD0C8732260` (`operatorId`),
  KEY `FKC0CCFD09122BE2A` (`countryId`),
  KEY `FKC0CCFD0F1361B72` (`parentId`),
  CONSTRAINT `FKC0CCFD0F1361B72` FOREIGN KEY (`parentId`) REFERENCES `core_province` (`id`),
  CONSTRAINT `FKC0CCFD09122BE2A` FOREIGN KEY (`countryId`) REFERENCES `core_country` (`id`),
  CONSTRAINT `FKC0CCFD0C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_province`
--

LOCK TABLES `core_province` WRITE;
/*!40000 ALTER TABLE `core_province` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_province` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_public`
--

DROP TABLE IF EXISTS `core_public`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_public` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(32) DEFAULT NULL,
  `address3` varchar(32) DEFAULT NULL,
  `addressClassifier` varchar(10) DEFAULT NULL,
  `addressDetail` varchar(24) DEFAULT NULL,
  `addressNumber` varchar(8) DEFAULT NULL,
  `cityName` varchar(64) DEFAULT NULL,
  `postOfficeBox` varchar(10) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `entityAlias` varchar(32) DEFAULT NULL,
  `entityName` varchar(128) DEFAULT NULL,
  `mainEmail` varchar(40) DEFAULT NULL,
  `areaCode` varchar(3) DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `phoneType` char(1) NOT NULL,
  `nature` varchar(128) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `autoNumber` bit(1) DEFAULT NULL,
  `internalNumber` bigint(20) DEFAULT NULL,
  `parsedContent` varchar(512) DEFAULT NULL,
  `cityId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `publicEntityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`entityAlias`,`type`),
  KEY `FKE9C6FF0939B8A3D0` (`publicEntityId`),
  KEY `FKE9C6FF095434C220` (`stateId`),
  KEY `FKE9C6FF094E55E05E` (`entityId`),
  KEY `FKE9C6FF09522AF4AE` (`cityId`),
  CONSTRAINT `FKE9C6FF09522AF4AE` FOREIGN KEY (`cityId`) REFERENCES `core_city` (`id`),
  CONSTRAINT `FKE9C6FF0939B8A3D0` FOREIGN KEY (`publicEntityId`) REFERENCES `core_public` (`id`),
  CONSTRAINT `FKE9C6FF094E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FKE9C6FF095434C220` FOREIGN KEY (`stateId`) REFERENCES `core_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_public`
--

LOCK TABLES `core_public` WRITE;
/*!40000 ALTER TABLE `core_public` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_public` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_publicEntityKey`
--

DROP TABLE IF EXISTS `core_publicEntityKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_publicEntityKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyValue` varchar(20) DEFAULT NULL,
  `keyTypeId` int(11) DEFAULT NULL,
  `publicEntityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `publicEntityId` (`publicEntityId`,`keyTypeId`),
  KEY `FKBE8A8E7398E3BA90` (`keyTypeId`),
  KEY `FKBE8A8E7339B8A3D0` (`publicEntityId`),
  CONSTRAINT `FKBE8A8E7339B8A3D0` FOREIGN KEY (`publicEntityId`) REFERENCES `core_public` (`id`),
  CONSTRAINT `FKBE8A8E7398E3BA90` FOREIGN KEY (`keyTypeId`) REFERENCES `core_keytype1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_publicEntityKey`
--

LOCK TABLES `core_publicEntityKey` WRITE;
/*!40000 ALTER TABLE `core_publicEntityKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_publicEntityKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_publicaddress`
--

DROP TABLE IF EXISTS `core_publicaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_publicaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(32) DEFAULT NULL,
  `address3` varchar(32) DEFAULT NULL,
  `addressClassifier` varchar(10) DEFAULT NULL,
  `addressDetail` varchar(24) DEFAULT NULL,
  `addressNumber` varchar(8) DEFAULT NULL,
  `cityName` varchar(64) DEFAULT NULL,
  `postOfficeBox` varchar(10) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `cityId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`postalCode`),
  KEY `FK59AE50CB5434C220` (`stateId`),
  KEY `FK59AE50CB522AF4AE` (`cityId`),
  KEY `FK59AE50CBC8732260` (`operatorId`),
  CONSTRAINT `FK59AE50CBC8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FK59AE50CB522AF4AE` FOREIGN KEY (`cityId`) REFERENCES `core_city` (`id`),
  CONSTRAINT `FK59AE50CB5434C220` FOREIGN KEY (`stateId`) REFERENCES `core_state` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_publicaddress`
--

LOCK TABLES `core_publicaddress` WRITE;
/*!40000 ALTER TABLE `core_publicaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_publicaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_publicenum`
--

DROP TABLE IF EXISTS `core_publicenum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_publicenum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastNumber` bigint(20) NOT NULL,
  `startNumber` int(11) NOT NULL,
  `typeName` varchar(24) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`typeName`),
  KEY `FKA0DDE78AC8732260` (`operatorId`),
  CONSTRAINT `FKA0DDE78AC8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_publicenum`
--

LOCK TABLES `core_publicenum` WRITE;
/*!40000 ALTER TABLE `core_publicenum` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_publicenum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_reset`
--

DROP TABLE IF EXISTS `core_reset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_reset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expirationDate` datetime DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `resetToken` varchar(256) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `identitySecurityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `resetToken` (`resetToken`),
  KEY `FK8BC0BCAF8AE68DB4` (`identitySecurityId`),
  CONSTRAINT `FK8BC0BCAF8AE68DB4` FOREIGN KEY (`identitySecurityId`) REFERENCES `core_security` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_reset`
--

LOCK TABLES `core_reset` WRITE;
/*!40000 ALTER TABLE `core_reset` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_reset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_secret`
--

DROP TABLE IF EXISTS `core_secret`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_secret` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credentialState` varchar(20) DEFAULT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `identityKey` varchar(40) DEFAULT NULL,
  `identitySecret` varchar(60) DEFAULT NULL,
  `lastModified` datetime DEFAULT NULL,
  `version` int(11) NOT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identityKey` (`identityKey`),
  KEY `FKEE049B507D7E1414` (`identityId`),
  CONSTRAINT `FKEE049B507D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_secret`
--

LOCK TABLES `core_secret` WRITE;
/*!40000 ALTER TABLE `core_secret` DISABLE KEYS */;
INSERT INTO `core_secret` VALUES (1,'ACTIVE',NULL,'admin@winnect.com.br','$2a$10$ko.oFyzNm9LErKOqUAK2peDP1trPe/qxv6vs2Nbk9ABkHs47Ys6Ru',NULL,0,1);
/*!40000 ALTER TABLE `core_secret` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_security`
--

DROP TABLE IF EXISTS `core_security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_security` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `consumerKey` varchar(40) DEFAULT NULL,
  `consumerSecret` varchar(60) DEFAULT NULL,
  `credentialState` char(1) NOT NULL,
  `expirationDate` datetime DEFAULT NULL,
  `lastModified` datetime DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL,
  `providerType` varchar(12) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `identityId` (`identityId`,`providerType`),
  UNIQUE KEY `consumerKey` (`consumerKey`),
  KEY `FK7F7B1BE07D7E1414` (`identityId`),
  CONSTRAINT `FK7F7B1BE07D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_security`
--

LOCK TABLES `core_security` WRITE;
/*!40000 ALTER TABLE `core_security` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_security` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_serv`
--

DROP TABLE IF EXISTS `core_serv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_serv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` tinyint(4) NOT NULL,
  `requiredEncription` char(1) NOT NULL,
  `serverDesc` varchar(64) DEFAULT NULL,
  `serverHostAddress` varchar(64) DEFAULT NULL,
  `serverName` varchar(20) DEFAULT NULL,
  `serverPort` int(11) NOT NULL,
  `serverState` char(1) NOT NULL,
  `serverType` char(1) NOT NULL,
  `credentialId` int(11) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`serverName`),
  KEY `FKA169C4B66B1235C6` (`credentialId`),
  KEY `FKA169C4B6C8732260` (`operatorId`),
  CONSTRAINT `FKA169C4B6C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FKA169C4B66B1235C6` FOREIGN KEY (`credentialId`) REFERENCES `core_credential` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_serv`
--

LOCK TABLES `core_serv` WRITE;
/*!40000 ALTER TABLE `core_serv` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_serv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_service`
--

DROP TABLE IF EXISTS `core_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serviceExtensions` varchar(72) DEFAULT NULL,
  `serviceName` varchar(12) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`serviceName`),
  KEY `FKD3640E15C8732260` (`operatorId`),
  CONSTRAINT `FKD3640E15C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_service`
--

LOCK TABLES `core_service` WRITE;
/*!40000 ALTER TABLE `core_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_signup`
--

DROP TABLE IF EXISTS `core_signup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_signup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cityId` int(11) DEFAULT NULL,
  `contextId` int(11) DEFAULT NULL,
  `domain` varchar(128) DEFAULT NULL,
  `entityAliasSource` varchar(128) DEFAULT NULL,
  `firstName` varchar(128) DEFAULT NULL,
  `identityId` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `lastName` varchar(128) DEFAULT NULL,
  `licenseAccepted` bit(1) DEFAULT NULL,
  `principal` varchar(64) NOT NULL,
  `token` varchar(36) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`principal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_signup`
--

LOCK TABLES `core_signup` WRITE;
/*!40000 ALTER TABLE `core_signup` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_signup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_state`
--

DROP TABLE IF EXISTS `core_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` char(1) NOT NULL,
  `stateCode` varchar(12) DEFAULT NULL,
  `stateName` varchar(64) DEFAULT NULL,
  `contextId` int(11) DEFAULT NULL,
  `countryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`stateCode`),
  KEY `FK8BD563F1AFF118AB` (`contextId`),
  KEY `FK8BD563F19122BE2A` (`countryId`),
  CONSTRAINT `FK8BD563F19122BE2A` FOREIGN KEY (`countryId`) REFERENCES `core_country` (`id`),
  CONSTRAINT `FK8BD563F1AFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_state`
--

LOCK TABLES `core_state` WRITE;
/*!40000 ALTER TABLE `core_state` DISABLE KEYS */;
INSERT INTO `core_state` VALUES (1,'\0','AC','Acre',1,30),(2,'\0','AL','Alagoas',1,30),(3,'\0','AM','Amazonas',1,30),(4,'\0','AP','Amapá',1,30),(5,'\0','BA','Bahia',1,30),(6,'\0','CE','Ceará',1,30),(7,'\0','DF','Distrito Federal',1,30),(8,'\0','ES','Espírito Santo',1,30),(9,'\0','GO','Goiás',1,30),(10,'\0','MA','Maranhão',1,30),(11,'\0','MG','Minas Gerais',1,30),(12,'\0','MS','Mato Grosso do Sul',1,30),(13,'\0','MT','Mato Grosso',1,30),(14,'\0','PA','Pará',1,30),(15,'\0','PB','Paraíba',1,30),(16,'\0','PE','Pernambuco',1,30),(17,'\0','PI','Piaui',1,30),(18,'\0','PR','Paraná',1,30),(19,'\0','RJ','Rio de Janeiro',1,30),(20,'\0','RN','Rio Grande do Norte',1,30),(21,'\0','RO','Rondônia',1,30),(22,'\0','RR','Roraima',1,30),(23,'\0','RS','Rio Grande do Sul',1,30),(24,'\0','SC','Santa Catarina',1,30),(25,'\0','SE','Sergipe',1,30),(26,'\0','SP','São Paulo',1,30),(27,'\0','TO','Tocantins',1,30);
/*!40000 ALTER TABLE `core_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_unit2`
--

DROP TABLE IF EXISTS `core_unit2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_unit2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nature` varchar(32) DEFAULT NULL,
  `priority` char(1) NOT NULL,
  `unitCode` varchar(20) DEFAULT NULL,
  `unitName` varchar(64) DEFAULT NULL,
  `unitSymbol` varchar(20) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`unitCode`),
  KEY `FK8BEEF68E4E55E05E` (`entityId`),
  CONSTRAINT `FK8BEEF68E4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_unit2`
--

LOCK TABLES `core_unit2` WRITE;
/*!40000 ALTER TABLE `core_unit2` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_unit2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_user`
--

DROP TABLE IF EXISTS `core_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_user` (
  `type` char(1) NOT NULL,
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `accountNonExpired` bit(1) NOT NULL,
  `lastEvent` datetime DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `minimalEducationRequirement` int(11) NOT NULL,
  `minimalExperienceRequirement` int(11) NOT NULL,
  `nature` varchar(128) DEFAULT NULL,
  `scriptItems` varchar(255) DEFAULT NULL,
  `userDesc` varchar(512) DEFAULT NULL,
  `jobId` int(11) DEFAULT NULL,
  `jobTitle` varchar(64) DEFAULT NULL,
  `jobType` varchar(12) DEFAULT NULL,
  `userKey` varchar(40) DEFAULT NULL,
  `userName` varchar(64) DEFAULT NULL,
  `userState` char(1) DEFAULT NULL,
  `userType` char(1) DEFAULT NULL,
  `initials` varchar(4) DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `identityId` int(11) DEFAULT NULL,
  `partnerRegistryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `entityId` (`entityId`,`userKey`),
  KEY `FKA16AE06B7D7E1414` (`identityId`),
  KEY `FKA16AE06BB9863F04` (`partnerRegistryId`),
  KEY `FKA16AE06B4E55E05E` (`entityId`),
  KEY `FKA16AE06B36509C94` (`categoryId`),
  CONSTRAINT `FKA16AE06B36509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FKA16AE06B4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FKA16AE06B7D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FKA16AE06BB9863F04` FOREIGN KEY (`partnerRegistryId`) REFERENCES `core_public` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_user`
--

LOCK TABLES `core_user` WRITE;
/*!40000 ALTER TABLE `core_user` DISABLE KEYS */;
INSERT INTO `core_user` VALUES ('G',1,0,'','2015-09-30 07:38:09',NULL,0,0,'','','',NULL,NULL,NULL,'ADMIN','Administradores','A','S',NULL,NULL,1,NULL,NULL,NULL),('G',2,0,'','2015-09-30 07:38:29',NULL,0,0,'','','',NULL,NULL,NULL,'USER','Usuários','A','A',NULL,NULL,1,NULL,NULL,NULL),('U',3,5,'\0','2015-09-30 14:06:42',NULL,0,0,'','','',NULL,NULL,NULL,'admin@primecontrol.com.br','Everton Arantes','A','I',NULL,'0',1,NULL,1,NULL);
/*!40000 ALTER TABLE `core_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userKey`
--

DROP TABLE IF EXISTS `core_userKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_userKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyValue` varchar(20) DEFAULT NULL,
  `keyTypeId` int(11) DEFAULT NULL,
  `userGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userGroupId` (`userGroupId`,`keyTypeId`),
  KEY `FK545AE9F498E3BA90` (`keyTypeId`),
  KEY `FK545AE9F494FFCF1A` (`userGroupId`),
  CONSTRAINT `FK545AE9F494FFCF1A` FOREIGN KEY (`userGroupId`) REFERENCES `core_user` (`userId`),
  CONSTRAINT `FK545AE9F498E3BA90` FOREIGN KEY (`keyTypeId`) REFERENCES `core_keytype1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userKey`
--

LOCK TABLES `core_userKey` WRITE;
/*!40000 ALTER TABLE `core_userKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_userKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userassoc`
--

DROP TABLE IF EXISTS `core_userassoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_userassoc` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `associationDate` datetime DEFAULT NULL,
  `parsedContent` varchar(512) DEFAULT NULL,
  `resolution` char(1) NOT NULL,
  `childId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parentId` (`parentId`,`childId`),
  KEY `FKAA84968A253450A2` (`childId`),
  KEY `FKAA84968A3EC4B8B0` (`parentId`),
  CONSTRAINT `FKAA84968A3EC4B8B0` FOREIGN KEY (`parentId`) REFERENCES `core_user` (`userId`),
  CONSTRAINT `FKAA84968A253450A2` FOREIGN KEY (`childId`) REFERENCES `core_user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userassoc`
--

LOCK TABLES `core_userassoc` WRITE;
/*!40000 ALTER TABLE `core_userassoc` DISABLE KEYS */;
INSERT INTO `core_userassoc` VALUES ('A',1,0,0,'2015-01-01 00:00:00',NULL,'A',3,1),('A',2,0,0,'2015-01-01 00:00:00',NULL,'A',3,2);
/*!40000 ALTER TABLE `core_userassoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userlog`
--

DROP TABLE IF EXISTS `core_userlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_userlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eventType` int(11) NOT NULL,
  `lastEvent` datetime DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`lastEvent`),
  KEY `FK545B66F95983DB9A` (`userId`),
  CONSTRAINT `FK545B66F95983DB9A` FOREIGN KEY (`userId`) REFERENCES `core_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userlog`
--

LOCK TABLES `core_userlog` WRITE;
/*!40000 ALTER TABLE `core_userlog` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_userlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userrequest`
--

DROP TABLE IF EXISTS `core_userrequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_userrequest` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `complete` int(11) NOT NULL,
  `internalNumber` bigint(20) NOT NULL,
  `issueDate` datetime DEFAULT NULL,
  `localeString` varchar(12) DEFAULT NULL,
  `nextCheckDate` datetime DEFAULT NULL,
  `appellation` char(1) NOT NULL,
  `birthDate` datetime DEFAULT NULL,
  `firstName` varchar(64) DEFAULT NULL,
  `gender` char(1) NOT NULL,
  `imageUrl` varchar(128) DEFAULT NULL,
  `lastName` varchar(64) DEFAULT NULL,
  `PIN_1` varchar(20) DEFAULT NULL,
  `PIN_2` varchar(20) DEFAULT NULL,
  `PIT_1` char(1) DEFAULT NULL,
  `PIT_2` char(1) DEFAULT NULL,
  `profileUrl` varchar(128) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `principal` varchar(40) DEFAULT NULL,
  `promotionCode` varchar(10) DEFAULT NULL,
  `resolution` char(1) NOT NULL,
  `tempPassword` varchar(48) DEFAULT NULL,
  `userGroupId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userGroupId` (`userGroupId`,`internalNumber`),
  KEY `FK8705D3C494FFCF1A` (`userGroupId`),
  CONSTRAINT `FK8705D3C494FFCF1A` FOREIGN KEY (`userGroupId`) REFERENCES `core_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userrequest`
--

LOCK TABLES `core_userrequest` WRITE;
/*!40000 ALTER TABLE `core_userrequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_userrequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_userrole`
--

DROP TABLE IF EXISTS `core_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `core_userrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activityState` char(1) NOT NULL,
  `partnershipExtension` varchar(64) DEFAULT NULL,
  `serviceExtension` varchar(64) DEFAULT NULL,
  `serviceId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`serviceId`,`serviceExtension`),
  KEY `FK37143361721C50A8` (`serviceId`),
  KEY `FK37143361C6E45791` (`userId`),
  CONSTRAINT `FK37143361C6E45791` FOREIGN KEY (`userId`) REFERENCES `core_user` (`userId`),
  CONSTRAINT `FK37143361721C50A8` FOREIGN KEY (`serviceId`) REFERENCES `core_service` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_userrole`
--

LOCK TABLES `core_userrole` WRITE;
/*!40000 ALTER TABLE `core_userrole` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_userrole` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_assoc`
--

DROP TABLE IF EXISTS `doc_assoc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_assoc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sequence` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `childId` int(11) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `parentId` (`parentId`,`childId`),
  KEY `FK12100A4E885491CB` (`childId`),
  KEY `FK12100A4EA1E4F9D9` (`parentId`),
  CONSTRAINT `FK12100A4EA1E4F9D9` FOREIGN KEY (`parentId`) REFERENCES `doc_doc` (`id`),
  CONSTRAINT `FK12100A4E885491CB` FOREIGN KEY (`childId`) REFERENCES `doc_doc` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_assoc`
--

LOCK TABLES `doc_assoc` WRITE;
/*!40000 ALTER TABLE `doc_assoc` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_assoc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_doc`
--

DROP TABLE IF EXISTS `doc_doc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_doc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `resolution` char(1) DEFAULT NULL,
  `docAbstract` varchar(2048) DEFAULT NULL,
  `docCode` varchar(24) DEFAULT NULL,
  `docFile` varchar(128) DEFAULT NULL,
  `docName` varchar(128) DEFAULT NULL,
  `encoding` varchar(32) DEFAULT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `priority` char(1) DEFAULT NULL,
  `referenceList` varchar(1024) DEFAULT NULL,
  `internalNumber` bigint(20) DEFAULT NULL,
  `internalNumberKey` varchar(48) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `serializerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`docCode`),
  KEY `FK6CF8DDB156E5964F` (`serializerId`),
  KEY `FK6CF8DDB14E55E05E` (`entityId`),
  KEY `FK6CF8DDB19F10ECC9` (`ownerId`),
  KEY `FK6CF8DDB136509C94` (`categoryId`),
  CONSTRAINT `FK6CF8DDB136509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FK6CF8DDB14E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FK6CF8DDB156E5964F` FOREIGN KEY (`serializerId`) REFERENCES `doc_doccodebuilder` (`id`),
  CONSTRAINT `FK6CF8DDB19F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_doc`
--

LOCK TABLES `doc_doc` WRITE;
/*!40000 ALTER TABLE `doc_doc` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_doc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_doccodebuilder`
--

DROP TABLE IF EXISTS `doc_doccodebuilder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_doccodebuilder` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `builderCode` varchar(36) DEFAULT NULL,
  `folderDecorationUrl` varchar(64) DEFAULT NULL,
  `builderName` varchar(128) DEFAULT NULL,
  `contentType` char(1) NOT NULL,
  `numberOfDigits` int(11) DEFAULT NULL,
  `patternPrefix` varchar(20) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`builderCode`),
  KEY `FK6A3D86BD4E55E05E` (`entityId`),
  KEY `FK6A3D86BD36509C94` (`categoryId`),
  CONSTRAINT `FK6A3D86BD36509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FK6A3D86BD4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_doccodebuilder`
--

LOCK TABLES `doc_doccodebuilder` WRITE;
/*!40000 ALTER TABLE `doc_doccodebuilder` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_doccodebuilder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_private`
--

DROP TABLE IF EXISTS `doc_private`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_private` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `resolution` char(1) DEFAULT NULL,
  `docAbstract` varchar(2048) DEFAULT NULL,
  `docCode` varchar(24) DEFAULT NULL,
  `docFile` varchar(128) DEFAULT NULL,
  `docName` varchar(128) DEFAULT NULL,
  `encoding` varchar(32) DEFAULT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `priority` char(1) DEFAULT NULL,
  `referenceList` varchar(1024) DEFAULT NULL,
  `content` longblob,
  `contentType` char(1) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`docCode`),
  KEY `FKE575997C4E55E05E` (`entityId`),
  KEY `FKE575997C9F10ECC9` (`ownerId`),
  CONSTRAINT `FKE575997C9F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FKE575997C4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_private`
--

LOCK TABLES `doc_private` WRITE;
/*!40000 ALTER TABLE `doc_private` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_private` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_process`
--

DROP TABLE IF EXISTS `doc_process`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_process` (
  `inheritanceType` char(1) NOT NULL,
  `processColor` varchar(6) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `unitId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE5C19268712BD2A0` (`unitId`),
  KEY `FKE5C192685BD973AF` (`id`),
  CONSTRAINT `FKE5C192685BD973AF` FOREIGN KEY (`id`) REFERENCES `doc_doc` (`id`),
  CONSTRAINT `FKE5C19268712BD2A0` FOREIGN KEY (`unitId`) REFERENCES `core_unit2` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_process`
--

LOCK TABLES `doc_process` WRITE;
/*!40000 ALTER TABLE `doc_process` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_process` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doc_processKey`
--

DROP TABLE IF EXISTS `doc_processKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_processKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyValue` varchar(20) DEFAULT NULL,
  `keyTypeId` int(11) DEFAULT NULL,
  `processDocumentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `processDocumentId` (`processDocumentId`,`keyTypeId`),
  KEY `FKF92D9AD79FD89836` (`processDocumentId`),
  KEY `FKF92D9AD798E3BA90` (`keyTypeId`),
  CONSTRAINT `FKF92D9AD798E3BA90` FOREIGN KEY (`keyTypeId`) REFERENCES `core_keytype1` (`id`),
  CONSTRAINT `FKF92D9AD79FD89836` FOREIGN KEY (`processDocumentId`) REFERENCES `doc_process` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doc_processKey`
--

LOCK TABLES `doc_processKey` WRITE;
/*!40000 ALTER TABLE `doc_processKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `doc_processKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evt_favourite`
--

DROP TABLE IF EXISTS `evt_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evt_favourite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `favouriteId` int(11) DEFAULT NULL,
  `favouriteMark` char(1) NOT NULL,
  `favouriteSource` varchar(255) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userId` (`userId`,`sequence`),
  KEY `FK5A3B654D5983DB9A` (`userId`),
  CONSTRAINT `FK5A3B654D5983DB9A` FOREIGN KEY (`userId`) REFERENCES `core_user` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evt_favourite`
--

LOCK TABLES `evt_favourite` WRITE;
/*!40000 ALTER TABLE `evt_favourite` DISABLE KEYS */;
/*!40000 ALTER TABLE `evt_favourite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lic_agreement`
--

DROP TABLE IF EXISTS `lic_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lic_agreement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `resolution` char(1) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `licenseId` int(11) DEFAULT NULL,
  `providerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`licenseId`),
  UNIQUE KEY `providerId` (`providerId`,`licenseId`),
  KEY `FK3CFEFF91D7DBB6EC` (`providerId`),
  KEY `FK3CFEFF914E55E05E` (`entityId`),
  KEY `FK3CFEFF919F10ECC9` (`ownerId`),
  KEY `FK3CFEFF91613C98C0` (`licenseId`),
  CONSTRAINT `FK3CFEFF91613C98C0` FOREIGN KEY (`licenseId`) REFERENCES `lic_license` (`id`),
  CONSTRAINT `FK3CFEFF914E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FK3CFEFF919F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FK3CFEFF91D7DBB6EC` FOREIGN KEY (`providerId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lic_agreement`
--

LOCK TABLES `lic_agreement` WRITE;
/*!40000 ALTER TABLE `lic_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `lic_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lic_license`
--

DROP TABLE IF EXISTS `lic_license`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lic_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longblob,
  `issueDate` datetime DEFAULT NULL,
  `licenseCode` varchar(12) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `operatorId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `operatorId` (`operatorId`,`licenseCode`),
  KEY `FKEF91E7889F10ECC9` (`ownerId`),
  KEY `FKEF91E788C8732260` (`operatorId`),
  CONSTRAINT `FKEF91E788C8732260` FOREIGN KEY (`operatorId`) REFERENCES `core_operator` (`id`),
  CONSTRAINT `FKEF91E7889F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lic_license`
--

LOCK TABLES `lic_license` WRITE;
/*!40000 ALTER TABLE `lic_license` DISABLE KEYS */;
/*!40000 ALTER TABLE `lic_license` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ord_abstract`
--

DROP TABLE IF EXISTS `ord_abstract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ord_abstract` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `resolution` char(1) DEFAULT NULL,
  `checkInData` varchar(4096) DEFAULT NULL,
  `checkOutData` varchar(4096) DEFAULT NULL,
  `checkOutTime` datetime DEFAULT NULL,
  `faceValue` decimal(19,2) DEFAULT NULL,
  `internalNumber` bigint(20) NOT NULL,
  `nextCheckDate` datetime DEFAULT NULL,
  `position` char(1) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `partId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`internalNumber`,`type`),
  KEY `FK7D3D9FC0617D58A9` (`partId`),
  KEY `FK7D3D9FC04E55E05E` (`entityId`),
  KEY `FK7D3D9FC09F10ECC9` (`ownerId`),
  KEY `FK7D3D9FC036509C94` (`categoryId`),
  CONSTRAINT `FK7D3D9FC036509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FK7D3D9FC04E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FK7D3D9FC0617D58A9` FOREIGN KEY (`partId`) REFERENCES `ord_part` (`id`),
  CONSTRAINT `FK7D3D9FC09F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ord_abstract`
--

LOCK TABLES `ord_abstract` WRITE;
/*!40000 ALTER TABLE `ord_abstract` DISABLE KEYS */;
/*!40000 ALTER TABLE `ord_abstract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ord_event`
--

DROP TABLE IF EXISTS `ord_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ord_event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `issueDate` datetime DEFAULT NULL,
  `sequence` int(11) DEFAULT NULL,
  `tokenCode` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `abstractOrderId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abstractOrderId` (`abstractOrderId`,`sequence`),
  KEY `FKDDC417BCCFFF2B6B` (`abstractOrderId`),
  KEY `FKDDC417BC9F10ECC9` (`ownerId`),
  CONSTRAINT `FKDDC417BC9F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FKDDC417BCCFFF2B6B` FOREIGN KEY (`abstractOrderId`) REFERENCES `ord_abstract` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ord_event`
--

LOCK TABLES `ord_event` WRITE;
/*!40000 ALTER TABLE `ord_event` DISABLE KEYS */;
/*!40000 ALTER TABLE `ord_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ord_part`
--

DROP TABLE IF EXISTS `ord_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ord_part` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `issueDate` datetime DEFAULT NULL,
  `privacyLevel` char(1) DEFAULT NULL,
  `resolution` char(1) DEFAULT NULL,
  `docAbstract` varchar(2048) DEFAULT NULL,
  `docCode` varchar(24) DEFAULT NULL,
  `docFile` varchar(128) DEFAULT NULL,
  `docName` varchar(128) DEFAULT NULL,
  `encoding` varchar(32) DEFAULT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `priority` char(1) DEFAULT NULL,
  `referenceList` varchar(1024) DEFAULT NULL,
  `activityState` char(1) NOT NULL,
  `docFlag` bit(1) DEFAULT NULL,
  `docValue` decimal(19,2) DEFAULT NULL,
  `parsedContent` varchar(512) DEFAULT NULL,
  `tokenPrefix` varchar(4) DEFAULT NULL,
  `createOrder` int(11) DEFAULT NULL,
  `createOrderDay` int(11) DEFAULT NULL,
  `currencyRate` double DEFAULT NULL,
  `discountRate` double DEFAULT NULL,
  `nextCheckDate` datetime DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  `ownerId` int(11) DEFAULT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `currencyId` int(11) DEFAULT NULL,
  `privateEntityId` int(11) DEFAULT NULL,
  `processDocumentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`docCode`),
  KEY `FK493C92919FD89836` (`processDocumentId`),
  KEY `FK493C929198F510E5` (`privateEntityId`),
  KEY `FK493C92914E55E05E` (`entityId`),
  KEY `FK493C92919F10ECC9` (`ownerId`),
  KEY `FK493C9291D5B96D65` (`currencyId`),
  KEY `FK493C929136509C94` (`categoryId`),
  CONSTRAINT `FK493C929136509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FK493C92914E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FK493C929198F510E5` FOREIGN KEY (`privateEntityId`) REFERENCES `core_public` (`id`),
  CONSTRAINT `FK493C92919F10ECC9` FOREIGN KEY (`ownerId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FK493C92919FD89836` FOREIGN KEY (`processDocumentId`) REFERENCES `doc_process` (`id`),
  CONSTRAINT `FK493C9291D5B96D65` FOREIGN KEY (`currencyId`) REFERENCES `core_currency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ord_part`
--

LOCK TABLES `ord_part` WRITE;
/*!40000 ALTER TABLE `ord_part` DISABLE KEYS */;
INSERT INTO `ord_part` VALUES ('A',1,0,'2015-03-05 00:00:00','0','D','Diagnóstico do Balanço Patrimonial do exercício anterior, para verificar a sua eficácia para o próximo ano no tocante à participação em editais. Serão analisados, especialmente, os índices financeiros mais solicitados em editais, que em geral são os de Solvência Geral (SG), Liquidez Geral (LG) e Liquidez Corrente (LC), bem como a adequação do Patrimônio Líquido e Capital Social.','D_BP','','Diagnóstico do Balanço Patrimonial (Índices)','ISO8859_1','text/plain','0',NULL,'A',NULL,5.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',2,0,'2015-03-05 00:00:00','0','D','Elaborar planilha analítica de composição de custos e formação de preços conforme os padrões estabelecidos pelo Anexo III da Instrução Normativa nº 2/2008, alterado pela Portaria Normativa nº 7/2011, da Secretaria de Logística e Tecnologia da Informação/MPOG.','E_PCC','','Elaboração de Planilha de Composição de Custos','ISO8859_1','text/plain','0',NULL,'A',NULL,5.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',3,0,'2015-03-05 00:00:00','0','D','Assessoramento em processos de credenciamento e cadastros de maior complexidade, como Cadastro Petrobrás, Credenciamento de Consultores no Sistema \"S\", Declaração de Utilidade Pública, etc.','C_CE','','Credenciamento/Cadastros Especiais','ISO8859_1','text/plain','0',NULL,'A',NULL,12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',4,0,'2015-03-05 00:00:00','0','D','Assessoria na obtenção de garantias contratuais, conforme previsão legal, identificando a modalidade mais adequada e negociando com as entidades garantidoras melhores condições de contratação.','C_GC','','Obtenção de Garantias Contratuais','ISO8859_1','text/plain','0',NULL,'A',NULL,5.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',5,0,'2015-03-05 00:00:00','0','D','Interação com o consultor da Winbid para esclarecimento de dúvidas, definições de medidas, acompanhamento de ações ou outros assuntos pertinentes a Licitações e Contratos Administrativos. Será cobrado 1 UA por hora de reunião/consulta.','R_LC','','Reunião/Consulta presencial ou remota - Licitações e Contratos Adm. (1 UA/hora)','ISO8859_1','text/plain','0',NULL,'A',NULL,1.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',6,0,'2015-03-05 00:00:00','0','D','Interação com o consultor da Winbid para esclarecimento de dúvidas, definições de medidas, acompanhamento de ações ou outros assuntos pertinentes a Captação de Recursos. Será cobrado 1 UA por hora de reunião/consulta.','R_CR','','Reunião/Consulta presencial ou remota - Captação de Recursos (1 UA/hora)','ISO8859_1','text/plain','0',NULL,'A',NULL,1.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',7,0,'2015-03-05 00:00:00','0','D','Elaboração e Interposição de Recursos Administrativos ou Contrarrazões de Recursos em processos ainda não assessorados pela Winbid.','N_RC','','Recurso/Contrarrazões em processos não assessorados','ISO8859_1','text/plain','0',NULL,'A',NULL,12.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',8,0,'2015-03-05 00:00:00','0','D','É a captação e o envio dos editais de licitação de forma personalizada, de acordo com o objeto de interesse e filtros (região, valor, por entidade, etc.) selecionados pela empresa cliente. Podem ser cadastradas até 10 (dez) palavras-chave a critério do cliente.','T_BS','','Triagem Básica (10 palavras-chave)','ISO8859_1','text/plain','0',NULL,'A',NULL,2.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL),('A',9,0,'2015-03-05 00:00:00','0','D','Extensão do serviço de Triagem Básica, permitindo cadastrar mais 5 (cinco) palavras-chave quando a quantidade inicial não for suficiente para cobrir o conjunto de ofertas do cliente.','T_AD','','Triagem Adicional (+5 palavras-chave)','ISO8859_1','text/plain','0',NULL,'A',NULL,1.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ord_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ord_serializer`
--

DROP TABLE IF EXISTS `ord_serializer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ord_serializer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lastToken` int(11) NOT NULL,
  `tokenColorUrl` varchar(64) DEFAULT NULL,
  `tokenIconUrl` varchar(64) DEFAULT NULL,
  `tokenLogoUrl` varchar(64) DEFAULT NULL,
  `tokenName` varchar(255) DEFAULT NULL,
  `tokenPrefix` varchar(4) DEFAULT NULL,
  `tokenType` char(1) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `contextId` int(11) DEFAULT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contextId` (`contextId`,`tokenPrefix`),
  KEY `FK4421B5B0AFF118AB` (`contextId`),
  KEY `FK4421B5B04E55E05E` (`entityId`),
  CONSTRAINT `FK4421B5B04E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`),
  CONSTRAINT `FK4421B5B0AFF118AB` FOREIGN KEY (`contextId`) REFERENCES `core_operator` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ord_serializer`
--

LOCK TABLES `ord_serializer` WRITE;
/*!40000 ALTER TABLE `ord_serializer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ord_serializer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ord_token`
--

DROP TABLE IF EXISTS `ord_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ord_token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `tokenLabel` varchar(15) DEFAULT NULL,
  `tokenState` char(1) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`tokenLabel`),
  KEY `FKDE945F1B4E55E05E` (`entityId`),
  CONSTRAINT `FKDE945F1B4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ord_token`
--

LOCK TABLES `ord_token` WRITE;
/*!40000 ALTER TABLE `ord_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `ord_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_account`
--

DROP TABLE IF EXISTS `prtnr_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `accountCode` varchar(20) DEFAULT NULL,
  `accountName` varchar(64) DEFAULT NULL,
  `accountType` char(1) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`accountCode`),
  KEY `FK827AB6E44E55E05E` (`entityId`),
  CONSTRAINT `FK827AB6E44E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_account`
--

LOCK TABLES `prtnr_account` WRITE;
/*!40000 ALTER TABLE `prtnr_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_category`
--

DROP TABLE IF EXISTS `prtnr_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longblob,
  `encoding` varchar(32) DEFAULT NULL,
  `multipartFileContentType` varchar(32) DEFAULT NULL,
  `version` int(11) NOT NULL,
  `categoryId` int(11) DEFAULT NULL,
  `partnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerId` (`partnerId`,`categoryId`),
  KEY `FK4F4127276EC7C609` (`partnerId`),
  KEY `FK4F41272736509C94` (`categoryId`),
  CONSTRAINT `FK4F41272736509C94` FOREIGN KEY (`categoryId`) REFERENCES `core_category` (`id`),
  CONSTRAINT `FK4F4127276EC7C609` FOREIGN KEY (`partnerId`) REFERENCES `prtnr_partner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_category`
--

LOCK TABLES `prtnr_category` WRITE;
/*!40000 ALTER TABLE `prtnr_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_contact`
--

DROP TABLE IF EXISTS `prtnr_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_contact` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address1` varchar(64) DEFAULT NULL,
  `address2` varchar(32) DEFAULT NULL,
  `address3` varchar(32) DEFAULT NULL,
  `addressClassifier` varchar(10) DEFAULT NULL,
  `addressDetail` varchar(24) DEFAULT NULL,
  `addressNumber` varchar(8) DEFAULT NULL,
  `cityName` varchar(64) DEFAULT NULL,
  `postOfficeBox` varchar(10) DEFAULT NULL,
  `postalCode` varchar(10) DEFAULT NULL,
  `addressType` char(1) NOT NULL,
  `privacyLevel` char(1) NOT NULL,
  `sequence` int(11) NOT NULL,
  `departament` varchar(20) DEFAULT NULL,
  `jobReference` varchar(64) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `cityId` int(11) DEFAULT NULL,
  `stateId` int(11) DEFAULT NULL,
  `partnerRegistryId` int(11) DEFAULT NULL,
  `identityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerRegistryId` (`partnerRegistryId`,`sequence`),
  KEY `FK15E50D7B9863F04` (`partnerRegistryId`),
  KEY `FK15E50D77D7E1414` (`identityId`),
  KEY `FK15E50D75434C220` (`stateId`),
  KEY `FK15E50D7522AF4AE` (`cityId`),
  CONSTRAINT `FK15E50D7522AF4AE` FOREIGN KEY (`cityId`) REFERENCES `core_city` (`id`),
  CONSTRAINT `FK15E50D75434C220` FOREIGN KEY (`stateId`) REFERENCES `core_state` (`id`),
  CONSTRAINT `FK15E50D77D7E1414` FOREIGN KEY (`identityId`) REFERENCES `core_identity` (`id`),
  CONSTRAINT `FK15E50D7B9863F04` FOREIGN KEY (`partnerRegistryId`) REFERENCES `core_public` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_contact`
--

LOCK TABLES `prtnr_contact` WRITE;
/*!40000 ALTER TABLE `prtnr_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_partner`
--

DROP TABLE IF EXISTS `prtnr_partner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_partner` (
  `type` char(1) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `partnerState` char(1) NOT NULL,
  `priority` char(1) NOT NULL,
  `taxClass` char(1) NOT NULL,
  `agentComission` float DEFAULT NULL,
  `accessTokenValiditySeconds` int(11) DEFAULT NULL,
  `clientSecret` varchar(60) DEFAULT NULL,
  `redirectUri` varchar(256) DEFAULT NULL,
  `refreshTokenValiditySeconds` int(11) DEFAULT NULL,
  `divisionType` char(1) DEFAULT NULL,
  `accountId` int(11) DEFAULT NULL,
  `partnerRegistryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerRegistryId` (`partnerRegistryId`,`type`),
  KEY `FK9964097F55FF5B93` (`accountId`),
  KEY `FK9964097FB9863F04` (`partnerRegistryId`),
  CONSTRAINT `FK9964097FB9863F04` FOREIGN KEY (`partnerRegistryId`) REFERENCES `core_public` (`id`),
  CONSTRAINT `FK9964097F55FF5B93` FOREIGN KEY (`accountId`) REFERENCES `prtnr_account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_partner`
--

LOCK TABLES `prtnr_partner` WRITE;
/*!40000 ALTER TABLE `prtnr_partner` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_partner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_partnerKey`
--

DROP TABLE IF EXISTS `prtnr_partnerKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_partnerKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyValue` varchar(20) DEFAULT NULL,
  `keyTypeId` int(11) DEFAULT NULL,
  `partnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerId` (`partnerId`,`keyTypeId`),
  KEY `FK406E386098E3BA90` (`keyTypeId`),
  KEY `FK406E38606EC7C609` (`partnerId`),
  CONSTRAINT `FK406E38606EC7C609` FOREIGN KEY (`partnerId`) REFERENCES `prtnr_partner` (`id`),
  CONSTRAINT `FK406E386098E3BA90` FOREIGN KEY (`keyTypeId`) REFERENCES `core_keytype1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_partnerKey`
--

LOCK TABLES `prtnr_partnerKey` WRITE;
/*!40000 ALTER TABLE `prtnr_partnerKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_partnerKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_partnerRegistryKey`
--

DROP TABLE IF EXISTS `prtnr_partnerRegistryKey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_partnerRegistryKey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keyValue` varchar(20) DEFAULT NULL,
  `keyTypeId` int(11) DEFAULT NULL,
  `partnerRegistryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerRegistryId` (`partnerRegistryId`,`keyTypeId`),
  KEY `FK5509B9E398E3BA90` (`keyTypeId`),
  KEY `FK5509B9E3B9863F04` (`partnerRegistryId`),
  CONSTRAINT `FK5509B9E3B9863F04` FOREIGN KEY (`partnerRegistryId`) REFERENCES `core_public` (`id`),
  CONSTRAINT `FK5509B9E398E3BA90` FOREIGN KEY (`keyTypeId`) REFERENCES `core_keytype1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_partnerRegistryKey`
--

LOCK TABLES `prtnr_partnerRegistryKey` WRITE;
/*!40000 ALTER TABLE `prtnr_partnerRegistryKey` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_partnerRegistryKey` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_phone2`
--

DROP TABLE IF EXISTS `prtnr_phone2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_phone2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(20) DEFAULT NULL,
  `areaCode` varchar(3) DEFAULT NULL,
  `branch` varchar(10) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `phoneType` char(1) NOT NULL,
  `privacyLevel` char(1) NOT NULL,
  `sequence` int(11) NOT NULL,
  `partnerRegistryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `partnerRegistryId` (`partnerRegistryId`,`sequence`),
  KEY `FKBB0150EDB9863F04` (`partnerRegistryId`),
  CONSTRAINT `FKBB0150EDB9863F04` FOREIGN KEY (`partnerRegistryId`) REFERENCES `core_public` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_phone2`
--

LOCK TABLES `prtnr_phone2` WRITE;
/*!40000 ALTER TABLE `prtnr_phone2` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_phone2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prtnr_segment`
--

DROP TABLE IF EXISTS `prtnr_segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prtnr_segment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` int(11) DEFAULT NULL,
  `content` longblob,
  `segmentAlias` varchar(20) DEFAULT NULL,
  `segmentName` varchar(128) DEFAULT NULL,
  `segmentType` char(1) NOT NULL,
  `entityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entityId` (`entityId`,`segmentAlias`),
  KEY `FK3E4BCBEA4E55E05E` (`entityId`),
  CONSTRAINT `FK3E4BCBEA4E55E05E` FOREIGN KEY (`entityId`) REFERENCES `core_entity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prtnr_segment`
--

LOCK TABLES `prtnr_segment` WRITE;
/*!40000 ALTER TABLE `prtnr_segment` DISABLE KEYS */;
/*!40000 ALTER TABLE `prtnr_segment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-02 13:39:16
