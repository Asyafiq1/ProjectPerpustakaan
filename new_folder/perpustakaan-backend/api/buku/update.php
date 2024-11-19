<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: PUT");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';
include_once '../../models/Buku.php';

$database = new Database();
$db = $database->getConnection();

$buku = new Buku($db);
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id)) {
    $buku->id = $data->id;
    $buku->judul = $data->judul;
    $buku->pengarang = $data->pengarang;
    $buku->penerbit = $data->penerbit;
    $buku->tahun_terbit = $data->tahun_terbit;

    if ($buku->update()) {
        http_response_code(200);
        echo json_encode(["message" => "Buku berhasil diperbarui."]);
    } else {
        http_response_code(503);
        echo json_encode(["message" => "Gagal memperbarui buku."]);
    }
} else {
    http_response_code(400);
    echo json_encode(["message" => "Data tidak lengkap."]);
}
?>
