<?php
require_once("config/conexion.php");

$csvPath = "data_prices.csv";
if (!file_exists($csvPath)) {
    die("Archivo CSV no encontrado.");
}

$file = fopen($csvPath, "r");
$header = fgetcsv($file);

$count = 0;
while (($data = fgetcsv($file)) !== FALSE) {
    if (empty($data[0])) continue;
    if ($data[0] == "Lugar") continue;
    if (count($data) < 5 || empty($data[1])) continue;

    $nombre = trim($data[0]);
    $costosStr = trim($data[4]);

    try {
        $database = new Database();
        $db = $database->getConnection();

        $parseValue = function($pattern, $text) {
            if (preg_match($pattern, $text, $matches)) {
                $val = trim($matches[1]);
                $cleanVal = str_replace(['–', '-', ' ', '$'], '', $val);
                $parts = preg_split('/[\s]+/', $cleanVal);
                if (count($parts) == 2) {
                    return ((float)$parts[0] + (float)$parts[1]) / 2;
                }
                return (float)$parts[0];
            }
            return null;
        };

        // Extract specific costs
        $entrada = $parseValue('/Entrada: \$([0-9.–\s]+)/', $costosStr);
        $comida = $parseValue('/Alimentación: \$([0-9.–\s]+)/', $costosStr);
        $transporte = $parseValue('/Transporte: \$([0-9.–\s]+)/', $costosStr);

        // Extract total aproximado
        $totalAprox = null;
        if (preg_match('/Total aproximado: \$([0-9.–\s]+)/', $costosStr, $matches)) {
            $val = trim($matches[1]);
            $cleanVal = str_replace(['–', '-', ' ', '$'], '', $val);
            $parts = preg_split('/[\s]+/', $cleanVal);
            if (count($parts) == 2) {
                $totalAprox = ((float)$parts[0] + (float)$parts[1]) / 2;
            } else {
                $totalAprox = (float)$parts[0];
            }
        }

        // Fallbacks to ensure realistic numbers
        if ($entrada === null) $entrada = 2.00;
        if ($comida === null) $comida = 10.00;
        if ($transporte === null) $transporte = 8.00;

        // If total is provided, we adjust other values to match it for consistency
        if ($totalAprox !== null) {
            $currentSum = $entrada + $comida + $transporte;
            if ($currentSum > 0) {
                $ratio = $totalAprox / $currentSum;
                $entrada *= $ratio;
                $comida *= $ratio;
                $transporte *= $ratio;
            } else {
                $entrada = $totalAprox * 0.2;
                $comida = $totalAprox * 0.5;
                $transporte = $totalAprox * 0.3;
            }
        }

        $stmt = $db->prepare("UPDATE destinos SET precio_entrada = ?, precio_comida = ?, precio_parqueo = ? WHERE nombre = ?");
        $stmt->execute([$entrada, $comida, $transporte, $nombre]);

        $count++;
    } catch (Exception $e) {
        echo "Error actualizando $nombre: " . $e->getMessage() . "\n";
    }
}
fclose($file);
echo "Precios totales y detallados actualizados para $count destinos.";
?>
