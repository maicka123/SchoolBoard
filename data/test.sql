-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 24, 2021 at 01:40 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Table structure for table `schoolboards`
--

CREATE TABLE `schoolboards` (
  `SchoolBoardsID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schoolboards`
--

INSERT INTO `schoolboards` (`SchoolBoardsID`, `Name`) VALUES
(1, 'CSM'),
(2, 'CSMB');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `StudentsID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Grade1` int(11) DEFAULT NULL,
  `Grade2` int(11) DEFAULT NULL,
  `Grade3` int(11) DEFAULT NULL,
  `Grade4` int(11) DEFAULT NULL,
  `AverageResult` decimal(10,0) DEFAULT NULL,
  `FinalResult` varchar(100) NOT NULL,
  `SchoolBoardsID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`StudentsID`, `Name`, `Grade1`, `Grade2`, `Grade3`, `Grade4`, `AverageResult`, `FinalResult`, `SchoolBoardsID`) VALUES
(1, 'Test1 Test1', 7, 8, 7, 9, '24', 'Pass', 1),
(2, 'Test2 Test2', 7, 8, NULL, NULL, '15', 'Pass', 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `schoolboards`
--
ALTER TABLE `schoolboards`
  ADD PRIMARY KEY (`SchoolBoardsID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`StudentsID`),
  ADD KEY `SchoolBoardsID` (`SchoolBoardsID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `schoolboards`
--
ALTER TABLE `schoolboards`
  MODIFY `SchoolBoardsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `StudentsID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`SchoolBoardsID`) REFERENCES `schoolboards` (`SchoolBoardsID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
