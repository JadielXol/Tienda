-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-11-2023 a las 21:44:45
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tiendaaquel`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbclientes`
--

CREATE TABLE `tbclientes` (
  `idcliente` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `direccion` varchar(40) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbclientes`
--

INSERT INTO `tbclientes` (`idcliente`, `nombre`, `apellido`, `direccion`, `telefono`) VALUES
(1, 'Gerson Alexander', 'Ponce Pop', 'Barrio San Pablo', '2452-5464'),
(2, 'Nelson', 'Pop Paau', 'Aldea Chaimal', '5445-6879'),
(3, 'Nery Ottoniel', 'Valdizon Castro', 'Aldea Campur', '3895-8724');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbdetallepedido`
--

CREATE TABLE `tbdetallepedido` (
  `iddetalle` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `idpedido` int(11) DEFAULT NULL,
  `idproducto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbdetallepedido`
--

INSERT INTO `tbdetallepedido` (`iddetalle`, `Cantidad`, `idpedido`, `idproducto`) VALUES
(1, 3, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 3),
(4, 4, 2, 2);

--
-- Disparadores `tbdetallepedido`
--
DELIMITER $$
CREATE TRIGGER `actualizarStock` AFTER INSERT ON `tbdetallepedido` FOR EACH ROW BEGIN
UPDATE tbproductos
SET stock = stock - NEW.cantidad
WHERE idproducto = NEW.idproducto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbpedido`
--

CREATE TABLE `tbpedido` (
  `idpedido` int(11) NOT NULL,
  `descripcion` varchar(50) DEFAULT NULL,
  `fechaPedido` date DEFAULT NULL,
  `idcliente` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbpedido`
--

INSERT INTO `tbpedido` (`idpedido`, `descripcion`, `fechaPedido`, `idcliente`) VALUES
(1, 'En ruta', '2023-11-09', 2),
(2, 'Six de Gallo', '2023-11-15', 1),
(3, 'Un kilito XD', '2023-11-10', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbproductos`
--

CREATE TABLE `tbproductos` (
  `idproducto` int(11) NOT NULL,
  `nombreProducto` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tbproductos`
--

INSERT INTO `tbproductos` (`idproducto`, `nombreProducto`, `precio`, `stock`) VALUES
(1, 'Papel Higienico', 10.50, 50),
(2, 'Six Cerveza Gallo', 68.75, 41),
(3, 'Marihuana', 99.99, 25);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbclientes`
--
ALTER TABLE `tbclientes`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  ADD PRIMARY KEY (`iddetalle`),
  ADD KEY `idpedido` (`idpedido`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `idcliente` (`idcliente`);

--
-- Indices de la tabla `tbproductos`
--
ALTER TABLE `tbproductos`
  ADD PRIMARY KEY (`idproducto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbclientes`
--
ALTER TABLE `tbclientes`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  MODIFY `iddetalle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  MODIFY `idpedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tbproductos`
--
ALTER TABLE `tbproductos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `tbdetallepedido`
--
ALTER TABLE `tbdetallepedido`
  ADD CONSTRAINT `tbdetallepedido_ibfk_1` FOREIGN KEY (`idpedido`) REFERENCES `tbpedido` (`idpedido`),
  ADD CONSTRAINT `tbdetallepedido_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `tbproductos` (`idproducto`);

--
-- Filtros para la tabla `tbpedido`
--
ALTER TABLE `tbpedido`
  ADD CONSTRAINT `tbpedido_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `tbclientes` (`idcliente`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
