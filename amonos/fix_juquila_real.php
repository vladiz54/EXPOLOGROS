<?php
require_once 'config/conexion.php';

function downloadImageSecurely($url, $localPath) {
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_MAXREDIRS, 10);
    curl_setopt($ch, CURLOPT_TIMEOUT, 30);
    curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36');
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    $content = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $contentType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE);
    $error = curl_error($ch);
    curl_close($ch);

    if ($error) return ['success' => false, 'message' => "cURL Error: $error"];
    if ($httpCode !== 200) return ['success' => false, 'message' => "HTTP $httpCode"];
    if (!$contentType || strpos(strtolower($contentType), 'image/') === false) return ['success' => false, 'message' => "Wrong Type: $contentType"];
    if (!$content) return ['success' => false, 'message' => "Empty"];
    if (preg_match('/^<!DOCTYPE|^<html|^<\?xml/i', $content)) return ['success' => false, 'message' => "Is HTML"];
    if (strlen($content) < 1024) return ['success' => false, 'message' => "Too small"];

    if (file_put_contents($localPath, $content) === false) return ['success' => false, 'message' => "Write failed"];
    return ['success' => true, 'message' => "OK"];
}

$database = new Database();
$db = $database->getConnection();

$id_destino = 67;
$slug = "juquila";

// He ampliado la lista con imágenes de Pexels y Wikimedia que suelen ser más permisivas
$candidates = [
    "https://images.pexels.com/photos/235938/pexels-photo-235938.jpeg",
    "https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg",
    "https://images.pexels.com/photos/164741/pexels-photo-164741.jpeg",
    "https://images.pexels.com/photos/247502/pexels-photo-247502.jpeg",
    "https://images.pexels.com/photos/257700/pexels-photo-257700.jpeg",
    "https://images.pexels.com/photos/266632/pexels-photo-266632.jpeg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Basilica_de_Nuestra_Sra_de_Juquila.jpg/800px-Basilica_de_Nuestra_Sra_de_Juquila.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Basilica_de_Nuestra_Sra_de_Juquila.jpg/800px-Basilica_de_Nuestra_Sra_de_Juquila.jpg",
];

echo "Seeking 5 valid images for Juquila...\n";
$db->prepare("DELETE FROM imagenes_destino WHERE id_destino = ?")->execute([$id_destino]);

$successCount = 0;
foreach ($candidates as $url) {
    if ($successCount >= 5) break;

    $orden = $successCount + 1;
    $fileName = "{$slug}-{$orden}.webp";
    $localPath = 'C:/laragon/www/EXPOLOGROS/amonos/public/imagenes/' . $fileName;
    $dbPath = "imagenes/{$fileName}";

    echo "Testing source " . ($successCount + 1) . ": $url... ";
    $result = downloadImageSecurely($url, $localPath);

    if ($result['success']) {
        $db->prepare("INSERT INTO imagenes_destino (id_destino, imagen_url, orden) VALUES (?, ?, ?)")->execute([$id_destino, $dbPath, $orden]);
        echo "VALIDATED & SAVED\n";
        $successCount++;
    } else {
        echo "DISCARDED: " . $result['message'] . "\n";
        if (file_exists($localPath)) unlink($localPath);
    }
}

echo "\nFinal Result for Juquila: $successCount/5 images acquired.\n";
?>
