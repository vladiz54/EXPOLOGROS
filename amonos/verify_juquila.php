<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

$id_destino = 67; // Juquila

try {
    // 1. Verificar archivos físicos
    echo "Checking physical files:\n";
    for ($i = 1; $i <= 5; $i++) {
        $path = "public/imagenes/juquila-$i.webp";
        echo $path . " -> " . (file_exists($path) ? "EXISTS" : "MISSING") . "\n";
    }

    // 2. Verificar registros en DB
    echo "\nChecking DB records:\n";
    $stmt = $db->prepare("SELECT * FROM imagenes_destino WHERE id_destino = ? ORDER BY orden ASC");
    $stmt->execute([$id_destino]);
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    print_r($rows);

    // 3. Verificar read.php (Imagen principal)
    echo "\nChecking read.php response for main image:\n";
    $stmtMain = $db->prepare("SELECT imagen_url FROM imagenes_destino WHERE id_destino = ? AND orden = 1 LIMIT 1");
    $stmtMain->execute([$id_destino]);
    $mainImg = $stmtMain->fetchColumn();
    echo "Main Image: " . ($mainImg ?: "NULL") . "\n";

    // 4. Verificar get_destinos.php (Carrusel)
    echo "\nChecking get_destinos.php image array:\n";
    $stmtAll = $db->prepare("SELECT imagen_url FROM imagenes_destino WHERE id_destino = ? ORDER BY orden ASC");
    $stmtAll->execute([$id_destino]);
    $allImgs = $stmtAll->fetchAll(PDO::FETCH_COLUMN);
    print_r($allImgs);

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
