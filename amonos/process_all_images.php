<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

try {
    $stmt = $db->query("SELECT id_destino, nombre FROM destinos");
    $destinos = $stmt->fetchAll(PDO::FETCH_ASSOC);

    echo "Total destinations to process: " . count($destinos) . "\n";

    foreach ($destinos as $dest) {
        $id = $dest['id_destino'];
        $nombre = $dest['nombre'];

        // Crear slug limpio
        $slug = strtolower(trim(preg_replace('/[^A-Za-z0-9-]+/', '-', $nombre)));
        $slug = trim($slug, '-');

        echo "Processing: $nombre (ID: $id)... ";

        // Para garantizar imágenes reales y no genéricas, utilizaremos una lista de
        // palabras clave basadas en el nombre para la descarga.
        $keywords = urlencode($nombre . " el salvador");

        for ($i = 1; $i <= 5; $i++) {
            $fileName = "{$slug}-{$i}.webp";
            $localPath = "public/imagenes/{$fileName}";
            $dbPath = "imagenes/{$fileName}";

            // Usamos Unsplash Source con keywords y un seed diferente para cada imagen (i)
            $imageUrl = "https://source.unsplash.com/featured/800x600?{$keywords},tourism,{$i}";

            $content = @file_get_contents($imageUrl);
            if ($content) {
                file_put_contents($localPath, $content);

                // Evitar duplicados borrando previas si existen para este orden
                $db->prepare("DELETE FROM imagenes_destino WHERE id_destino = ? AND orden = ?")
                   ->execute([$id, $i]);

                $stmtImg = $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url, orden) VALUES (?, ?, ?)");
                $stmtImg->execute([$id, $dbPath, $i]);
            }
        }
        echo "Done.\n";
    }
    echo "Mass process completed.\n";

} catch (Exception $e) {
    echo "Fatal Error: " . $e->getMessage();
}
?>
