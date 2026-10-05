<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();
$stmt = $db->query("DESCRIBE imagenes_destino");
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    print_r($row);
}
?>
