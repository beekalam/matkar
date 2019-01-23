-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 16, 2018 at 09:28 AM
-- Server version: 5.5.31
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `beniz_masaleh`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(255) NOT NULL,
  `cat_name` varchar(255) NOT NULL,
  `parent` int(255) NOT NULL,
  `pic` varchar(255) NOT NULL,
  `orders` int(11) NOT NULL,
  `depth` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `cat_name`, `parent`, `pic`, `orders`, `depth`) VALUES
(17, 'سیمان', 0, '1533366957.png', 0, 0),
(18, 'آجر', 0, '1533367185.png', 0, 0),
(19, 'سنگ', 0, '1533366987.png', 0, 0),
(20, 'تیر آهن', 0, '1533366998.png', 0, 0),
(21, 'سیمان تیپ 1 ', 17, '', 0, 0),
(22, ' سیمان تیپ 2', 17, '', 0, 0),
(23, ' سیمان تیپ 5', 17, '', 0, 0),
(27, 'آجر فشاری ماشینی', 19, '', 0, 0),
(28, 'آجر فشاری کوره ای', 19, '', 0, 0),
(29, 'آجر ۱۰ سوراخه', 19, '', 0, 0),
(30, 'شن و ماسه', 0, '1533367060.png', 0, 0),
(31, ' شن بادامی ۲٫۰٫۰', 30, '', 0, 0),
(32, ' شن شسته عدسی ۱٫۰٫۰', 30, '', 0, 0),
(33, ' ماسه شکسته خورده سنگ', 30, '', 0, 0),
(34, 'ماسه ۱ بار شسته مخلوط', 30, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `national_code` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `firstname`, `lastname`, `mobile`, `code`, `national_code`, `address`, `email`, `password`, `status`, `created_at`) VALUES
(1, 'mohammad', 'mansouri', '09359012419', '5191', '51399865845', 'address test', 'beekalam@gmail.com', NULL, 1, NULL),
(2, 'ali', 'kala', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(3, 'digi', 'kala', NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL),
(5, NULL, NULL, '546456456', '8882', NULL, NULL, NULL, NULL, 0, '2018-08-14 14:15:20'),
(6, '11', '1', '09179177113', '5415', '1', '1', '1', NULL, 1, '2018-08-14 14:18:56'),
(7, NULL, NULL, '234234234', '9850', NULL, NULL, NULL, NULL, 0, '2018-08-14 14:27:07'),
(8, NULL, NULL, '23232', '1777', NULL, NULL, NULL, NULL, 1, '2018-08-14 14:32:57'),
(9, NULL, NULL, '454545', '5231', NULL, NULL, NULL, NULL, 0, '2018-08-14 14:33:17'),
(10, NULL, NULL, '3333', '7616', NULL, NULL, NULL, NULL, 1, '2018-08-14 14:35:48'),
(11, NULL, NULL, '09173121485 ', '3550', NULL, NULL, NULL, NULL, 0, '2018-08-15 16:32:13'),
(12, NULL, NULL, '0917716054', '8087', NULL, NULL, NULL, NULL, 1, '2018-08-17 16:30:17'),
(13, NULL, NULL, '9177171717', '1488', NULL, NULL, NULL, NULL, 0, '2018-08-17 19:17:20'),
(14, NULL, NULL, '9177172717', '2520', NULL, NULL, NULL, NULL, 1, '2018-08-17 19:17:49'),
(15, NULL, NULL, '09226123978', '4497', NULL, NULL, NULL, NULL, 0, '2018-08-26 17:32:50'),
(16, NULL, NULL, '09177160548', '8374', NULL, NULL, NULL, NULL, 1, '2018-08-31 10:31:37'),
(17, NULL, NULL, '09171111226', '1653', NULL, NULL, NULL, NULL, 1, '2018-09-02 18:27:57'),
(18, NULL, NULL, '09121724230', '6709', NULL, NULL, NULL, NULL, 1, '2018-09-09 18:22:08');

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `trigger_customers_created_at` BEFORE INSERT ON `customers` FOR EACH ROW BEGIN
SET NEW.created_at = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_request_date` varchar(255) NOT NULL,
  `code` int(11) DEFAULT NULL,
  `order_type` enum('CART_ORDER','FINAL_ORDER') NOT NULL,
  `shippment_address` varchar(512) DEFAULT NULL,
  `shippment_date` datetime DEFAULT NULL,
  `user_address` varchar(1024) DEFAULT NULL,
  `order_status` enum('ORDER_CREATED','ORDER_CONFIRMED','ORDER_SHIPPED','ORDER_DELIVERED','ORDER_PREPAYMENT_DONE','ORDER_PAID') NOT NULL DEFAULT 'ORDER_CREATED',
  `prepayment_percent` tinyint(4) DEFAULT NULL COMMENT 'درصد پیش پرداخت',
  `prepayment_amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `created_at`, `updated_at`, `user_request_date`, `code`, `order_type`, `shippment_address`, `shippment_date`, `user_address`, `order_status`, `prepayment_percent`, `prepayment_amount`) VALUES
(2, 1, '2018-07-30 12:53:29', '2018-07-31 14:57:27', '2018-11-08 00:00:00', NULL, 'FINAL_ORDER', '', NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CONFIRMED', NULL, NULL),
(5, 1, '2018-08-11 11:12:48', '2018-08-12 14:07:03', '2018-11-08 00:00:00', NULL, 'FINAL_ORDER', NULL, NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CONFIRMED', 40, NULL),
(7, 1, '2018-08-12 10:09:20', '2018-08-12 14:07:30', '1397-05-25 00:00:00', NULL, 'FINAL_ORDER', NULL, NULL, 'شیراز', 'ORDER_CONFIRMED', 40, NULL),
(8, 1, '2018-08-12 12:28:15', '2018-08-12 14:07:37', '1397-05-21 00:00:00', NULL, 'FINAL_ORDER', NULL, NULL, 'غغ', 'ORDER_CONFIRMED', 10, NULL),
(9, 1, '2018-08-12 12:28:37', '2018-08-12 14:07:43', '1397-05-21 00:00:00', NULL, 'FINAL_ORDER', NULL, NULL, 'شیراز', 'ORDER_CONFIRMED', 38, NULL),
(10, 1, '2018-08-12 13:57:37', '2018-08-12 14:07:53', '1397-05-24 00:00:00', 1534066057, 'FINAL_ORDER', NULL, NULL, 'ششش', 'ORDER_CONFIRMED', 9, NULL),
(11, 1, '2018-08-12 14:22:52', '2018-08-12 14:23:00', '1397/5/31', 1534067572, 'FINAL_ORDER', NULL, NULL, 'زاب', 'ORDER_CREATED', NULL, NULL),
(12, 1, '2018-08-12 15:13:54', '2018-08-14 09:45:16', '1397/5/23', 1534070634, 'FINAL_ORDER', NULL, NULL, 'fhf', 'ORDER_CREATED', NULL, NULL),
(13, 1, '2018-08-16 12:07:00', '2018-08-16 12:07:56', '1397/5/26', 1534405020, 'FINAL_ORDER', NULL, NULL, 'uuuuu', 'ORDER_CREATED', NULL, NULL),
(14, 1, '2018-08-16 12:08:31', '2018-08-16 12:09:16', '1397/5/31', 1534405111, 'FINAL_ORDER', NULL, NULL, 'ghg', 'ORDER_CONFIRMED', 40, NULL),
(15, 1, '2018-08-17 16:30:54', '2018-08-17 18:26:57', '1397/5/26', 1534507254, 'FINAL_ORDER', NULL, NULL, 'ااذدننثثارذ', 'ORDER_CREATED', NULL, NULL),
(16, 1, '2018-08-17 18:27:38', '2018-08-17 18:27:51', '1397/5/28', 1534514258, 'FINAL_ORDER', NULL, NULL, 'تتلر', 'ORDER_CREATED', NULL, NULL),
(17, 1, '2018-08-17 18:30:06', '2018-08-20 10:20:04', '1397/5/29', 1534514406, 'FINAL_ORDER', NULL, NULL, 'vhf', 'ORDER_CREATED', NULL, NULL),
(18, 1, '2018-08-26 12:25:11', '2018-08-26 12:25:24', '1397/6/6', 1535270111, 'FINAL_ORDER', NULL, NULL, 'h', 'ORDER_CREATED', NULL, NULL),
(19, 1, '2018-08-26 17:34:05', '2018-08-29 12:02:54', '1397/6/7', 1535288645, 'FINAL_ORDER', NULL, NULL, 'hhh', 'ORDER_CREATED', NULL, NULL),
(20, 1, '2018-09-01 14:06:49', '2018-09-02 09:31:52', '2018-12-08', 1535794609, 'FINAL_ORDER', NULL, NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CREATED', NULL, NULL),
(21, 1, '2018-09-02 09:32:39', '2018-09-02 09:32:57', '2018-12-08', 1535864559, 'FINAL_ORDER', NULL, NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CREATED', NULL, NULL),
(22, 1, '2018-09-02 09:34:05', '2018-09-02 09:34:25', '2018-12-08', 1535864645, 'FINAL_ORDER', NULL, NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CREATED', NULL, NULL),
(23, 1, '2018-09-02 09:37:04', '2018-09-02 09:37:21', '2018-12-08', 1535864824, 'FINAL_ORDER', NULL, NULL, 'شیراز خیابان اردیبهشت برج it', 'ORDER_CREATED', NULL, NULL),
(24, 1, '2018-09-02 14:12:29', '2018-09-10 13:35:48', 'انتخاب', 1535881349, 'FINAL_ORDER', NULL, NULL, '', 'ORDER_CREATED', NULL, NULL),
(25, 1, '2018-09-10 13:40:25', '2018-09-16 09:25:35', 'انتخاب', 1536570625, 'FINAL_ORDER', NULL, NULL, '', 'ORDER_CREATED', NULL, NULL);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `trigger_orders_created_at` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN
SET NEW.created_at = NOW();
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `triggers_orders_updated_at` BEFORE UPDATE ON `orders` FOR EACH ROW BEGIN
SET NEW.updated_at = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `order_lines`
--

CREATE TABLE `order_lines` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(255) NOT NULL,
  `admin_confirmed_price` int(11) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_lines`
--

INSERT INTO `order_lines` (`id`, `order_id`, `product_id`, `quantity`, `admin_confirmed_price`) VALUES
(2, 2, 17, 3, NULL),
(3, 2, 19, 1, NULL),
(4, 3, 17, 3, 2500),
(5, 4, 17, 3, 0),
(6, 5, 17, 1, 2500),
(7, 6, 17, 3, 0),
(8, 5, 14, 1, 1499),
(9, 7, 14, 1, 1499),
(10, 7, 17, 1, 2500),
(11, 8, 14, 1, 1499),
(12, 9, 14, 1, 1499),
(13, 10, 14, 1, 1499),
(14, 11, 14, 1, 0),
(15, 12, 14, 1, 0),
(16, 13, 14, 1, 0),
(17, 14, 19, 2, 3600),
(18, 15, 17, 221, 0),
(19, 16, 17, 61, 0),
(20, 17, 17, 61, 0),
(21, 17, 14, 1, 0),
(22, 18, 14, 1, 0),
(23, 19, 14, 1, 0),
(24, 20, 14, 1, 0),
(25, 21, 17, 3, 0),
(26, 22, 17, 3, 0),
(27, 23, 17, 3, 0),
(28, 24, 14, 1, 0),
(29, 25, 14, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `main_cat_id` int(255) NOT NULL,
  `price` int(255) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `sub_cat_id` int(11) DEFAULT NULL,
  `price_per_unit` bigint(255) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `reseller_id` int(11) DEFAULT NULL,
  `visits` int(11) NOT NULL DEFAULT '0',
  `num_buys` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `title`, `description`, `main_cat_id`, `price`, `date`, `image`, `sub_cat_id`, `price_per_unit`, `unit_id`, `reseller_id`, `visits`, `num_buys`, `created_at`, `updated_at`) VALUES
(14, 'آجر', 'آجر معمولی', 17, 0, NULL, '', 21, 1499, 3, 1, 79, 0, '0000-00-00 00:00:00', '2018-09-16 09:25:24'),
(17, 'dd', 'سیمان خوبو', 19, 0, NULL, '', 28, 2500, 1, 1, 19, 0, '2018-07-30 11:41:46', '2018-09-05 12:45:09'),
(19, 'tst3', 'بهترین شن و ماسه', 30, 0, NULL, '', 34, 3600, 2, 1, 1, 0, '2018-07-30 13:14:10', '2018-09-05 12:51:04');

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `trigger_products_before_insert` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
SET NEW.created_at = NOW();
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_products_updated_at` BEFORE UPDATE ON `products` FOR EACH ROW BEGIN
SET NEW.updated_at = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_comments`
--

CREATE TABLE `product_comments` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `status` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_comments`
--

INSERT INTO `product_comments` (`id`, `product_id`, `customer_id`, `comment`, `status`) VALUES
(6, 14, 1, 'آشغال بود ، آشغال', 0),
(7, 14, 6, 'عالی', 0),
(8, 17, 6, 'تست', 0),
(9, 19, 6, 'عالی', 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`) VALUES
(9, 14, '1532943953.png'),
(11, 14, '1532943965.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `resellers`
--

CREATE TABLE `resellers` (
  `id` int(11) NOT NULL,
  `reseller_firstname` varchar(255) DEFAULT NULL,
  `reseller_lastname` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `resellers`
--

INSERT INTO `resellers` (`id`, `reseller_firstname`, `reseller_lastname`, `created_at`, `updated_at`) VALUES
(1, 'احمد', 'عابد زاده', '2018-07-31 10:16:32', NULL);

--
-- Triggers `resellers`
--
DELIMITER $$
CREATE TRIGGER `trigger_resellers_updated_at` BEFORE UPDATE ON `resellers` FOR EACH ROW BEGIN 
SET NEW.updated_at = NOW();
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trigger_reserller_created_at` BEFORE INSERT ON `resellers` FOR EACH ROW BEGIN 
SET NEW.created_at = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(11) NOT NULL,
  `slider_image` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `slider_image`, `description`) VALUES
(4, '1533369529.png', 'ssss\r\n\r\nasdfdffdfdfd'),
(5, '1533369541.jpeg', 'qqq'),
(6, '1533369608.png', 'no nonoononononono'),
(7, '1533369627.jpeg', '');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `id` int(11) NOT NULL,
  `unit_name` varchar(255) NOT NULL,
  `unit_desc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`id`, `unit_name`, `unit_desc`) VALUES
(1, 'عدد', NULL),
(2, 'تن', NULL),
(3, 'پاکت', NULL),
(4, 'کیلو', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(255) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `family` varchar(255) CHARACTER SET utf8 NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 NOT NULL,
  `gender` varchar(5) CHARACTER SET utf8 NOT NULL,
  `phone_number` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `mobile_number` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `meli_code` varchar(15) CHARACTER SET utf8 DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `role` int(11) NOT NULL,
  `isadmin` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `family`, `user_name`, `password`, `gender`, `phone_number`, `mobile_number`, `meli_code`, `image`, `created_at`, `role`, `isadmin`) VALUES
(11, 'امین', 'فراحی', 'amin.farahi@ymail.com', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'مرد', '37202461', '09171395594', '2280473313', '1519194885.jpg', NULL, 1, 0),
(12, 'کاربر ', 'ادمین', 'admin', '7c4a8d09ca3762af61e59520943dc26494f8941b', 'مرد', '', '2', '1', '1517727506.jpg', NULL, 1, 1),
(13, 'تست', 'ت', 'test@test.test', '356a192b7913b04c54574d18c28d46e6395428ab', 'مرد', '23423', '234234', '24234234', '1519198799.png', NULL, 3, 0);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_category_detail`
-- (See below for the actual view)
--
CREATE TABLE `view_category_detail` (
`id` int(255)
,`sub_cat_name` varchar(255)
,`parent_cat` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_orders_list`
-- (See below for the actual view)
--
CREATE TABLE `view_orders_list` (
`id` int(11)
,`customer_id` int(11)
,`created_at` datetime
,`updated_at` datetime
,`user_request_date` varchar(255)
,`code` int(11)
,`order_type` enum('CART_ORDER','FINAL_ORDER')
,`shippment_address` varchar(512)
,`shippment_date` datetime
,`user_address` varchar(1024)
,`order_status` enum('ORDER_CREATED','ORDER_CONFIRMED','ORDER_SHIPPED','ORDER_DELIVERED','ORDER_PREPAYMENT_DONE','ORDER_PAID')
,`firstname` varchar(255)
,`lastname` varchar(255)
,`mobile` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_order_lines_detail`
-- (See below for the actual view)
--
CREATE TABLE `view_order_lines_detail` (
`order_id` int(11)
,`product_id` int(11)
,`title` varchar(255)
,`description` text
,`price_per_unit` bigint(255)
,`quantity` int(255)
,`reseller_firstname` varchar(255)
,`reseller_lastname` varchar(255)
,`unit_name` varchar(255)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_products_list`
-- (See below for the actual view)
--
CREATE TABLE `view_products_list` (
`id` int(255)
,`title` varchar(255)
,`description` text
,`main_cat_id` int(255)
,`price` int(255)
,`price_per_unit` bigint(255)
,`reseller_id` int(11)
,`sub_cat_id` int(11)
,`unit_name` varchar(255)
,`sub_cat` varchar(255)
,`visits` int(11)
,`created_at` datetime
,`updated_at` datetime
,`num_buys` int(11)
,`main_cat` varchar(255)
,`reseller_firstname` varchar(255)
,`reseller_lastname` varchar(255)
,`images` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_product_comments`
-- (See below for the actual view)
--
CREATE TABLE `view_product_comments` (
`id` int(11)
,`product_id` int(11)
,`customer_id` int(11)
,`comment` text
,`status` tinyint(4)
,`firstname` varchar(255)
,`lastname` varchar(255)
,`title` varchar(255)
,`description` text
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_user_cart`
-- (See below for the actual view)
--
CREATE TABLE `view_user_cart` (
`order_id` int(11)
,`customer_id` int(11)
,`user_request_date` varchar(255)
,`order_type` enum('CART_ORDER','FINAL_ORDER')
,`title` varchar(255)
,`description` text
,`main_cat_id` int(255)
,`unit_name` varchar(255)
,`created_at` datetime
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_user_orders`
-- (See below for the actual view)
--
CREATE TABLE `view_user_orders` (
`order_id` int(11)
,`customer_id` int(11)
,`user_request_date` varchar(255)
,`order_type` enum('CART_ORDER','FINAL_ORDER')
,`title` varchar(255)
,`description` text
,`main_cat_id` int(255)
,`unit_name` varchar(255)
,`created_at` datetime
);

-- --------------------------------------------------------

--
-- Structure for view `view_category_detail`
--
DROP TABLE IF EXISTS `view_category_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_category_detail`  AS  select `c`.`id` AS `id`,`c`.`cat_name` AS `sub_cat_name`,`c1`.`cat_name` AS `parent_cat` from (`category` `c` join `category` `c1` on((`c`.`parent` = `c1`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_orders_list`
--
DROP TABLE IF EXISTS `view_orders_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_orders_list`  AS  select `orders`.`id` AS `id`,`orders`.`customer_id` AS `customer_id`,`orders`.`created_at` AS `created_at`,`orders`.`updated_at` AS `updated_at`,`orders`.`user_request_date` AS `user_request_date`,`orders`.`code` AS `code`,`orders`.`order_type` AS `order_type`,`orders`.`shippment_address` AS `shippment_address`,`orders`.`shippment_date` AS `shippment_date`,`orders`.`user_address` AS `user_address`,`orders`.`order_status` AS `order_status`,`customers`.`firstname` AS `firstname`,`customers`.`lastname` AS `lastname`,`customers`.`mobile` AS `mobile` from (`orders` join `customers` on((`orders`.`customer_id` = `customers`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_order_lines_detail`
--
DROP TABLE IF EXISTS `view_order_lines_detail`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_order_lines_detail`  AS  select `order_lines`.`order_id` AS `order_id`,`order_lines`.`product_id` AS `product_id`,`products`.`title` AS `title`,`products`.`description` AS `description`,`products`.`price_per_unit` AS `price_per_unit`,`order_lines`.`quantity` AS `quantity`,`resellers`.`reseller_firstname` AS `reseller_firstname`,`resellers`.`reseller_lastname` AS `reseller_lastname`,`units`.`unit_name` AS `unit_name` from (((`order_lines` left join `products` on((`order_lines`.`product_id` = `products`.`id`))) left join `resellers` on((`products`.`reseller_id` = `resellers`.`id`))) left join `units` on((`products`.`unit_id` = `units`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_products_list`
--
DROP TABLE IF EXISTS `view_products_list`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_products_list`  AS  select `products`.`id` AS `id`,`products`.`title` AS `title`,`products`.`description` AS `description`,`products`.`main_cat_id` AS `main_cat_id`,`products`.`price` AS `price`,`products`.`price_per_unit` AS `price_per_unit`,`products`.`reseller_id` AS `reseller_id`,`products`.`sub_cat_id` AS `sub_cat_id`,`units`.`unit_name` AS `unit_name`,`view_category_detail`.`sub_cat_name` AS `sub_cat`,`products`.`visits` AS `visits`,`products`.`created_at` AS `created_at`,`products`.`updated_at` AS `updated_at`,`products`.`num_buys` AS `num_buys`,`view_category_detail`.`parent_cat` AS `main_cat`,`resellers`.`reseller_firstname` AS `reseller_firstname`,`resellers`.`reseller_lastname` AS `reseller_lastname`,group_concat(`product_images`.`image` separator ',') AS `images` from ((((`products` left join `units` on((`products`.`unit_id` = `units`.`id`))) left join `view_category_detail` on((`products`.`sub_cat_id` = `view_category_detail`.`id`))) left join `product_images` on((`product_images`.`product_id` = `products`.`id`))) left join `resellers` on((`products`.`reseller_id` = `resellers`.`id`))) group by `products`.`id` ;

-- --------------------------------------------------------

--
-- Structure for view `view_product_comments`
--
DROP TABLE IF EXISTS `view_product_comments`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_product_comments`  AS  select `product_comments`.`id` AS `id`,`product_comments`.`product_id` AS `product_id`,`product_comments`.`customer_id` AS `customer_id`,`product_comments`.`comment` AS `comment`,`product_comments`.`status` AS `status`,`customers`.`firstname` AS `firstname`,`customers`.`lastname` AS `lastname`,`products`.`title` AS `title`,`products`.`description` AS `description` from ((`product_comments` left join `products` on((`product_comments`.`product_id` = `products`.`id`))) left join `customers` on((`product_comments`.`customer_id` = `customers`.`id`))) ;

-- --------------------------------------------------------

--
-- Structure for view `view_user_cart`
--
DROP TABLE IF EXISTS `view_user_cart`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_user_cart`  AS  select `orders`.`id` AS `order_id`,`orders`.`customer_id` AS `customer_id`,`orders`.`user_request_date` AS `user_request_date`,`orders`.`order_type` AS `order_type`,`products`.`title` AS `title`,`products`.`description` AS `description`,`products`.`main_cat_id` AS `main_cat_id`,`units`.`unit_name` AS `unit_name`,`orders`.`created_at` AS `created_at` from (((`orders` left join `order_lines` on((`orders`.`id` = `order_lines`.`order_id`))) left join `products` on((`order_lines`.`product_id` = `products`.`id`))) left join `units` on((`products`.`unit_id` = `units`.`id`))) where (`orders`.`order_type` = 'CART_ORDER') ;

-- --------------------------------------------------------

--
-- Structure for view `view_user_orders`
--
DROP TABLE IF EXISTS `view_user_orders`;

CREATE ALGORITHM=UNDEFINED DEFINER=`beniz_masaleh`@`localhost` SQL SECURITY DEFINER VIEW `view_user_orders`  AS  select `orders`.`id` AS `order_id`,`orders`.`customer_id` AS `customer_id`,`orders`.`user_request_date` AS `user_request_date`,`orders`.`order_type` AS `order_type`,`products`.`title` AS `title`,`products`.`description` AS `description`,`products`.`main_cat_id` AS `main_cat_id`,`units`.`unit_name` AS `unit_name`,`orders`.`created_at` AS `created_at` from (((`orders` left join `order_lines` on((`orders`.`id` = `order_lines`.`order_id`))) left join `products` on((`order_lines`.`product_id` = `products`.`id`))) left join `units` on((`products`.`unit_id` = `units`.`id`))) where (`orders`.`order_type` = 'FINAL_ORDER') ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_lines`
--
ALTER TABLE `order_lines`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_comments`
--
ALTER TABLE `product_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resellers`
--
ALTER TABLE `resellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`user_name`),
  ADD UNIQUE KEY `api_token` (`image`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;
--
-- AUTO_INCREMENT for table `order_lines`
--
ALTER TABLE `order_lines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `product_comments`
--
ALTER TABLE `product_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `resellers`
--
ALTER TABLE `resellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
