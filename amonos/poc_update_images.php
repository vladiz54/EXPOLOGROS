<?php
require_once 'config/conexion.php';

$database = new Database();
$db = $database->getConnection();

$updates = [
    5 => 'imagenes/lago-coatepeque.webp',
    6 => 'imagenes/volcan-santa-ana.webp',
    12 => 'imagenes/playa-el-tunco.webp'
];

try {
    foreach ($updates as $id_destino => $url) {
        $stmt = $db->prepare("UPDATE imagenes_destino SET imagen_url = :url WHERE id_destino = :id");
        $stmt->execute([':url' => $url, ':id' => $id_destino]);
        echo "Updated destination $id_destino to $url\n";
    }
    echo "PoC updates completed successfully.\n";
} catch (Exception $e) {
    echo "Error updating database: " . $e->getMessage();
}
?>
