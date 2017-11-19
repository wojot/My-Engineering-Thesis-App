-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Czas generowania: 16 Cze 2017, 19:30
-- Wersja serwera: 10.1.10-MariaDB
-- Wersja PHP: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `inz_shop`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `bank`
--

CREATE TABLE `bank` (
  `id` int(11) NOT NULL,
  `bankName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ownerName` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `IBAN` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `bank`
--

INSERT INTO `bank` (`id`, `bankName`, `ownerName`, `IBAN`) VALUES
(1, 'mBank', 'Wojciech Ciuba', 'PL11 2222 3333 4444 5555 6666 7777');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `carrier`
--

CREATE TABLE `carrier` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_time` int(11) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `max_weight` decimal(10,2) NOT NULL,
  `active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `carrier`
--

INSERT INTO `carrier` (`id`, `name`, `delivery_time`, `cost`, `max_weight`, `active`) VALUES
(5, 'Odbiór osobisty', 0, '0.00', '999.00', 1),
(6, 'DPD', 2, '14.99', '50.00', 1),
(7, 'DHL', 2, '19.99', '200.00', 1),
(8, 'UPS', 3, '19.99', '50.00', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(8, 'Skrzynie', 'Kategoria zawiera różnego rodzaju skrzynie.'),
(9, 'Koszyki', 'W tej kategorii można znaleźć koszyki.'),
(10, 'Ozdoby', 'Różne drewniane ozdoby.'),
(11, 'Zabawki drewniane', 'Zabawki wyprodukowane z drewna.'),
(12, 'Akcesoria', 'Kategoria zawiera akcesoria z drewna.');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `content` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `comment`
--

INSERT INTO `comment` (`id`, `user_id`, `product_id`, `content`, `date`) VALUES
(1, 1, 97, '<p>Zabawka bardzo solidnie zbudowana.</p>', '2017-04-23 09:55:10');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `fos_user`
--

CREATE TABLE `fos_user` (
  `id` int(11) NOT NULL,
  `username` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `username_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `email_canonical` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `salt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `confirmation_token` varchar(180) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password_requested_at` datetime DEFAULT NULL,
  `roles` longtext COLLATE utf8_unicode_ci NOT NULL COMMENT '(DC2Type:array)',
  `name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `postcode` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `city` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `street` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `tel` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `fos_user`
--

INSERT INTO `fos_user` (`id`, `username`, `username_canonical`, `email`, `email_canonical`, `enabled`, `salt`, `password`, `last_login`, `confirmation_token`, `password_requested_at`, `roles`, `name`, `surname`, `postcode`, `city`, `street`, `tel`) VALUES
(1, 'wojtekc', 'wojtekc', 'wojotek@gmail.com', 'wojotek@gmail.com', 1, NULL, '$2y$13$7g/uDIPh9O.kPNojlD7wguJLrp1dHHdZaXnzBFytP0gQi0Ft1speu', '2017-06-06 14:05:51', NULL, NULL, 'a:1:{i:0;s:10:"ROLE_ADMIN";}', 'Wojciech', 'Ciuba', '32-640', 'Podolsze', 'Jutrzenki 5', '666700779'),
(4, 'jank', 'jank', 'uzytkownik@wp.pl', 'uzytkownik@wp.pl', 1, NULL, '$2y$13$2cKE4phSwqSCFHPITqwkYec6Qi1Q7Li1CGKFnypScNGw15jCH5F/m', '2017-04-23 10:02:28', NULL, NULL, 'a:0:{}', 'Jan', 'Kowalski', '32-640', 'Zator', 'Wiosenna 5', '555 666 777'),
(5, 'tomekn', 'tomekn', 'tomek@onet.pl', 'tomek@onet.pl', 1, NULL, '$2y$13$BjJjVoWwLUAirTKWS5Ww1u4jDusEpK33B/o9EhKjA0oxx7kUKbDI.', '2017-04-23 10:04:22', NULL, NULL, 'a:0:{}', 'Tomasz', 'Nowak', '32-600', 'Przeciszów', 'Stawowa 10', '777 888 999'),
(6, 'annaw', 'annaw', 'anna@interia.pl', 'anna@interia.pl', 1, NULL, '$2y$13$wbj27yD1J7uwPLKIzpamfe1NmpPb6MRgfKFFrtA2cVIyl.Wd50E56', '2017-04-23 10:05:55', NULL, NULL, 'a:0:{}', 'Anna', 'Wiśniewska', '31-153', 'Kraków', 'Szlak 15', '777 777 999'),
(7, 'olak', 'olak', 'ola@gmail.com', 'ola@gmail.com', 1, NULL, '$2y$13$IieLYHEx55kthENNC0QD8uYOOuyRGcOcpCjPFWZfFtBQGeXEOyb66', '2017-04-23 10:08:50', NULL, NULL, 'a:0:{}', 'Aleksandra', 'Kamińska', '32-651', 'Kęty', 'Akacjowa 20', '500 600 700');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `image`
--

INSERT INTO `image` (`id`, `image`, `product_id`) VALUES
(139, '5eba979c7aa48b192d6902c132965797.jpeg', 54),
(140, 'a8c028db9f217cb05fc9bfadf6bb9037.jpeg', 54),
(141, 'b9241b00cf8e5594fa79a8d1dcd2da3f.jpeg', 54),
(142, '4b73d140c4f6b91bc2136e21fd1679e5.jpeg', 55),
(143, '40bad0e35099c5c91881729bf50d243f.jpeg', 55),
(144, '1b6253cc567f29ae5f3972d7e3b896ca.jpeg', 56),
(145, 'f1bfe90f8416a8d0681aa7c641e7a7e2.jpeg', 56),
(146, '1890a40f590d2c79f45f9830cea5be1d.jpeg', 57),
(147, 'ee18b83c349d032f65106cf6ecca341c.jpeg', 57),
(148, 'd78a0082359f100542733d97d09c5057.jpeg', 58),
(149, 'e6b4c3bb7fdfad420b0887536a933654.jpeg', 59),
(150, '4d8f667bda494946d2098c2b8d2b787f.jpeg', 59),
(151, 'c6d7982c49cfd38401fdb30391d437f1.jpeg', 60),
(152, 'ca8c46758a1697001ab527f6a1ca4ee9.jpeg', 60),
(153, '8b1f844e5271ec9d16250ab0688f342e.jpeg', 61),
(154, '58d43eac7b2f5dc8e1a21752c2ee0442.jpeg', 62),
(155, '1973b77ad3fab9f916921927bf82e170.jpeg', 62),
(156, '6370b3410f07938eed290eb48aa6d52d.jpeg', 63),
(157, '90c5bf44a4d049dcc271f1b1214f8dee.jpeg', 63),
(158, '2ad1df7fc007b32fbcf598cdf7cb0672.jpeg', 64),
(159, 'ee8d4b695ab7f556ccaa3d1e4a805754.jpeg', 65),
(160, 'a3333127570a483c46ae195ed02404e7.jpeg', 66),
(161, '806600e66c13137fa8cd543dbbb9abe5.jpeg', 67),
(162, '3fac6a7fc25d52cdbf848b40b05f93ad.jpeg', 68),
(163, '61d2898a602f7db617487bc2729ec457.jpeg', 69),
(164, '9735dfc2f48c77ce8513d90bc34f9a57.jpeg', 70),
(165, '85177de8a2cda0e0c42d348c9826bb58.jpeg', 71),
(166, 'f3c79321298296bc87a6d708c43bec6b.jpeg', 72),
(167, 'dcba36ced05ebdbe918bc60eb999c0b0.jpeg', 73),
(168, 'a773f888993bb0268b88f9d6d2de6b6e.jpeg', 74),
(169, '7abe8c7d60ffd2d36c6df21ec11a3439.jpeg', 75),
(170, '864d947103f3fd3b062caa14b999ddbb.jpeg', 76),
(171, '8994d2e3bfbcf44cf5fd470f31cd1757.jpeg', 77),
(172, '485c352c8006e2c512eb11f7e69d8d21.jpeg', 78),
(173, '7126c3b4fd65186b323e414d11746054.jpeg', 79),
(174, 'bdbbd857786197a54f6c831812e0d6dd.jpeg', 80),
(175, '577dd063d61424ff0a8448df95ca8869.jpeg', 81),
(176, '8317cf9d0c3cc89d897e7559900934e9.jpeg', 82),
(177, '537b52be2a7463d24df206ec86fb0a44.jpeg', 83),
(178, 'd4bb9492bc5c07e1d83531c6bef73256.jpeg', 84),
(179, '69185ba051c5e8de2c2f44aa0949b856.jpeg', 85),
(180, 'eeb2728d868d2eb7a9ee534466068a32.jpeg', 86),
(181, 'a6e0fb1bb89247092b554a970104b40b.jpeg', 87),
(182, '968be9c6d330ae76cc124da4e97a3b28.jpeg', 87),
(186, '8c63fcf86fd41c107173ce7e401d0cc6.jpeg', 87),
(187, '9d10d2e9924cdcc4aa8cf6d63092ad28.jpeg', 87),
(188, 'f412d9383c612a62a6bc0d27087cf35a.jpeg', 87),
(189, 'c8540c54f57e031463ca2880800c4ab0.jpeg', 88),
(190, '8f816393a6a147a9abdf1a7335b364a4.jpeg', 89),
(191, '808f9f863095601c436b0302608b6219.jpeg', 90),
(192, '6237fe5441a092c4a78f87f932c08ee6.jpeg', 91),
(193, 'fb9bf1b221259eeb3879c66c4181ecda.jpeg', 92),
(194, '66621f131ca100a1bfeb4ff3a100fa23.jpeg', 93),
(195, 'b57286cbdd5e9b130d64bb834e09278b.jpeg', 94),
(196, '560e3a8d98e8d98aed546ff49298c5c5.jpeg', 95),
(197, '5ee694d3824db4735aaa23317eb2cbfc.jpeg', 96),
(198, '5e0fdc4ecb7aecf92c8514301cdbb2e2.jpeg', 97),
(199, '6dc6a6e970eecb3fcbd5d499e468588d.jpeg', 98),
(200, '59593c609b36768ff5c54cb0093569d9.jpeg', 99),
(201, 'e0918935e212e1d6ba3cbd5dd9bbd64e.jpeg', 100),
(202, '467a4d39923eefd95b6ba679364c6457.jpeg', 101);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `carrier_id` int(11) DEFAULT NULL,
  `notice` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `orders`
--

INSERT INTO `orders` (`id`, `date`, `user_id`, `carrier_id`, `notice`) VALUES
(1, '2017-04-23 09:57:34', 1, 6, 'Poproszę wszystko w jednej paczce.'),
(2, '2017-04-23 10:03:11', 4, 7, NULL),
(3, '2017-04-23 10:04:06', 4, 5, NULL),
(4, '2017-04-23 10:04:59', 5, 5, NULL),
(5, '2017-04-23 10:06:54', 6, 6, NULL),
(6, '2017-04-23 10:10:51', 7, 7, NULL),
(7, '2017-05-13 08:14:32', 1, 5, NULL),
(8, '2017-05-18 23:45:45', 1, 5, NULL);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `orders_products`
--

CREATE TABLE `orders_products` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `orders_products`
--

INSERT INTO `orders_products` (`id`, `order_id`, `amount`, `product_id`) VALUES
(1, 1, 5, 97),
(2, 1, 1, 94),
(3, 2, 1, 100),
(4, 2, 1, 96),
(5, 2, 1, 91),
(6, 2, 1, 73),
(7, 3, 1, 101),
(8, 4, 1, 60),
(9, 4, 1, 61),
(10, 4, 1, 57),
(11, 4, 1, 56),
(12, 5, 1, 90),
(13, 5, 1, 91),
(14, 5, 1, 89),
(15, 5, 1, 85),
(16, 5, 1, 82),
(17, 5, 1, 83),
(18, 6, 1, 85),
(19, 6, 1, 83),
(20, 6, 3, 82),
(21, 7, 1, 60),
(22, 8, 1, 101);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `width` decimal(10,2) NOT NULL,
  `height` decimal(10,2) NOT NULL,
  `depth` decimal(10,2) NOT NULL,
  `weight` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  `deleted` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `width`, `height`, `depth`, `weight`, `active`, `deleted`) VALUES
(54, 8, 'Skrzynia duża', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '49.00', '50.00', '50.00', '30.00', 5, 1, 0),
(55, 8, 'Skrzynia mała', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '29.00', '20.00', '20.00', '30.00', 2, 1, 0),
(56, 8, 'Skrzynia zamykana duża', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '99.00', '50.00', '50.00', '30.00', 7, 1, 0),
(57, 8, 'Skrzynia - szkatułka', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '25.00', '20.00', '20.00', '10.00', 2, 1, 0),
(58, 8, 'Skrzynia - szkatułka otwierana', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '29.00', '20.00', '20.00', '10.00', 2, 1, 0),
(59, 8, 'Skrzynia impregnowana', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '149.00', '40.00', '20.00', '40.00', 6, 1, 0),
(60, 8, 'Skrzynia impregnowana otwierana', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '199.00', '40.00', '20.00', '40.00', 7, 1, 0),
(61, 8, 'Skrzynia niska', '<p>Opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni<br />\r\n<strong>Opis skrzyni</strong></p>\r\n\r\n<p>opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni opis skrzyni</p>', '19.00', '40.00', '20.00', '40.00', 2, 1, 0),
(62, 9, 'Koszyk zielony', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '19.99', '25.00', '15.00', '20.00', 1, 1, 0),
(63, 9, 'Koszyk zielony z uchwytem', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '19.99', '25.00', '15.00', '20.00', 1, 1, 0),
(64, 9, 'Koszyk kwadratowy', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '9.99', '20.00', '20.00', '20.00', 1, 1, 0),
(65, 9, 'Koszyk półokrągły', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '15.00', '20.00', '20.00', '20.00', 1, 1, 0),
(66, 9, 'Koszyk prostokątny z uchwytem', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '9.00', '30.00', '20.00', '20.00', 1, 1, 0),
(67, 9, 'Koszyk z uchwytem', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '9.00', '30.00', '20.00', '20.00', 1, 1, 0),
(68, 9, 'Koszyk z uszami', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '26.00', '30.00', '20.00', '20.00', 1, 1, 0),
(69, 9, 'Koszyk z małym uchem', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '9.99', '30.00', '20.00', '20.00', 1, 1, 0),
(70, 9, 'Koszyk wysoki', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '9.99', '30.00', '20.00', '20.00', 1, 1, 0),
(71, 9, 'Koszyk wiadro', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '19.99', '30.00', '20.00', '20.00', 1, 1, 0),
(72, 9, 'Koszyk półokrągły wysoki', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '29.99', '30.00', '20.00', '20.00', 1, 1, 0),
(73, 9, 'Koszyczek mały', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '29.99', '10.00', '5.00', '5.00', 1, 1, 0),
(74, 9, 'Koszyczek bardzo mały', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '29.99', '5.00', '2.00', '2.00', 1, 1, 0),
(75, 9, 'Koszyki z otwarciem', '<p><strong>Opis koszyk&oacute;w</strong></p>\r\n\r\n<p>Opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\nopis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w opis koszyk&oacute;w<br />\r\n&nbsp;</p>', '29.99', '20.00', '5.00', '10.00', 1, 1, 0),
(76, 10, 'Zestaw ozdób', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '99.99', '5.00', '5.00', '1.00', 1, 1, 0),
(77, 10, 'Ozdoba - motyl', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(78, 10, 'Ozdoba - kura', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(79, 10, 'Ozdoba - pies', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(80, 10, 'Ozdoba - koń', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(81, 10, 'Ozdoba - słoń', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(82, 10, 'Ozdoba - miś', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(83, 10, 'Ozdoba - owca', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(84, 10, 'Ozdoba - dzwon', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(85, 10, 'Ozdoba - choinka', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(86, 10, 'Ozdoba - krowa', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(87, 10, 'Zestaw ozdób - zwierzęta', '<p><strong>Opis ozdoby</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '89.99', '5.00', '5.00', '1.00', 1, 1, 0),
(88, 12, 'Kolczyk koniczyna', '<p><strong>Opis akcesorium</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(89, 12, 'Kolczyk', '<p><strong>Opis akcesorium</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(90, 12, 'Kolczyk z sercem', '<p><strong>Opis akcesorium</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(91, 12, 'Kolczyk paski', '<p><strong>Opis akcesorium</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(92, 12, 'Kolczyk z dużym sercem', '<p><strong>Opis akcesorium</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '9.99', '5.00', '5.00', '1.00', 1, 1, 0),
(93, 11, 'Formuła 1', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '39.99', '5.00', '5.00', '1.00', 1, 1, 0),
(94, 11, 'Helikopter', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '49.99', '30.00', '20.00', '15.00', 2, 1, 0),
(95, 11, 'Sypialnia', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '199.99', '30.00', '20.00', '15.00', 5, 1, 0),
(96, 11, 'Salon', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '199.99', '30.00', '20.00', '15.00', 5, 1, 0),
(97, 11, 'Samolot', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '70.00', '30.00', '20.00', '15.00', 5, 1, 0),
(98, 11, 'Autobus', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '70.00', '30.00', '20.00', '15.00', 3, 1, 0),
(99, 11, 'Laweta', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '70.00', '30.00', '20.00', '15.00', 3, 1, 0),
(100, 11, 'Traktor i spychacz zestaw', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '60.00', '30.00', '20.00', '15.00', 3, 1, 0),
(101, 11, 'Ciężarówka', '<p><strong>Opis zabawki</strong><br />\r\nOpis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis<br />\r\nopis opis opis opis opis opis opis opis opis opis opis opis opis opis opis opis</p>\r\n\r\n<p>&nbsp;</p>', '99.99', '30.00', '20.00', '15.00', 4, 1, 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `slide`
--

CREATE TABLE `slide` (
  `id` int(11) NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `slide`
--

INSERT INTO `slide` (`id`, `image`, `position`) VALUES
(26, 'ca1fef92dc4d819c85c9bdab2a8a83aajpeg', 1),
(28, '3b0f8cab02bfaeaf0f7fedf7482342a4jpeg', 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `static`
--

CREATE TABLE `static` (
  `id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `titleRewrited` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` varchar(1024) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Zrzut danych tabeli `static`
--

INSERT INTO `static` (`id`, `title`, `titleRewrited`, `content`) VALUES
(6, 'Regulamin', 'regulamin', '<p>Regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu</p>\r\n\r\n<ul>\r\n	<li>regulamin sklepu regulamin sklepu regulamin sklepu</li>\r\n	<li>regulamin sklepu regulamin sklepu regulamin sklepu regulamin sklepu</li>\r\n	<li>regulamin sklepu <strong>regulamin sklepu</strong></li>\r\n</ul>'),
(8, 'Kontakt', 'kontakt', '<p>Zapraszamy do kontaktu. Godziny otwarcia firmy:</p>\r\n\r\n<ul>\r\n	<li>Poniedziałek - Piątek 9:00 - 17:00</li>\r\n	<li>Sobota 9:00 - 13:00</li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<hr />\r\n<p>Numer telefonu: 555 666 777<br />\r\nEmail: kontakt@sklep.pl<br />\r\n&nbsp;</p>'),
(9, 'O nas', 'o-nas', '<p>Informacje o firmie</p>\r\n\r\n<p>Adres:<br />\r\nAdres adres<br />\r\nAdres <strong>adres</strong><br />\r\n​​​​​​​Adres adres<br />\r\n<br />\r\nZapraszamy do kontaktu.</p>');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carrier`
--
ALTER TABLE `carrier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_9474526CA76ED395` (`user_id`),
  ADD KEY `IDX_9474526C4584665A` (`product_id`);

--
-- Indexes for table `fos_user`
--
ALTER TABLE `fos_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_957A647992FC23A8` (`username_canonical`),
  ADD UNIQUE KEY `UNIQ_957A6479A0D96FBF` (`email_canonical`),
  ADD UNIQUE KEY `UNIQ_957A6479C05FB297` (`confirmation_token`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045F4584665A` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E52FFDEEA76ED395` (`user_id`),
  ADD KEY `IDX_E52FFDEE21DFC797` (`carrier_id`);

--
-- Indexes for table `orders_products`
--
ALTER TABLE `orders_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_749C879C8D9F6D38` (`order_id`),
  ADD KEY `IDX_749C879C4584665A` (`product_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D34A04AD12469DE2` (`category_id`);

--
-- Indexes for table `slide`
--
ALTER TABLE `slide`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static`
--
ALTER TABLE `static`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_80C028254F2D5CE4` (`titleRewrited`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT dla tabeli `bank`
--
ALTER TABLE `bank`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `carrier`
--
ALTER TABLE `carrier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT dla tabeli `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT dla tabeli `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT dla tabeli `fos_user`
--
ALTER TABLE `fos_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT dla tabeli `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=203;
--
-- AUTO_INCREMENT dla tabeli `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT dla tabeli `orders_products`
--
ALTER TABLE `orders_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT dla tabeli `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT dla tabeli `slide`
--
ALTER TABLE `slide`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT dla tabeli `static`
--
ALTER TABLE `static`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526C4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_9474526CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_user` (`id`);

--
-- Ograniczenia dla tabeli `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045F4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Ograniczenia dla tabeli `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_E52FFDEE21DFC797` FOREIGN KEY (`carrier_id`) REFERENCES `carrier` (`id`),
  ADD CONSTRAINT `FK_E52FFDEEA76ED395` FOREIGN KEY (`user_id`) REFERENCES `fos_user` (`id`);

--
-- Ograniczenia dla tabeli `orders_products`
--
ALTER TABLE `orders_products`
  ADD CONSTRAINT `FK_749C879C4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_749C879C8D9F6D38` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Ograniczenia dla tabeli `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
