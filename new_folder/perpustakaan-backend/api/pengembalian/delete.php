<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: DELETE");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../../config/database.php';
include_once '../../models/Pengembalian.php';

$database = new Database();
$db = $database->getConnection();

$pengembalian = new Pengembalian($db);
$data = json_decode(file_get_contents("php://input"));

if (!empty($data->id)) {
    $pengembalian->id = $data->id;

    if ($pengembalian->delete()) {
        http_response_code(200);
        echo json_encode(["message" => "Pengembalian berhasil dihapus."]);
    } else {
        http_response_code(503);
        echo json_encode(["message" => "Gagal menghapus pengembalian."]);
    }
} else {
    http_response_code(400);
    echo json_encode(["message" => "Data tidak lengkap."]);
}
?>
