<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

try {
    // Agregamos la columna 'orden' para garantizar cual es la principal y cuales el carrusel
    $db->exec("ALTER TABLE imagenes_destino ADD COLUMN orden INT NOT NULL DEFAULT 1");
    echo "Column 'orden' added successfully.\n";
} catch (Exception $e) {
    echo "Error adding column: " . $e->getMessage() . "\n";
}
?>
