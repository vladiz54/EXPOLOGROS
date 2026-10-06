<?php
require_once 'config/conexion.php';
try {
    $database = new Database();
    $db = $database->getConnection();
    $query = "SELECT d.nombre, d.departamento, c.nombre_categoria
              FROM destinos d
              JOIN categorias_destino c ON d.id_categoria = c.id_categoria";
    $stmt = $db->query($query);
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo $row['nombre'] . " | " . $row['departamento'] . " | " . $row['nombre_categoria'] . "\n";
    }
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
