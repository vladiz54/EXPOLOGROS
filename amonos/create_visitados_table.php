<?php
require_once 'config/conexion.php';

$database = new Database();
$db = $database->getConnection();

try {
    $sql = "CREATE TABLE IF NOT EXISTS `visitados` (
        `id_visita` int NOT NULL AUTO_INCREMENT,
        `id_usuario` int NOT NULL,
        `id_destino` int NOT NULL,
        `fecha_visita` datetime DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (`id_visita`),
        UNIQUE KEY `usuario_destino` (`id_usuario`, `id_destino`),
        CONSTRAINT `visitados_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
        CONSTRAINT `visitados_ibfk_2` FOREIGN KEY (`id_destino`) REFERENCES `destinos` (`id_destino`) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;";

    $db->exec($sql);
    echo "Table 'visitados' created or already exists successfully.\n";
} catch (Exception $e) {
    echo "Error creating table: " . $e->getMessage();
}
?>
