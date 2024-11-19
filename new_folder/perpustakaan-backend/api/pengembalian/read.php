<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';
include_once '../../models/Pengembalian.php';

$database = new Database();
$db = $database->getConnection();

$pengembalian = new Pengembalian($db);
$stmt = $pengembalian->read();
$num = $stmt->rowCount();

if ($num > 0) {
    $pengembalian_arr = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $pengembalian_item = array(
            "id" => $id,
            "peminjaman_id" => $peminjaman_id,
            "tanggal_dikembalikan" => $tanggal_dikembalikan,
            "terlambat" => $terlambat,
            "denda" => $denda
        );
        array_push($pengembalian_arr, $pengembalian_item);
    }
    http_response_code(200);
    echo json_encode($pengembalian_arr);
} else {
    http_response_code(404);
    echo json_encode(["message" => "Tidak ada pengembalian ditemukan."]);
}
?>
