SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS `timba` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `timba`;

CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(11) NOT NULL,
  `customerCode` varchar(6) DEFAULT NULL,
  `typeCode` int(2) NOT NULL,
  `line1` varchar(255) DEFAULT NULL,
  `line2` varchar(255) DEFAULT NULL,
  `line3` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `city` text,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `address_types` (
  `typeCode` int(11) NOT NULL,
  `typeDescription` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `budgets` (
  `date` date NOT NULL,
  `year` int(4) NOT NULL,
  `month` int(2) NOT NULL,
  `days` int(2) NOT NULL,
  `budget` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `bug_status` (
  `id` int(11) NOT NULL,
  `name` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `calendar` (
  `calendarDate` date NOT NULL,
  `day` int(2) NOT NULL,
  `month` int(2) NOT NULL,
  `year` int(4) NOT NULL,
  `dayOfWeek` int(11) NOT NULL,
  `dayOfMonth` int(2) NOT NULL,
  `dayOfYear` int(3) NOT NULL,
  `weekOfMonth` int(11) NOT NULL,
  `weekday` tinyint(1) NOT NULL,
  `weekend` tinyint(1) NOT NULL,
  `workDay` tinyint(4) NOT NULL,
  `payday` tinyint(1) NOT NULL,
  `holiday` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `contacts` (
  `id` int(11) NOT NULL,
  `customerCode` varchar(13) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(28) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(68) COLLATE utf8_unicode_ci DEFAULT NULL,
  `directDial` varchar(35) COLLATE utf8_unicode_ci DEFAULT NULL,
  `position` varchar(59) COLLATE utf8_unicode_ci DEFAULT NULL,
  `role` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `contact_record` (
  `id` int(11) NOT NULL,
  `date` datetime DEFAULT NULL,
  `customerCode` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact` int(10) DEFAULT NULL,
  `job` int(10) DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  `contactType` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `contactReference` text COLLATE utf8_unicode_ci,
  `details` text COLLATE utf8_unicode_ci,
  `infoSent` text COLLATE utf8_unicode_ci,
  `attachments` int(11) DEFAULT NULL,
  `followUpDate` date DEFAULT NULL,
  `followUpUser` int(5) DEFAULT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `contact_roles` (
  `id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `contact_type` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `icon` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
  `style` varchar(7) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `customers` (
  `customerCode` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `customerName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customerPhone` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customerFax` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customerEmail` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `freightArea` int(11) DEFAULT NULL,
  `freightCarrier` int(11) DEFAULT NULL,
  `salesArea` int(11) DEFAULT NULL,
  `customerStatus` int(11) DEFAULT NULL,
  `defaultAddress` int(11) DEFAULT NULL,
  `billingAddress` int(11) DEFAULT NULL,
  `defaultContact` int(11) DEFAULT NULL,
  `customerGroup` int(11) DEFAULT NULL,
  `branchCode` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `customer_addresses` (
  `customerAddressId` int(11) NOT NULL,
  `addressId` int(11) NOT NULL,
  `typeCode` int(11) NOT NULL,
  `customerCode` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_groups` (
  `id` int(11) NOT NULL,
  `name` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `headOffice` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `customer_notes` (
  `id` int(11) NOT NULL,
  `customerCode` varchar(6) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `note` text NOT NULL,
  `date` date NOT NULL,
  `user` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `customer_status` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `style` text NOT NULL,
  `active` tinyint(1) NOT NULL,
  `warning` tinyint(1) NOT NULL,
  `statusNote` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `daily_sales` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `quoted` tinyint(1) NOT NULL DEFAULT '0',
  `customerReference` varchar(255) DEFAULT NULL,
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `rep` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `dryness` (
  `id` int(11) NOT NULL,
  `shortCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `email_confirmations` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `code` char(32) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `confirmed` char(1) DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `failed_logins` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned DEFAULT NULL,
  `ipAddress` char(15) NOT NULL,
  `attempted` smallint(5) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS feedback (
    time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user VARCHAR(255) NOT NULL,
    uri VARCHAR(255) NOT NULL,
    opinion VARCHAR(255),
    feedback TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `finish` (
  `id` int(11) NOT NULL,
  `shortCode` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `follow_up` (
  `id` int(11) NOT NULL,
  `customerCode` varchar(6) DEFAULT NULL,
  `contact` int(5) DEFAULT NULL,
  `job` int(10) DEFAULT NULL,
  `user` int(11) NOT NULL,
  `date` date NOT NULL,
  `notes` text,
  `followUpDate` date DEFAULT NULL,
  `followUpUser` int(11) DEFAULT NULL,
  `followUpNotes` text,
  `completed` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `freight_areas` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `freight_carriers` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `generic_status` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `style` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `grade` (
  `id` int(11) NOT NULL,
  `shortCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `species` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `kpis` (
  `id` int(5) NOT NULL,
  `date` date NOT NULL,
  `chargeOut` int(11) NOT NULL,
  `sales` varchar(10) NOT NULL,
  `onsiteDispatch` varchar(10) NOT NULL,
  `offsiteDispatch` varchar(10) NOT NULL,
  `ordersSent` int(3) NOT NULL,
  `truckTime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `orders` (
  `orderNumber` int(7) NOT NULL,
  `customerCode` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customerRef` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `eta` date DEFAULT NULL,
  `quoted` tinyint(1) NOT NULL,
  `complete` tinyint(1) NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cancelled` tinyint(1) NOT NULL,
  `scheduled` tinyint(1) DEFAULT NULL,
  `location` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `order_items` (
  `grade` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `treatment` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `dryness` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `finish` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `width` int(11) NOT NULL,
  `thickness` int(11) NOT NULL,
  `length` decimal(10,0) NOT NULL,
  `dry` tinyint(1) NOT NULL,
  `customerCode` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `orderNo` int(11) NOT NULL,
  `itemNo` int(11) NOT NULL,
  `requiredBy` date NOT NULL,
  `ordered` decimal(10,0) NOT NULL,
  `sent` decimal(10,0) NOT NULL,
  `outstanding` decimal(10,0) NOT NULL,
  `unit` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `despatch` tinyint(1) NOT NULL,
  `comments` text COLLATE utf8_unicode_ci,
  `orderStock` tinyint(1) NOT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `despatchNotes` text COLLATE utf8_unicode_ci,
  `location` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `order_locations` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `customerCode` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE IF NOT EXISTS `password_changes` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(48) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pbt_consignments` (
  `conNote` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `pbtConsignmentNote` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `numberOfItems` int(11) DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `pickupDate` date DEFAULT NULL,
  `podDate` date DEFAULT NULL,
  `podTime` time DEFAULT NULL,
  `deliveryBy` text COLLATE utf8_unicode_ci,
  `podSignature` text COLLATE utf8_unicode_ci,
  `deliveryCourier` text COLLATE utf8_unicode_ci,
  `ticketNo` text COLLATE utf8_unicode_ci,
  `cost` float DEFAULT NULL,
  `runsheet` text COLLATE utf8_unicode_ci,
  `accountNo` int(11) DEFAULT NULL,
  `volume` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(10) unsigned NOT NULL,
  `profilesId` int(10) unsigned NOT NULL,
  `resource` varchar(16) NOT NULL,
  `action` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `pricing_unit` (
  `id` int(11) NOT NULL,
  `name` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `profiles` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `active` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `quotes` (
  `quoteId` int(9) NOT NULL,
  `webId` char(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `date` date DEFAULT NULL,
  `customerCode` varchar(53) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user` varchar(37) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attention` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `contact` int(11) DEFAULT NULL,
  `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `moreNotes` varchar(198) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reference` varchar(68) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `validity` int(4) DEFAULT '30',
  `sale` bit(1) DEFAULT NULL,
  `freight` decimal(6,2) DEFAULT NULL,
  `directDial` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `leadTime` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `quote_codes` (
  `code` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `grade` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `treatment` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `dryness` varchar(5) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `quote_items` (
  `id` int(11) NOT NULL,
  `quoteId` int(11) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `thickness` int(11) DEFAULT NULL,
  `grade` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finish` varchar(29) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callSize` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finSize` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lengths` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priceUnit` int(11) DEFAULT NULL,
  `unitPrice` double(9,2) DEFAULT NULL,
  `lineValue` decimal(9,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `quote_items_backup` (
  `id` int(11) NOT NULL,
  `quoteId` int(11) NOT NULL,
  `width` int(11) DEFAULT NULL,
  `thickness` int(11) DEFAULT NULL,
  `grade` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finish` varchar(29) COLLATE utf8_unicode_ci DEFAULT NULL,
  `callSize` varchar(18) COLLATE utf8_unicode_ci DEFAULT NULL,
  `finSize` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lengths` varchar(48) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qty` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL,
  `priceUnit` int(11) DEFAULT NULL,
  `unitPrice` varchar(9) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `remember_tokens` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `token` char(32) NOT NULL,
  `userAgent` varchar(120) NOT NULL,
  `createdAt` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `reset_passwords` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `code` varchar(48) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `modifiedAt` int(10) unsigned DEFAULT NULL,
  `reset` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `sales_areas` (
  `id` int(11) NOT NULL,
  `name` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `agent` int(11) DEFAULT NULL,
  `nicename` varchar(120) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `species` (
  `id` int(11) NOT NULL,
  `name` text COLLATE utf8_unicode_ci NOT NULL,
  `scientificName` text COLLATE utf8_unicode_ci NOT NULL,
  `hardwood` tinyint(1) NOT NULL,
  `native` tinyint(1) NOT NULL,
  `imported` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `success_logins` (
  `id` int(10) unsigned NOT NULL,
  `usersId` int(10) unsigned NOT NULL,
  `ipAddress` char(15) NOT NULL,
  `userAgent` varchar(120) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `followUp` date DEFAULT NULL,
  `completed` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `treatment` (
  `id` int(11) NOT NULL,
  `shortCode` varchar(10) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `position` varchar(50) DEFAULT NULL,
  `directDial` varchar(50) DEFAULT NULL,
  `password` char(60) NOT NULL,
  `mustChangePassword` char(1) DEFAULT NULL,
  `suspended` boolean NOT NULL DEFAULT '0',
  `active` boolean NOT NULL DEFAULT '1',
  `administrator` boolean NOT NULL DEFAULT '0',
  `developer` boolean NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `address_types`
  ADD PRIMARY KEY (`typeCode`);

ALTER TABLE `budgets`
  ADD PRIMARY KEY (`date`),
  ADD UNIQUE KEY `date` (`date`);

ALTER TABLE `bug_status`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `calendar`
  ADD PRIMARY KEY (`calendarDate`),
  ADD UNIQUE KEY `calendar_date` (`calendarDate`),
  ADD KEY `weekday` (`weekday`),
  ADD KEY `weekend` (`weekend`),
  ADD KEY `payday` (`payday`),
  ADD KEY `holiday` (`holiday`),
  ADD KEY `day` (`day`),
  ADD KEY `month` (`month`),
  ADD KEY `year` (`year`),
  ADD KEY `dayOfMonth` (`dayOfMonth`),
  ADD KEY `dayOfYear` (`dayOfYear`),
  ADD KEY `workDay` (`workDay`);

ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `contact_record`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `customerCode` (`customerCode`),
  ADD KEY `job` (`job`),
  ADD KEY `contact` (`contact`),
  ADD KEY `user` (`user`);

ALTER TABLE `contact_roles`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `contact_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `customers`
  ADD PRIMARY KEY (`customerCode`),
  ADD UNIQUE KEY `customerCode` (`customerCode`),
  ADD KEY `customerGroup` (`defaultAddress`),
  ADD KEY `freightArea` (`freightArea`,`freightCarrier`,`salesArea`,`customerStatus`,`defaultAddress`,`defaultContact`),
  ADD KEY `customerStatus` (`customerStatus`),
  ADD KEY `freightCarrier` (`freightCarrier`),
  ADD KEY `salesArea` (`salesArea`),
  ADD KEY `customerGroup_2` (`customerGroup`);

ALTER TABLE `customer_addresses`
  ADD PRIMARY KEY (`customerAddressId`),
  ADD UNIQUE KEY `addressId` (`customerAddressId`),
  ADD KEY `addressId_2` (`addressId`,`typeCode`,`customerCode`),
  ADD KEY `typeCode` (`typeCode`),
  ADD KEY `customerCode` (`customerCode`);

ALTER TABLE `customer_groups`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customer_notes`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customer_status`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `daily_sales`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `dryness`
  ADD UNIQUE KEY `shortCode` (`shortCode`);

ALTER TABLE `email_confirmations`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `failed_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usersId` (`usersId`);

ALTER TABLE `finish`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shortCode` (`shortCode`);

ALTER TABLE `follow_up`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `freight_areas`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `freight_carriers`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `generic_status`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `grade`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `shortCode` (`shortCode`);

ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderNumber`);

ALTER TABLE `order_items`
  ADD PRIMARY KEY (`orderNo`,`itemNo`);

ALTER TABLE `order_locations`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `password_changes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usersId` (`usersId`);

ALTER TABLE `pbt_consignments`
  ADD PRIMARY KEY (`pbtConsignmentNote`),
  ADD UNIQUE KEY `idx_name` (`pbtConsignmentNote`);

ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profilesId` (`profilesId`);

ALTER TABLE `pricing_unit`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

ALTER TABLE `profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `active` (`active`);

ALTER TABLE `quotes`
  ADD PRIMARY KEY (`quoteId`),
  ADD UNIQUE KEY `webId` (`webId`),
  ADD KEY `webId_2` (`webId`);

ALTER TABLE `quote_codes`
  ADD PRIMARY KEY (`code`);

ALTER TABLE `quote_items`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `quote_items_backup`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `remember_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `token` (`token`);

ALTER TABLE `reset_passwords`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usersId` (`usersId`);

ALTER TABLE `sales_areas`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `species`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `success_logins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usersId` (`usersId`);

ALTER TABLE `tasks`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `treatment`
  ADD UNIQUE KEY `shortCode` (`shortCode`);

ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `address_types`
  MODIFY `typeCode` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `bug_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `contact_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `contact_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `customer_addresses`
  MODIFY `customerAddressId` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `customer_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `customer_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `customer_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `daily_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `email_confirmations`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `failed_logins`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `finish`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `follow_up`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `freight_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `freight_carriers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `grade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `kpis`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;
ALTER TABLE `order_locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `password_changes`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `permissions`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `pricing_unit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `profiles`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `quotes`
  MODIFY `quoteId` int(9) NOT NULL AUTO_INCREMENT;
ALTER TABLE `quote_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `quote_items_backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `remember_tokens`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `reset_passwords`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `sales_areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `species`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `success_logins`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
ALTER TABLE `tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
ALTER TABLE `users`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
