-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2023 at 04:14 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `perpustakaan`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `HapusData` (`kdk` CHAR(7))   BEGIN
DELETE FROM kelas WHERE KD_KELAS=kdk;
SELECT * FROM customer;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TambahDataPenerbit` (IN `nama` VARCHAR(40), IN `alamat` VARCHAR(20), IN `no` CHAR(12), IN `email` VARCHAR(30))   BEGIN 
DECLARE kodebaru varchar(7);
SELECT fcKodePenerbitBaru() INTO kodebaru;
INSERT INTO penerbit VALUES (kodebaru,nama,alamat,no,email);
SELECT * FROM penerbit;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TambahDataPenulis` (IN `nama` VARCHAR(40), IN `alamat` VARCHAR(20), IN `no` CHAR(12), IN `email` VARCHAR(30))   BEGIN 
DECLARE kodebaru char(6);
SELECT fcKodePenulisBaru() INTO kodebaru;
INSERT INTO penulis VALUES (kodebaru,nama,alamat,no,email);
SELECT * FROM penulis;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TambahDataPinjam` (`nis` CHAR(6), `id` CHAR(6), `tgl_pinjam` DATE, `tgl_kembali` DATE, `jml` INT)   BEGIN 
DECLARE kodebaru varchar(25);
SELECT fcKodePeminjamBaru() INTO kodebaru;
INSERT INTO pinjam VALUES (kodebaru,nis,id,tgl_pinjam,tgl_kembali,jml);
SELECT NO_PINJAM FROM pinjam;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `fcCekStokBuku` (`kode` CHAR(5)) RETURNS INT(11)  BEGIN 
declare hasil int; 
select JML_STOK into hasil from detail_info_buku where KD_STOK = kode; 
return hasil; 
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fcKodeKategoriBaru` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
DECLARE terakhir INT;
DECLARE terbaru CHAR(6);
SELECT IFNULL(MAX(RIGHT(KD_JENIS, 4)), 0) INTO terakhir FROM kategori_buku; 
SET terbaru = LPAD(terakhir + 1, 6, 'BR000');
RETURN terbaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fcKodePeminjamBaru` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
DECLARE terakhir INT;
DECLARE terbaru CHAR(6);
SELECT IFNULL(MAX(RIGHT(NO_PINJAM, 4)), 0) INTO terakhir FROM pinjam; 
SET terbaru = LPAD(terakhir + 1, 6, 'Z0000');
RETURN terbaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fcKodePenerbitBaru` () RETURNS VARCHAR(7) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
DECLARE terakhir INT;
DECLARE terbaru VARCHAR(7);
SELECT IFNULL(MAX(RIGHT(KD_PENERBIT, 3)), 0) INTO terakhir FROM penerbit; 
SET terbaru = LPAD(terakhir + 1, 7, 'BBCC00');
RETURN terbaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fcKodePenulisBaru` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
DECLARE terakhir INT;
DECLARE terbaru CHAR(6);
SELECT IFNULL(MAX(RIGHT(KD_PENULIS, 3)), 0) INTO terakhir FROM penulis; 
SET terbaru = LPAD(terakhir + 1, 6, 'AAB00');
RETURN terbaru;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FcTambahAnggota` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE last INT;
    DECLARE newId CHAR(6);

    SELECT IFNULL(MAX(RIGHT(no_anggota, 5)), 0) INTO last FROM anggota_perpus;
    
    SET newId = CONCAT('A', LPAD(last + 1, 5, '0'));

    RETURN newId;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FcTambahBuku` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE last INT;
    DECLARE newId CHAR(6);

    SELECT IFNULL(MAX(RIGHT(ID_BUKU, 4)), 0) INTO last FROM buku;
    
    SET newId = CONCAT('BU', LPAD(last + 1, 4, '0'));

    RETURN newId;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `FcTambahDetail_infoBaru` () RETURNS CHAR(6) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE last INT;
    DECLARE newId CHAR(6);

    SELECT IFNULL(MAX(RIGHT(KD_STOK, 4)), 0) INTO last FROM detail_info_buku;
    
    SET newId = LPAD(last + 1, 4, '0');

    RETURN newId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `NO_PETUGAS` char(6) NOT NULL,
  `TGL_LOGIN` date DEFAULT NULL,
  `PASSW` char(6) DEFAULT NULL,
  `NAMA_PETUGAS` varchar(30) DEFAULT NULL,
  `ALAMAT` text DEFAULT NULL,
  `USERNAME` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`NO_PETUGAS`, `TGL_LOGIN`, `PASSW`, `NAMA_PETUGAS`, `ALAMAT`, `USERNAME`) VALUES
('WXC001', '2023-10-13', 'Newpas', 'SUHO', 'Jl.Gajah 08', 'Jaehyun123'),
('WXC002', '2023-10-15', 'babibu', 'Chanyeol', 'Jl.Gajah 08', 'Chanyeol123');

--
-- Triggers `admin`
--
DELIMITER $$
CREATE TRIGGER `tg_update_admin` BEFORE UPDATE ON `admin` FOR EACH ROW BEGIN
    INSERT INTO log_admin(waktu, keterangan)
    VALUES(NOW(), CONCAT('UPDATE petugas dengan no petugas ', OLD.NO_PETUGAS,' nama ', old.nama_petugas, ' menjadi ', NEW.nama_petugas,' dan ',old.PASSW,' menjadi ',NEW.PASSW));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `anggota_perpus`
--

CREATE TABLE `anggota_perpus` (
  `NIS` char(6) NOT NULL,
  `NAMA` varchar(30) NOT NULL,
  `KD_KELAS` char(7) NOT NULL,
  `JK` char(1) DEFAULT NULL,
  `ALAMAT` text DEFAULT NULL,
  `NO_TELP` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anggota_perpus`
--

INSERT INTO `anggota_perpus` (`NIS`, `NAMA`, `KD_KELAS`, `JK`, `ALAMAT`, `NO_TELP`) VALUES
('123456', 'Sanaya Almatin', '22IPA01', 'L', 'Jl.Mangga 05', '087778588121'),
('123457', 'Alfian Ramadhan', '22IPA02', 'L', 'Jl.Mangga 07', '087778578121');

-- --------------------------------------------------------

--
-- Table structure for table `buku`
--

CREATE TABLE `buku` (
  `ID_BUKU` char(6) NOT NULL,
  `JDL_BUKU` varchar(20) NOT NULL,
  `KD_PENULIS` char(6) NOT NULL,
  `KD_PENERBIT` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `buku`
--

INSERT INTO `buku` (`ID_BUKU`, `JDL_BUKU`, `KD_PENULIS`, `KD_PENERBIT`) VALUES
('A00001', 'Saku Ibu', 'AAB001', 'BBCC001'),
('A00002', 'Bona Petualang', 'AAB002', 'BBCC002');

-- --------------------------------------------------------

--
-- Stand-in structure for view `bukutersediaview`
-- (See below for the actual view)
--
CREATE TABLE `bukutersediaview` (
`ID_BUKU` char(6)
,`JDL_BUKU` varchar(20)
,`STATUS` varchar(8)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `daftaranggotaview`
-- (See below for the actual view)
--
CREATE TABLE `daftaranggotaview` (
);

-- --------------------------------------------------------

--
-- Table structure for table `denda`
--

CREATE TABLE `denda` (
  `NO_DENDA` char(5) NOT NULL,
  `TGL_DIKEMBALIKAN` date NOT NULL,
  `DENDA` int(11) NOT NULL,
  `TGL_KEMBALI` date NOT NULL,
  `NIS` char(6) NOT NULL,
  `NO_PINJAM` varchar(25) NOT NULL,
  `ID_BUKU` char(6) NOT NULL,
  `jml_buku_kembali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `denda`
--

INSERT INTO `denda` (`NO_DENDA`, `TGL_DIKEMBALIKAN`, `DENDA`, `TGL_KEMBALI`, `NIS`, `NO_PINJAM`, `ID_BUKU`, `jml_buku_kembali`) VALUES
('23001', '2022-10-25', 0, '2022-10-25', '123456', 'Z00001', 'A00001', 0),
('23002', '2022-10-21', 0, '2022-10-21', '123456', 'Z00002', 'A00002', 0),
('23003', '2023-10-23', 3000, '2023-10-20', '123457', 'Z00004', 'A00001', 5);

--
-- Triggers `denda`
--
DELIMITER $$
CREATE TRIGGER `tr_update_denda_buku` BEFORE INSERT ON `denda` FOR EACH ROW BEGIN
    DECLARE selisih_hari INT;

    SET selisih_hari = DATEDIFF(NEW.tgl_dikembalikan, NEW.tgl_kembali);

    SET NEW.denda = selisih_hari * 1000;

    UPDATE detail_info_buku
    SET jml_stok = jml_stok + NEW.jml_buku_kembali,
        status = CASE WHEN jml_stok + NEW.jml_buku_kembali > 0 THEN 'READY' ELSE status END
    WHERE id_buku = NEW.id_buku;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `detailpeminjamanview`
-- (See below for the actual view)
--
CREATE TABLE `detailpeminjamanview` (
`NO_PINJAM` varchar(25)
,`no_anggota` char(6)
,`ID_BUKU` char(6)
,`TGL_PINJAM` date
,`TGL_KEMBALI` date
,`JML_PINJAM` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `detail_info_buku`
--

CREATE TABLE `detail_info_buku` (
  `KD_STOK` char(4) NOT NULL,
  `JML_STOK` int(11) NOT NULL,
  `STATUS` varchar(8) NOT NULL,
  `ID_BUKU` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_info_buku`
--

INSERT INTO `detail_info_buku` (`KD_STOK`, `JML_STOK`, `STATUS`, `ID_BUKU`) VALUES
('0001', 5, 'READY', 'A00001'),
('0002', 7, 'READY', 'A00002');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_buku`
--

CREATE TABLE `kategori_buku` (
  `KD_JENIS` char(6) NOT NULL,
  `JENIS_BUKU` varchar(15) NOT NULL,
  `DESKRIPSI_BUKU` text DEFAULT NULL,
  `KD_STOK` char(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_buku`
--

INSERT INTO `kategori_buku` (`KD_JENIS`, `JENIS_BUKU`, `DESKRIPSI_BUKU`, `KD_STOK`) VALUES
('BR0001', 'Novel', 'Buku ini sangat bagus untuk pecinta novel', '5'),
('BR0002', 'Komik', 'Buku ini sangat bagus untuk pecinta komik', '7');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `KD_KELAS` char(7) NOT NULL,
  `NAMA_KLS` varchar(15) DEFAULT NULL,
  `THN_ANGKT` year(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`KD_KELAS`, `NAMA_KLS`, `THN_ANGKT`) VALUES
('22IPA01', 'IPA 1', '2022'),
('22IPA02', 'IPA 2', '2022'),
('22IPA03', 'IPA 3', '2022'),
('22IPS01', 'IPS 1', '2022'),
('22IPS02', 'IPS 2', '2022'),
('22IPS03', 'IPS 3', '2022'),
('23IPA01', 'IPA 1', '2023'),
('23IPS01', 'IPS 1', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `list_penerbit`
--

CREATE TABLE `list_penerbit` (
  `ID_BUKU` char(6) NOT NULL,
  `KD_PENERBIT` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list_penerbit`
--

INSERT INTO `list_penerbit` (`ID_BUKU`, `KD_PENERBIT`) VALUES
('A00001', 'BBCC001'),
('A00002', 'BBCC002');

-- --------------------------------------------------------

--
-- Table structure for table `list_penulis`
--

CREATE TABLE `list_penulis` (
  `ID_BUKU` char(6) NOT NULL,
  `KD_PENULIS` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `list_penulis`
--

INSERT INTO `list_penulis` (`ID_BUKU`, `KD_PENULIS`) VALUES
('A00001', 'AAB001'),
('A00002', 'AAB002');

-- --------------------------------------------------------

--
-- Table structure for table `log_admin`
--

CREATE TABLE `log_admin` (
  `ID_LOG` int(11) NOT NULL,
  `waktu` datetime DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_admin`
--

INSERT INTO `log_admin` (`ID_LOG`, `waktu`, `keterangan`) VALUES
(1, '2023-12-09 07:00:18', 'UPDATE petugas dengan no petugas WXC001 nama Jaehyun menjadi SUHO dan kepodo menjadi Newpas');

-- --------------------------------------------------------

--
-- Table structure for table `penerbit`
--

CREATE TABLE `penerbit` (
  `KD_PENERBIT` varchar(7) NOT NULL,
  `NAMA_PENERBIT` varchar(40) NOT NULL,
  `ALAMAT` varchar(20) DEFAULT NULL,
  `NO_TELP` char(12) DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penerbit`
--

INSERT INTO `penerbit` (`KD_PENERBIT`, `NAMA_PENERBIT`, `ALAMAT`, `NO_TELP`, `EMAIL`) VALUES
('BBCC001', 'Gramedia', 'Jakarta Utara', '087778655432', 'gramedia@gmail.com'),
('BBCC002', 'Tiga Serangkai', 'Jakarta Barat', '087765433457', 'tigaserangkai@gmail.com'),
('BBCC003', 'sindo', 'Jakarta Selatan', '087778588121', 'sindo@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `penulis`
--

CREATE TABLE `penulis` (
  `KD_PENULIS` char(6) NOT NULL,
  `NAMA_PENULIS` varchar(40) NOT NULL,
  `ALAMAT` varchar(20) DEFAULT NULL,
  `NO_TELP` char(12) DEFAULT NULL,
  `EMAIL` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penulis`
--

INSERT INTO `penulis` (`KD_PENULIS`, `NAMA_PENULIS`, `ALAMAT`, `NO_TELP`, `EMAIL`) VALUES
('AAB001', 'Tatang S', 'Jl.Mangga 01', '087778588121', 'tatangs@gmail.com'),
('AAB002', 'Joko T', 'Jl.Apel 05', '087778587154', 'jokot@gmail.com'),
('AAB003', 'Brian K', 'Jl.Pisang 03', '087778854134', 'brian@gmail.com'),
('AAB004', 'Tere Liye', 'Jl.Jambu 04', '087778588121', 'tere@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `pinjam`
--

CREATE TABLE `pinjam` (
  `NO_PINJAM` varchar(25) NOT NULL,
  `no_anggota` char(6) NOT NULL,
  `ID_BUKU` char(6) NOT NULL,
  `TGL_PINJAM` date NOT NULL,
  `TGL_KEMBALI` date NOT NULL,
  `JML_PINJAM` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pinjam`
--

INSERT INTO `pinjam` (`NO_PINJAM`, `no_anggota`, `ID_BUKU`, `TGL_PINJAM`, `TGL_KEMBALI`, `JML_PINJAM`) VALUES
('Z00001', '123456', 'A00001', '2023-10-13', '2023-10-25', 2),
('Z00002', '123457', 'A00002', '2023-10-17', '2023-10-21', 1),
('Z00003', '123458', 'A00003', '2023-10-13', '2023-10-17', 5),
('Z00004', '123457', 'A00001', '0000-00-00', '0000-00-00', 5);

--
-- Triggers `pinjam`
--
DELIMITER $$
CREATE TRIGGER `tr_update_status_buku` BEFORE INSERT ON `pinjam` FOR EACH ROW BEGIN
    DECLARE stok_setelah_peminjaman INT;

    UPDATE detail_info_buku
    SET jml_stok = jml_stok - NEW.jml_pinjam,
        status = CASE WHEN (jml_stok - NEW.jml_pinjam) <= 0 THEN 'not ready' ELSE status END
    WHERE id_buku = NEW.id_buku;

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `pinjamanterlambatview`
-- (See below for the actual view)
--
CREATE TABLE `pinjamanterlambatview` (
`NO_PINJAM` varchar(25)
,`no_anggota` char(6)
,`ID_BUKU` char(6)
,`TGL_PINJAM` date
,`TGL_KEMBALI` date
,`JML_PINJAM` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `stokbukuview`
-- (See below for the actual view)
--
CREATE TABLE `stokbukuview` (
`ID_BUKU` char(6)
,`JDL_BUKU` varchar(20)
,`STOK` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Structure for view `bukutersediaview`
--
DROP TABLE IF EXISTS `bukutersediaview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `bukutersediaview`  AS SELECT `b`.`ID_BUKU` AS `ID_BUKU`, `b`.`JDL_BUKU` AS `JDL_BUKU`, `dib`.`STATUS` AS `STATUS` FROM (`buku` `b` join `detail_info_buku` `dib` on(`b`.`ID_BUKU` = `dib`.`ID_BUKU`)) WHERE `dib`.`STATUS` = 'READY' ;

-- --------------------------------------------------------

--
-- Structure for view `daftaranggotaview`
--
DROP TABLE IF EXISTS `daftaranggotaview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `daftaranggotaview`  AS SELECT `anggota_perpus`.`no_anggota` AS `no_anggota`, `anggota_perpus`.`NAMA` AS `NAMA`, `anggota_perpus`.`KD_KELAS` AS `KD_KELAS`, `anggota_perpus`.`JK` AS `JK`, `anggota_perpus`.`ALAMAT` AS `ALAMAT`, `anggota_perpus`.`NO_TELP` AS `NO_TELP` FROM `anggota_perpus` ;

-- --------------------------------------------------------

--
-- Structure for view `detailpeminjamanview`
--
DROP TABLE IF EXISTS `detailpeminjamanview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detailpeminjamanview`  AS SELECT `pinjam`.`NO_PINJAM` AS `NO_PINJAM`, `pinjam`.`no_anggota` AS `no_anggota`, `pinjam`.`ID_BUKU` AS `ID_BUKU`, `pinjam`.`TGL_PINJAM` AS `TGL_PINJAM`, `pinjam`.`TGL_KEMBALI` AS `TGL_KEMBALI`, `pinjam`.`JML_PINJAM` AS `JML_PINJAM` FROM `pinjam` ;

-- --------------------------------------------------------

--
-- Structure for view `pinjamanterlambatview`
--
DROP TABLE IF EXISTS `pinjamanterlambatview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pinjamanterlambatview`  AS SELECT `p`.`NO_PINJAM` AS `NO_PINJAM`, `p`.`no_anggota` AS `no_anggota`, `p`.`ID_BUKU` AS `ID_BUKU`, `p`.`TGL_PINJAM` AS `TGL_PINJAM`, `p`.`TGL_KEMBALI` AS `TGL_KEMBALI`, `p`.`JML_PINJAM` AS `JML_PINJAM` FROM (`pinjam` `p` join `denda` `d` on(`p`.`NO_PINJAM` = `d`.`NO_PINJAM`)) WHERE `d`.`TGL_DIKEMBALIKAN` > `p`.`TGL_KEMBALI` ;

-- --------------------------------------------------------

--
-- Structure for view `stokbukuview`
--
DROP TABLE IF EXISTS `stokbukuview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stokbukuview`  AS SELECT `b`.`ID_BUKU` AS `ID_BUKU`, `b`.`JDL_BUKU` AS `JDL_BUKU`, sum(`dib`.`JML_STOK`) AS `STOK` FROM (`buku` `b` join `detail_info_buku` `dib` on(`b`.`ID_BUKU` = `dib`.`ID_BUKU`)) GROUP BY `b`.`ID_BUKU`, `b`.`JDL_BUKU` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`NO_PETUGAS`);

--
-- Indexes for table `anggota_perpus`
--
ALTER TABLE `anggota_perpus`
  ADD PRIMARY KEY (`NIS`),
  ADD KEY `KD_KELAS` (`KD_KELAS`);

--
-- Indexes for table `buku`
--
ALTER TABLE `buku`
  ADD PRIMARY KEY (`ID_BUKU`),
  ADD KEY `KD_PENULIS` (`KD_PENULIS`),
  ADD KEY `KD_PENERBIT` (`KD_PENERBIT`);

--
-- Indexes for table `denda`
--
ALTER TABLE `denda`
  ADD PRIMARY KEY (`NO_DENDA`),
  ADD KEY `NIS` (`NIS`),
  ADD KEY `NO_PINJAM` (`NO_PINJAM`),
  ADD KEY `ID_BUKU` (`ID_BUKU`);

--
-- Indexes for table `detail_info_buku`
--
ALTER TABLE `detail_info_buku`
  ADD PRIMARY KEY (`KD_STOK`),
  ADD KEY `ID_BUKU` (`ID_BUKU`);

--
-- Indexes for table `kategori_buku`
--
ALTER TABLE `kategori_buku`
  ADD PRIMARY KEY (`KD_JENIS`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`KD_KELAS`);

--
-- Indexes for table `list_penerbit`
--
ALTER TABLE `list_penerbit`
  ADD KEY `KD_PENERBIT` (`KD_PENERBIT`),
  ADD KEY `ID_BUKU` (`ID_BUKU`);

--
-- Indexes for table `list_penulis`
--
ALTER TABLE `list_penulis`
  ADD KEY `KD_PENULIS` (`KD_PENULIS`),
  ADD KEY `ID_BUKU` (`ID_BUKU`);

--
-- Indexes for table `log_admin`
--
ALTER TABLE `log_admin`
  ADD PRIMARY KEY (`ID_LOG`);

--
-- Indexes for table `penerbit`
--
ALTER TABLE `penerbit`
  ADD PRIMARY KEY (`KD_PENERBIT`);

--
-- Indexes for table `penulis`
--
ALTER TABLE `penulis`
  ADD PRIMARY KEY (`KD_PENULIS`);

--
-- Indexes for table `pinjam`
--
ALTER TABLE `pinjam`
  ADD PRIMARY KEY (`NO_PINJAM`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `log_admin`
--
ALTER TABLE `log_admin`
  MODIFY `ID_LOG` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anggota_perpus`
--
ALTER TABLE `anggota_perpus`
  ADD CONSTRAINT `anggota_perpus_ibfk_1` FOREIGN KEY (`KD_KELAS`) REFERENCES `kelas` (`KD_KELAS`);

--
-- Constraints for table `buku`
--
ALTER TABLE `buku`
  ADD CONSTRAINT `buku_ibfk_1` FOREIGN KEY (`KD_PENERBIT`) REFERENCES `penerbit` (`KD_PENERBIT`);

--
-- Constraints for table `denda`
--
ALTER TABLE `denda`
  ADD CONSTRAINT `denda_ibfk_1` FOREIGN KEY (`NIS`) REFERENCES `anggota_perpus` (`NIS`),
  ADD CONSTRAINT `denda_ibfk_2` FOREIGN KEY (`NO_PINJAM`) REFERENCES `pinjam` (`NO_PINJAM`);

--
-- Constraints for table `detail_info_buku`
--
ALTER TABLE `detail_info_buku`
  ADD CONSTRAINT `detail_info_buku_ibfk_1` FOREIGN KEY (`ID_BUKU`) REFERENCES `buku` (`ID_BUKU`);

--
-- Constraints for table `list_penerbit`
--
ALTER TABLE `list_penerbit`
  ADD CONSTRAINT `list_penerbit_ibfk_1` FOREIGN KEY (`KD_PENERBIT`) REFERENCES `penerbit` (`KD_PENERBIT`);

--
-- Constraints for table `list_penulis`
--
ALTER TABLE `list_penulis`
  ADD CONSTRAINT `list_penulis_ibfk_1` FOREIGN KEY (`ID_BUKU`) REFERENCES `buku` (`ID_BUKU`),
  ADD CONSTRAINT `list_penulis_ibfk_2` FOREIGN KEY (`KD_PENULIS`) REFERENCES `penulis` (`KD_PENULIS`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
