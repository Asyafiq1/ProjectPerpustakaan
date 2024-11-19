<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';
include_once '../../models/Peminjaman.php';

$database = new Database();
$db = $database->getConnection();

$peminjaman = new Peminjaman($db);
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id)) {
    $peminjaman->id = $data->id;
    $peminjaman->anggota_id = $data->anggota_id;
    $peminjaman->buku_id = $data->buku_id;
    $peminjaman->tanggal_pinjam = $data->tanggal_pinjam;
    $peminjaman->tanggal_kembali = $data->tanggal_kembali;

    if ($peminjaman->update()) {
        http_response_code(200);
        echo json_encode(["message" => "Peminjaman berhasil diperbarui."]);
    } else {
        http_response_code(503);
        echo json_encode(["message" => "Gagal memperbarui peminjaman."]);
    }
} else {
    http_response_code(400);
    echo json_encode(["message" => "Data tidak lengkap."]);
}
?>
