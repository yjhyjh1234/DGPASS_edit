-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- 생성 시간: 24-12-03 16:56
-- 서버 버전: 10.3.8-MariaDB
-- PHP 버전: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 데이터베이스: `wptest`
--

-- --------------------------------------------------------

--
-- 테이블 구조 `dgu_road_article`
--

CREATE TABLE `dgu_road_article` (
  `article_no` int(10) NOT NULL,
  `category_id` varchar(20) NOT NULL,
  `title` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `image` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 테이블의 덤프 데이터 `dgu_road_article`
--

INSERT INTO `dgu_road_article` (`article_no`, `category_id`, `title`, `content`, `image`) VALUES
(1, 'cafe', '가온누리 ', '주소: 서울 중구 필동로 1길 30 동국대학교 A관 1층\r\n운영시간: 평일 09:00-17:30\r\n주말: 휴무', 'images/gaon.jpg'),
(2, 'cafe', '그루터기', '', NULL),
(3, 'cafe', '두리터', '', NULL),
(4, 'cafe', '아이앤지', '', NULL),
(5, 'cafe', '쥬시', '', NULL);

-- --------------------------------------------------------

--
-- 테이블 구조 `dgu_road_category`
--

CREATE TABLE `dgu_road_category` (
  `id` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- 테이블의 덤프 데이터 `dgu_road_category`
--

INSERT INTO `dgu_road_category` (`id`, `name`) VALUES
('bar', '술집'),
('cafe', '교내 카페'),
('cafe2', '카페'),
('classroom', '강의실'),
('other', '그 외 스팟'),
('restaurant', '맛집'),
('shortcut', '지름길'),
('store', '편의점'),
('study', '스터디 공간'),
('tip', '동대생 꿀팁');

--
-- 덤프된 테이블의 인덱스
--

--
-- 테이블의 인덱스 `dgu_road_article`
--
ALTER TABLE `dgu_road_article`
  ADD PRIMARY KEY (`article_no`),
  ADD KEY `category_fk` (`category_id`);

--
-- 테이블의 인덱스 `dgu_road_category`
--
ALTER TABLE `dgu_road_category`
  ADD PRIMARY KEY (`id`);

--
-- 덤프된 테이블의 AUTO_INCREMENT
--

--
-- 테이블의 AUTO_INCREMENT `dgu_road_article`
--
ALTER TABLE `dgu_road_article`
  MODIFY `article_no` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- 덤프된 테이블의 제약사항
--

--
-- 테이블의 제약사항 `dgu_road_article`
--
ALTER TABLE `dgu_road_article`
  ADD CONSTRAINT `category_fk` FOREIGN KEY (`category_id`) REFERENCES `dgu_road_category` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
