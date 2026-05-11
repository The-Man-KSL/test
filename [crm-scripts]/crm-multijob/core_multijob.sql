CREATE TABLE `user_jobs` (
  `identifier` varchar(100) NOT NULL,
  `job` varchar(100) NOT NULL,
  `grade` int(11) NOT NULL,
  `removeable` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('offduty', 'Off Duty', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('offduty', 0, 'offduty', 'Offduty', 0, '{}', '{}');


