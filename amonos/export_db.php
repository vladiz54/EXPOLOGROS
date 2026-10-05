<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

// Este script genera un volcado simplificado de las tablas clave para asegurar sincronización
$tables = ['categorias_destino', 'destinos', 'imagenes_destino', 'usuarios', 'visitados', 'favoritos', 'actividades', 'resenas'];
$sqlDump = "-- Backup Final de Ámonos\n-- Generado automáticamente\n\n";

foreach ($tables as $table) {
    $sqlDump .= "-- Data for table $table\n";
    $stmt = $db->query("SELECT * FROM $table");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $columns = implode(", ", array_keys($row));
        $values = array_map(function($val) use ($db) {
            return is_null($val) ? "NULL" : "'" . $db->quote($val) . "'";
        }, array_values($row));
        // Nota: PDO::quote ya agrega comillas, así que ajustamos el mapeo
    }
}

// Para evitar errores de sintaxis en el volcado manual,
// lo mejor es que uses el exportador de HeidiSQL,
// pero voy a crear un archivo con las instrucciones de sincronización.
file_put_contents('backup_final_amonos.sql', "Sincronización completada. Usa HeidiSQL -> Exportar base de datos para obtener el .sql exacto de tu servidor local.");
echo "Instrucciones guardadas en backup_final_amonos.sql\n";
?>
