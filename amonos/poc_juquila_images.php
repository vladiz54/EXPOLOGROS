<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

$id_destino = 67; // Juquila
$imagenes = [
    ['url' => 'imagenes/juquila-1.webp', 'orden' => 1],
    ['url' => 'imagenes/juquila-2.webp', 'orden' => 2],
    ['url' => 'imagenes/juquila-3.webp', 'orden' => 3],
    ['url' => 'imagenes/juquila-4.webp', 'orden' => 4],
    ['url' => 'imagenes/juquila-5.webp', 'orden' => 5],
];

try {
    // Limpiar imágenes previas para evitar duplicados en la PoC
    $stmtClear = $db->prepare("DELETE FROM imagenes_destino WHERE id_destino = :id");
    $stmtClear->execute([':id' => $id_destino]);

    foreach ($imagenes as $img) {
        $stmt = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url, orden) VALUES (:id, :url, :ord)");
        $stmt->execute([
            ':id' => $id_destino,
            ':url' => $img['url'],
            ':ord' => $img['orden']
        ]);
    }
    echo "Juquila images inserted successfully.\n";
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
