<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../../config/database.php';
include_once '../../models/Peminjaman.php';

$database = new Database();
$db = $database->getConnection();

$peminjaman = new Peminjaman($db);
$stmt = $peminjaman->read();
$num = $stmt->rowCount();

if ($num > 0) {
    $peminjaman_arr = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $peminjaman_item = array(
            "id" => $id,
            "anggota_id" => $anggota_id,
            "buku_id" => $buku_id,
            "tanggal_pinjam" => $tanggal_pinjam,
            "tanggal_kembali" => $tanggal_kembali
        );
        array_push($peminjaman_arr, $peminjaman_item);
    }
    http_response_code(200);
    echo json_encode($peminjaman_arr);
} else {
    http_response_code(404);
    echo json_encode(["message" => "Tidak ada peminjaman ditemukan."]);
}
?>
