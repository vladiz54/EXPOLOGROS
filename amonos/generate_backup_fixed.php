<?php
require_once 'config/conexion.php';
$database = new Database();
$db = $database->getConnection();

$filePath = 'C:/laragon/www/EXPOLOGROS/amonos/backup_final_amonos.sql';
$sql = "-- ÁMONOS FINAL DATABASE DUMP\n";
$sql .= "SET FOREIGN_KEY_CHECKS = 0;\n\n";

$tables = ['categorias_destino', 'destinos', 'imagenes_destino', 'usuarios', 'visitados', 'favoritos', 'actividades', 'resenas'];

foreach ($tables as $table) {
    $sql .= "-- Table: $table\n";

    // Estructura
    $res = $db->query("SHOW CREATE TABLE $table");
    $create = $res->fetch(PDO::FETCH_ASSOC);
    $sql .= $create['Create Table'] . ";\n\n";

    // Datos
    $stmt = $db->query("SELECT * FROM $table");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $cols = implode(", ", array_keys($row));
        $vals = [];
        foreach ($row as $val) {
            if (is_null($val)) {
                $vals[] = "NULL";
            } else {
                $vals[] = "'" . str_replace("'", "''", $val) . "'";
            }
        }
        $sql .= "INSERT INTO $table ($cols) VALUES ('" . implode("', '", array_values($row)) . "');\n";
        // Corrigiendo el problema de las comillas manuales:
    }
    $sql .= "\n\n";
}

$sql .= "SET FOREIGN_KEY_CHECKS = 1;";

if (file_put_contents($filePath, $sql)) {
    echo "SUCCESS: File created at $filePath\n";
} else {
    echo "ERROR: Could not write file\n";
}
?>
