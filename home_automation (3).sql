-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2022 at 08:01 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `home_automation`
--

-- --------------------------------------------------------

--
-- Table structure for table `device_control`
--

CREATE TABLE `device_control` (
  `dis_id` int(25) NOT NULL,
  `location` varchar(50) NOT NULL,
  `power_consumtions` varchar(50) NOT NULL,
  `devices` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `device_control`
--

INSERT INTO `device_control` (`dis_id`, `location`, `power_consumtions`, `devices`) VALUES
(54198, 'room1', 'mid', 'fan'),
(67358, 'room3', 'high', 'Samsung Ac'),
(91358, 'room4', 'high', 'Hitachi Fridge'),
(100056, 'room1', 'low', 'samsumg galaxy s10');

-- --------------------------------------------------------

--
-- Stand-in structure for view `device_details`
-- (See below for the actual view)
--
CREATE TABLE `device_details` (
`dis_id` int(25)
,`devices` varchar(25)
,`power_consumtions` varchar(50)
,`data_uasge` varchar(20)
,`network` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `device_location`
--

CREATE TABLE `device_location` (
  `location` varchar(25) NOT NULL,
  `longitude` varchar(25) NOT NULL,
  `room_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `device_location`
--

INSERT INTO `device_location` (`location`, `longitude`, `room_name`) VALUES
('room1', '4.6735,-0.648', 'harry\'s house'),
('room3', '4.6735,-0.648', 'Living Room'),
('room2', '4.6735,-0.649', 'Kasoul\'s house'),
('room4', '4.6735,-0.650', 'dining room');

-- --------------------------------------------------------

--
-- Table structure for table `device_status`
--

CREATE TABLE `device_status` (
  `dis_id` int(20) NOT NULL,
  `network` varchar(50) DEFAULT NULL,
  `data_uasge` varchar(20) NOT NULL,
  `device_status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `device_status`
--

INSERT INTO `device_status` (`dis_id`, `network`, `data_uasge`, `device_status`) VALUES
(54198, '2.4 Ghz', '100 MB', 'ON'),
(67358, '2.4 Ghz', '170 MB', 'ON'),
(91358, '2.4 Ghz', '75 MB', 'OFF'),
(100056, '2.4 Ghz', '5678 MB', 'ON');

-- --------------------------------------------------------

--
-- Stand-in structure for view `room_network`
-- (See below for the actual view)
--
CREATE TABLE `room_network` (
`location` varchar(50)
,`power_consumtions` varchar(50)
,`longitude` varchar(25)
,`room_name` varchar(25)
);

-- --------------------------------------------------------

--
-- Structure for view `device_details`
--
DROP TABLE IF EXISTS `device_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `device_details`  AS SELECT `device_control`.`dis_id` AS `dis_id`, `device_control`.`devices` AS `devices`, `device_control`.`power_consumtions` AS `power_consumtions`, `device_status`.`data_uasge` AS `data_uasge`, `device_status`.`network` AS `network` FROM (`device_control` join `device_status`) WHERE `device_control`.`dis_id` = `device_status`.`dis_id` AND `device_status`.`device_status` = 'ON' ;

-- --------------------------------------------------------

--
-- Structure for view `room_network`
--
DROP TABLE IF EXISTS `room_network`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `room_network`  AS SELECT `device_control`.`location` AS `location`, `device_control`.`power_consumtions` AS `power_consumtions`, `device_location`.`longitude` AS `longitude`, `device_location`.`room_name` AS `room_name` FROM (`device_control` join `device_location`) WHERE `device_control`.`location` = `device_location`.`location` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `device_control`
--
ALTER TABLE `device_control`
  ADD PRIMARY KEY (`dis_id`);

--
-- Indexes for table `device_location`
--
ALTER TABLE `device_location`
  ADD PRIMARY KEY (`location`),
  ADD KEY `room_code` (`longitude`,`room_name`);

--
-- Indexes for table `device_status`
--
ALTER TABLE `device_status`
  ADD PRIMARY KEY (`dis_id`),
  ADD KEY `network_devices` (`data_uasge`,`network`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
