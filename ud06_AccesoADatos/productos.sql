/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `pruebadb`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `productos`
--

CREATE TABLE `Productos` (
  `id` int NOT NULL,
  `descripcion` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Bolcament de dades per a la taula `productos`
--

INSERT INTO `Productos` (`id`, `descripcion`, `stock`) VALUES
(1, 'leche', 25),
(2, 'pan', 12),
(3, 'galletas', 5),
(4, 'gominolas', 120),
(5, 'monster', 2),
(6, 'kit kat', 17),
(7, 'patatas fritas', 7),
(8, 'donetes', 5);
