<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';
include_once '../../models/Anggota.php';

$database = new Database();
$db = $database->getConnection();

$anggota = new Anggota($db);
$stmt = $anggota->read();
$num = $stmt->rowCount();

if ($num > 0) {
    $anggota_arr = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $anggota_item = array(
            "id" => $id,
            "nim" => $nim,
            "nama" => $nama,
            "alamat" => $alamat,
            "jenis_kelamin" => $jenis_kelamin
        );
        array_push($anggota_arr, $anggota_item);
    }
    http_response_code(200);
    echo json_encode($anggota_arr);
} else {
    http_response_code(404);
    echo json_encode(["message" => "Tidak ada anggota ditemukan."]);
}
?>
