
CREATE DATABASE IF NOT EXISTS free;

-- Usar la base de datos creada
USE free;



   DROP TABLE IF EXISTS `gateways`;
   CREATE TABLE `gateways` (
      `gateway_id` int(10) unsigned NOT NULL auto_increment,
      `gateway_ip` varchar(16) NOT NULL,
      `group` varchar(15) NOT NULL,
      `limit` int(10) unsigned NOT NULL,
      `techprofile` varchar(128) NOT NULL,
      PRIMARY KEY  (`gateway_id`),
      KEY `gateway_ip` (`gateway_ip`,`group`)
   ) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Gateways Table';
   LOCK TABLES `gateways` WRITE;

--   /*!40000 ALTER TABLE `gateways` DISABLE KEYS */;
  INSERT INTO `gateways` VALUES (1,'192.168.99.1','mustang',50,'sofia/default');

--   /*!40000 ALTER TABLE `gateways` ENABLE KEYS */;
  UNLOCK TABLES;
 
  DROP TABLE IF EXISTS `numbers`;
  CREATE TABLE `numbers` (
 `number_id` int(10) unsigned NOT NULL auto_increment,
 `gateway_id` int(10) unsigned NOT NULL,
 `number` varchar(16) NOT NULL,
 `acctcode` varchar(16) NOT NULL,
 `translated` varchar(16) NOT NULL,
  PRIMARY KEY  (`number_id`),
  UNIQUE KEY `number` (`number`),
  KEY `gateway_id` (`gateway_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Numbers Table';
  LOCK TABLES `numbers` WRITE;

--   /*!40000 ALTER TABLE `numbers` DISABLE KEYS */;
  INSERT INTO `numbers` VALUES (1,1,'19018577141','999999', '9018577141'),(2,1,'19995551212','666666', '9995551212');

--   /*!40000 ALTER TABLE `numbers` ENABLE KEYS */;
  UNLOCK TABLES;

   DROP TABLE IF EXISTS `carriers`;
   CREATE TABLE `carriers` (
  `id` int(11) NOT NULL auto_increment,
  `carrier_name` varchar(255) default NULL,
  `enabled` boolean NOT NULL DEFAULT '1',
   PRIMARY KEY  (`id`)
   ) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

  DROP TABLE IF EXISTS `lcr`;
  CREATE TABLE `lcr` (
  `id` int(11) NOT NULL auto_increment,
  `digits` varchar(15) default NULL,
  `rate` float(11,5) unsigned NOT NULL,
  `intrastate_rate` float(11, 5) unsigned NOT NULL,
  `intralata_rate` float(11, 5) unsigned NOT NULL,
  `carrier_id` int(11) NOT NULL,
  `lead_strip` int(11) NOT NULL,
  `trail_strip` int(11) NOT NULL,
  `prefix` varchar(16) NOT NULL,
  `suffix` varchar(16) NOT NULL,
  `lcr_profile` varchar(32) default NULL,
  `date_start` datetime NOT NULL DEFAULT '1970-01-01',
  `date_end` datetime NOT NULL DEFAULT '2030-12-31',
  `quality` float(10,6) NOT NULL,
  `reliability` float(10,6) NOT NULL,
  `cid` varchar(32) NOT NULL DEFAULT '',
  `enabled` boolean NOT NULL DEFAULT '1',
   PRIMARY KEY  (`id`),
   KEY `carrier_id` (`carrier_id`),
   KEY `digits` (`digits`),
   KEY `lcr_profile` (`lcr_profile`),
   KEY `rate` (`rate`),
   KEY `digits_profile_cid_rate` USING BTREE (`digits`,`rate`),
   CONSTRAINT `carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `carriers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
   ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;



   DROP TABLE IF EXISTS `npa_nxx_company_ocn`;
   CREATE TABLE npa_nxx_company_ocn (
   npa smallint NOT NULL,
   nxx smallint NOT NULL,
   company_type text,
   ocn text,
   company_name text,
   lata integer,
   ratecenter text,
   state text
   );
   CREATE UNIQUE INDEX npanxx_idx USING BTREE ON npa_nxx_company_ocn (npa, nxx);

   DROP TABLE IF EXISTS `carrier_gateway`;
   CREATE TABLE `carrier_gateway` (
  `id` int(11) NOT NULL auto_increment,
  `carrier_id` int(11) default NULL,
  `prefix` varchar(255) NOT NULL,
  `suffix` varchar(255) NOT NULL,
  `codec` varchar(255) NOT NULL,
  `enabled` boolean NOT NULL DEFAULT '1',
  PRIMARY KEY  (`id`),
  KEY `carrier_id` (`carrier_id`)
  ) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;