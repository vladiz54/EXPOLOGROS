<?php
require_once 'config/conexion.php';

$database = new Database();
$db = $database->getConnection();

$id_destino = 30; // Costa del Sol
$url = 'imagenes/costa-del-sol.webp';

try {
    // Primero verificamos si ya existe una imagen para este destino
    $check = $db->prepare("SELECT id_imagen FROM imagenes_destino WHERE id_destino = :id");
    $check->execute([':id' => $id_destino]);
    $row = $check->fetch();

    if ($row) {
        // Si existe, la actualizamos
        $stmt = $db->prepare("UPDATE imagenes_destino SET imagen_url = :url WHERE id_destino = :id");
        $stmt->execute([':url' => $url, ':id' => $id_destino]);
        echo "Updated Costa del Sol image to $url\n";
    } else {
        // Si no existe, insertamos una nueva
        $stmt = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url) VALUES (:id, :url)");
        $stmt->execute([':id' => $id_destino, ':url' => $url]);
        echo "Inserted new image for Costa del Sol: $url\n";
    }
    echo "Success!\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
