CREATE TABLE `files2_buf` (
  `file` varchar(255) NOT NULL DEFAULT '',
  `s_date` varchar(255) DEFAULT NULL,
  `f_datetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`file`,`f_datetime`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

CREATE TABLE `files2` (
  `file` varchar(255) DEFAULT NULL,
  `s_date` varchar(255) DEFAULT NULL,
  `f_datetime` datetime DEFAULT NULL,
  KEY `i_file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `jpeg2_temp` (
  `jpeg_short_name` varchar(256) DEFAULT NULL,
  `jpeg_date` datetime DEFAULT NULL,
  KEY `i_jsn` (`jpeg_short_name`(10)),
  KEY `i_jd` (`jpeg_date`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

 CREATE TABLE `jpegs2` (
  `jpeg_path` varchar(4096) DEFAULT NULL,
  `jpeg_name` varchar(256) DEFAULT NULL,
  `jpeg_short_name` varchar(256) DEFAULT NULL,
  `jpeg_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `multiimages` (
  `fname` varchar(256) DEFAULT NULL,
  `fdate` datetime DEFAULT NULL,
  `image_type` smallint(6) DEFAULT NULL COMMENT '1 - hdr, 2 - panorama, 3 - stack, 4 - animation',
  UNIQUE KEY `fname` (`fname`(15),`fdate`,`image_type`),
  KEY `i_fname` (`fname`(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `raws2` (
  `raw_path` varchar(255) DEFAULT NULL,
  `raw_name` varchar(255) DEFAULT NULL,
  `raw_short_name` varchar(255) DEFAULT NULL,
  `raw_date` datetime DEFAULT NULL,
  KEY `i_rsn` (`raw_short_name`(10)),
  KEY `i_rd` (`raw_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
