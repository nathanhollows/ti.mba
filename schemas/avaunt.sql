-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2015 at 09:05 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `avaunt`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE IF NOT EXISTS `customers` (
  `customerId` varchar(6) NOT NULL DEFAULT '',
  `customerPhone` varchar(25) DEFAULT NULL,
  `customerEmail` varchar(25) DEFAULT NULL,
  `defaultNotes` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer_orders`
--

CREATE TABLE IF NOT EXISTS `customer_orders` (
  `orderId` int(11) NOT NULL,
  `customerId` varchar(10) DEFAULT NULL,
  `orderStatusCode` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE IF NOT EXISTS `order_items` (
  `orderItemId` int(11) DEFAULT NULL,
  `orderId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_notes`
--

CREATE TABLE IF NOT EXISTS `order_notes` (
  `orderId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `note` char(0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `order_status_codes`
--

CREATE TABLE IF NOT EXISTS `order_status_codes` (
  `orderStatusCode` int(3) NOT NULL DEFAULT '0',
  `orderStatusDescription` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `username` varchar(70) NOT NULL,
  `email` varchar(70) NOT NULL,
  `password` varchar(255) NOT NULL,
  `active` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerId`);

--
-- Indexes for table `customer_orders`
--
ALTER TABLE `customer_orders`
  ADD PRIMARY KEY (`orderId`);

--
-- Indexes for table `order_status_codes`
--
ALTER TABLE `order_status_codes`
  ADD PRIMARY KEY (`orderStatusCode`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer_orders`
--
ALTER TABLE `customer_orders`
  MODIFY `orderId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
