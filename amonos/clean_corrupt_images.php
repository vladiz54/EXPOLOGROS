<?php
/**
 * Script para eliminar imágenes corruptas (archivos HTML disfrazados de .webp)
 */

$dir = 'C:/laragon/www/EXPOLOGROS/amonos/public/imagenes/';
if (!is_dir($dir)) {
    die("Error: El directorio $dir no existe.\n");
}

$files = scandir($dir);
$deletedCount = 0;
$keptCount = 0;

echo "Starting cleanup of corrupt images...\n";

foreach ($files as $file) {
    if ($file === '.' || $file === '..') continue;

    $path = $dir . $file;
    $content = file_get_contents($path);

    $isCorrupt = false;
    $reason = "";

    // 1. Comprobar si empieza por etiquetas HTML/XML
    if (preg_match('/^<!DOCTYPE|^<html|^<\?xml/i', $content)) {
        $isCorrupt = true;
        $reason = "Starts with HTML/XML tag";
    }
    // 2. Comprobar tamaño absurdamente pequeño (ej. < 100 bytes)
    elseif (strlen($content) < 100) {
        $isCorrupt = true;
        $reason = "Too small (" . strlen($content) . " bytes)";
    }

    if ($isCorrupt) {
        echo "Deleting $file: $reason\n";
        unlink($path);
        $deletedCount++;
    } else {
        $keptCount++;
    }
}

echo "\nCleanup completed.\n";
echo "Deleted: $deletedCount corrupt files.\n";
echo "Kept: $keptCount valid files.\n";
?>
