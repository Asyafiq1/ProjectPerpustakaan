<?php
class Peminjaman {
    private $conn;
    private $table_name = "peminjaman";

    public $id;
    public $anggota_id;
    public $buku_id;
    public $tanggal_pinjam;
    public $tanggal_kembali;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function read() {
        $query = "SELECT * FROM " . $this->table_name;
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function create() {
        $query = "INSERT INTO " . $this->table_name . " SET anggota_id=:anggota_id, buku_id=:buku_id, tanggal_pinjam=:tanggal_pinjam, tanggal_kembali=:tanggal_kembali";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":anggota_id", $this->anggota_id);
        $stmt->bindParam(":buku_id", $this->buku_id);
        $stmt->bindParam(":tanggal_pinjam", $this->tanggal_pinjam);
        $stmt->bindParam(":tanggal_kembali", $this->tanggal_kembali);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function update() {
        $query = "UPDATE " . $this->table_name . " SET anggota_id=:anggota_id, buku_id=:buku_id, tanggal_pinjam=:tanggal_pinjam, tanggal_kembali=:tanggal_kembali WHERE id=:id";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);
        $stmt->bindParam(":anggota_id", $this->anggota_id);
        $stmt->bindParam(":buku_id", $this->buku_id);
        $stmt->bindParam(":tanggal_pinjam", $this->tanggal_pinjam);
        $stmt->bindParam(":tanggal_kembali", $this->tanggal_kembali);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function delete() {
        $query = "DELETE FROM " . $this->table_name . " WHERE id=:id";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }
}
?>
