-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 27, 2021 at 06:39 PM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `school`
--

-- --------------------------------------------------------

--
-- Table structure for table `education`
--

CREATE TABLE `education` (
  `id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `sub_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `education`
--

INSERT INTO `education` (`id`, `s_id`, `sub_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 3, 1),
(6, 6, 1),
(7, 6, 3),
(8, 6, 4),
(9, 5, 2),
(10, 5, 1),
(11, 5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `exam`
--

CREATE TABLE `exam` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `t_id` int(11) NOT NULL,
  `sub_id` int(11) NOT NULL,
  `date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `exam`
--

INSERT INTO `exam` (`id`, `name`, `t_id`, `sub_id`, `date`) VALUES
(1, 'Math', 1, 1, '25/1/2021'),
(2, 'Biologie', 4, 2, '1/2/2021'),
(3, 'Physik', 2, 3, '5/2/2021'),
(4, 'Chemie', 5, 4, '7/2/2021');

-- --------------------------------------------------------

--
-- Table structure for table `examregister`
--

CREATE TABLE `examregister` (
  `id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `exam_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `examregister`
--

INSERT INTO `examregister` (`id`, `s_id`, `exam_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 3, 3),
(4, 6, 1),
(5, 6, 3),
(6, 3, 1),
(7, 6, 4),
(8, 5, 2),
(9, 5, 1),
(10, 5, 3),
(11, 5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `grade`
--

CREATE TABLE `grade` (
  `id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `sub_id` int(11) NOT NULL,
  `t_id` int(11) NOT NULL,
  `result_grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `grade`
--

INSERT INTO `grade` (`id`, `s_id`, `sub_id`, `t_id`, `result_grade`) VALUES
(1, 1, 1, 1, 60),
(2, 3, 1, 1, 78),
(3, 6, 1, 1, 100),
(4, 6, 3, 2, 60),
(5, 6, 4, 5, 45),
(6, 5, 2, 4, 44),
(7, 5, 1, 1, 99),
(8, 5, 3, 2, 55),
(9, 3, 3, 2, 60);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `roll` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`id`, `firstName`, `lastName`, `email`, `password`, `roll`) VALUES
(1, 'mohammad', 'aljunaedi', 'aljunaedi@gmail.com', '$2a$08$uNNMAAZOuNToSPzSEwvUPu1GoJB4q2c0n/EQv7f5qGwElPbl3I456', 'student'),
(3, 'pepsi', 'bakir', 'pepsi@gmail.com', '$2a$08$pNRLlz35YgSoGA/fsttEbuIXthldLT5kzHSsoQME4CMyeVrzE7NP2', 'student'),
(5, 'rami', 'majed', 'majed@gmail.com', '$2a$08$q7dTDvKLnXocEcI107GEROUM270JcgEgJfeM3WCcVabjY7fi25e/O', 'student'),
(6, 'noor', 'nan', 'nan@gmail.com', '$2a$08$mE.4/pIfGw5XQVJlV9j0beUSTx9KhZcyaFEOGGRuENEuQhBKmFL56', 'student');

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `room` varchar(100) NOT NULL,
  `t_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subject`
--

INSERT INTO `subject` (`id`, `name`, `time`, `room`, `t_id`) VALUES
(1, 'Math', '8:30 ', '13', 1),
(2, 'Biologie', '10:15', '15', 4),
(3, 'Physik', '1:45', '17', 2),
(4, 'Chemie', '2:30', '11', 5);

-- --------------------------------------------------------

--
-- Table structure for table `teatcher`
--

CREATE TABLE `teatcher` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(200) NOT NULL,
  `roll` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `teatcher`
--

INSERT INTO `teatcher` (`id`, `firstName`, `lastName`, `email`, `password`, `roll`) VALUES
(1, 'deaa', 'aljunaedi', 'app@gmail.com', '$2a$08$nq7Sb26bYYB2vD.DXqi4jePSOWA0VZ6.IIsoLJYmYCajEwGWrC0.m', 'teacher'),
(2, 'ayham', 'nashar', 'nashar@gmail.com', '$2a$08$pv1uim3/0YZbcaRX9xO5ROOnhdCwQ8BrKD9mQtjCzDYKBOI.gY4xy', 'teacher'),
(4, 'noor', 'mari', 'noor@gmail.com', '$2a$08$ZCvsZWDjgg4pn0nL0tXcxupLCM0RbGUGotFTnFcW8dcZ3EPpG484i', 'teacher'),
(5, 'henry', 'baum', 'baum@gmail.com', '$2a$08$5CMeEHNQ7Wfys2RJAznB3.YHUQM0NXz0016aZWy8b4axq8AkuDDie', 'teacher');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `roll` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `firstName`, `lastName`, `email`, `password`, `roll`) VALUES
(1, 'mohammad', 'alju', 'app@gmail.com', '$2a$08$nXr7owgWgmiIC3A3u4wyUOdWt2PvbyQ/jx4f.svVGkMY6Nizs1eKq', 'student'),
(2, 'deaa', 'alju', 'nero789croft@gmail.com', '$2a$08$p13b./btVDQMKzxZF6zyH.WDLsfa98QUvPDprHUPiauxBO2Me1LLq', 'student'),
(3, 'deaa', 'alju', 'nero789croft@gmail.com', '$2a$08$6curONEeJldYf4yBvpgPfO4LfXKc//PIHBgPsbRvnGzGPoopr/93q', 'student'),
(4, 'deaa', 'alju', 'nero789croft@gmail.com', '$2a$08$Ut/JvkcTi0h6CB7Zc1SIPOUyYjr1OcQKDrU/YkdhClRKWl9R4NISu', 'student'),
(5, 'deaa', 'alju', 'ddd@gmail.com', '$2a$08$S2qPeyFtkcsJPKSr/Tf8gOM3Mt5qyffq4cibYsjR3ZTiCRTEBenkG', 'teacher'),
(6, 'ayham', 'nashar', 'nashar@gmail.com', '$2a$08$byfMwQIAy91nLYuG67ZZW.lwPJyX8mI9mSCd9mUiLwyCXLG/d61Bi', 'teacher'),
(7, 'pepsi', 'bakir', 'pepsi@gmail.com', '$2a$08$V21/xm4TjGVOwzp/xUVQPeh/Vq3GS59rzYkKl5pJrNOXit4h4WY/m', 'teacher');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `education`
--
ALTER TABLE `education`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_relation` (`s_id`),
  ADD KEY `sub_relation` (`sub_id`);

--
-- Indexes for table `exam`
--
ALTER TABLE `exam`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_relation` (`t_id`),
  ADD KEY `subjects_relation` (`sub_id`);

--
-- Indexes for table `examregister`
--
ALTER TABLE `examregister`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_exam` (`s_id`),
  ADD KEY `exam_relation` (`exam_id`);

--
-- Indexes for table `grade`
--
ALTER TABLE `grade`
  ADD PRIMARY KEY (`id`),
  ADD KEY `s_grade` (`s_id`),
  ADD KEY `t_grade` (`t_id`),
  ADD KEY `sub_grade` (`sub_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `relation` (`t_id`);

--
-- Indexes for table `teatcher`
--
ALTER TABLE `teatcher`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `education`
--
ALTER TABLE `education`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `exam`
--
ALTER TABLE `exam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `examregister`
--
ALTER TABLE `examregister`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `grade`
--
ALTER TABLE `grade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `subject`
--
ALTER TABLE `subject`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `teatcher`
--
ALTER TABLE `teatcher`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `education`
--
ALTER TABLE `education`
  ADD CONSTRAINT `student_relation` FOREIGN KEY (`s_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `sub_relation` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`id`);

--
-- Constraints for table `exam`
--
ALTER TABLE `exam`
  ADD CONSTRAINT `subjects_relation` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`id`),
  ADD CONSTRAINT `teacher_relation` FOREIGN KEY (`t_id`) REFERENCES `teatcher` (`id`);

--
-- Constraints for table `examregister`
--
ALTER TABLE `examregister`
  ADD CONSTRAINT `exam_relation` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`id`),
  ADD CONSTRAINT `student_exam` FOREIGN KEY (`s_id`) REFERENCES `student` (`id`);

--
-- Constraints for table `grade`
--
ALTER TABLE `grade`
  ADD CONSTRAINT `s_grade` FOREIGN KEY (`s_id`) REFERENCES `student` (`id`),
  ADD CONSTRAINT `sub_grade` FOREIGN KEY (`sub_id`) REFERENCES `subject` (`id`),
  ADD CONSTRAINT `t_grade` FOREIGN KEY (`t_id`) REFERENCES `teatcher` (`id`);

--
-- Constraints for table `subject`
--
ALTER TABLE `subject`
  ADD CONSTRAINT `relation` FOREIGN KEY (`t_id`) REFERENCES `teatcher` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
