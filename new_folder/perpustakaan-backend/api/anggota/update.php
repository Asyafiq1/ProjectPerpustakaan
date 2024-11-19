<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';
include_once '../../models/Anggota.php';

$database = new Database();
$db = $database->getConnection();

$anggota = new Anggota($db);
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id)) {
    $anggota->id = $data->id;
    $anggota->nim = $data->nim;
    $anggota->nama = $data->nama;
    $anggota->alamat = $data->alamat;
    $anggota->jenis_kelamin = $data->jenis_kelamin;

    if ($anggota->update()) {
        http_response_code(200);
        echo json_encode(["message" => "Anggota berhasil diperbarui."]);
    } else {
        http_response_code(503);
        echo json_encode(["message" => "Gagal memperbarui anggota."]);
    }
} else {
    http_response_code(400);
    echo json_encode(["message" => "Data tidak lengkap."]);
}
?>
