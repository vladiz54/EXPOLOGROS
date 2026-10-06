<?php
require_once 'config/conexion.php';
try {
    $database = new Database();
    $db = $database->getConnection();
    $stmt = $db->query("SELECT id_destino, nombre FROM destinos");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo $row['id_destino'] . " - " . $row['nombre'] . PHP_EOL;
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
?>
