<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';
include_once '../../models/Pengembalian.php';

$database = new Database();
$db = $database->getConnection();

$pengembalian = new Pengembalian($db);
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->peminjaman_id) && !empty($data->tanggal_dikembalikan)) {
    $pengembalian->peminjaman_id = $data->peminjaman_id;
    $pengembalian->tanggal_dikembalikan = $data->tanggal_dikembalikan;
    $pengembalian->terlambat = $data->terlambat ?? 0;
    $pengembalian->denda = $data->denda ?? 0;

    if ($pengembalian->create()) {
        http_response_code(201);
        echo json_encode(["message" => "Pengembalian berhasil ditambahkan."]);
    } else {
        http_response_code(503);
        echo json_encode(["message" => "Gagal menambahkan pengembalian."]);
    }
} else {
    http_response_code(400);
    echo json_encode(["message" => "Data tidak lengkap."]);
}
?>
