<?php
require_once 'config/conexion.php';

$keep_destinations = [
    'Parque Nacional El Imposible',
    'Concepción de Ataco',
    'Lago de Coatepeque',
    'Volcán de Santa Ana (Ilamatepec)',
    'Juayúa',
    'Playa Los Cóbanos',
    'Parque Nacional El Boquerón',
    'Playa El Tunco',
    'Teatro Nacional de San Salvador',
    'Centro Histórico de San Salvador',
    'Cerro El Pital',
    'La Palma',
    'Bahía de Jiquilisco',
    'Playa El Espino',
    'Volcán de San Vicente (Chinchontepec)',
    'Turicentro Amapulapa',
    'Suchitoto',
    'Lago de Suchitlán',
    'Museo de la Revolución',
    'El Llano del Muerto',
    'Playa Costa del Sol',
    'Estero de Jaltepeque',
    'Conchagua',
    'Golfo de Fonseca',
    'Ilobasco',
    'Eco-Parque Heliconia',
    'Volcán de San Miguel (Chaparrastique)',
    'Mercados Gastronómicos de San Miguel',
    'Apaneca',
    'Cerro Verde'
];

try {
    $database = new Database();
    $db = $database->getConnection();

    // 1. Obtener IDs de los destinos a mantener
    $ids_to_keep = [];
    foreach ($keep_destinations as $nombre) {
        $stmt = $db->prepare("SELECT id_destino FROM destinos WHERE nombre = ?");
        $stmt->execute([$nombre]);
        $res = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($res) {
            $ids_to_keep[] = $res['id_destino'];
        }
    }

    if (empty($ids_to_keep)) {
        die("No se encontraron destinos que coincidan con la lista. Abortando para evitar borrar todo.\n");
    }

    // 2. Crear lista de IDs para el query (ej. 1,2,3)
    $ids_string = implode(',', $ids_to_keep);

    // 3. Borrar imágenes de los destinos que serán eliminados
    $db->exec("DELETE FROM imagenes_destino WHERE id_destino NOT IN ($ids_string)");
    echo "Deleted images of removed destinations.\n";

    // 4. Borrar actividades de los destinos que serán eliminados
    $db->exec("DELETE FROM actividades WHERE id_destino NOT IN ($ids_string)");
    echo "Deleted activities of removed destinations.\n";

    // 5. Borrar reseñas de los destinos que serán eliminados
    $db->exec("DELETE FROM resenas WHERE id_destino NOT IN ($ids_string)");
    echo "Deleted reviews of removed destinations.\n";

    // 6. Borrar los destinos mismos
    $db->exec("DELETE FROM destinos WHERE id_destino NOT IN ($ids_string)");
    echo "Deleted destinations not in the keep list.\n";

    echo "\nCleanup completed successfully. Only " . count($ids_to_keep) . " destinations remain.\n";

} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
}
?>
