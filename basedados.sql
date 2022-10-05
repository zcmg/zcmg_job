DROP TABLE IF EXISTS `zcmg_job`;
CREATE TABLE IF NOT EXISTS `zcmg_job` (
  `identifier` varchar(50) DEFAULT NULL,
  `job1` varchar(50) DEFAULT NULL,
  `grade1` int(11) DEFAULT NULL,
  `job2` varchar(50) DEFAULT NULL,
  `grade2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;