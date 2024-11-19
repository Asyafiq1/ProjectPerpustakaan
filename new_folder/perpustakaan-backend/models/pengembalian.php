<?php
class Pengembalian {
    private $conn;
    private $table_name = "pengembalian";

    public $id;
    public $peminjaman_id;
    public $tanggal_dikembalikan;
    public $terlambat;
    public $denda;

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
        $query = "INSERT INTO " . $this->table_name . " SET peminjaman_id=:peminjaman_id, tanggal_dikembalikan=:tanggal_dikembalikan, terlambat=:terlambat, denda=:denda";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":peminjaman_id", $this->peminjaman_id);
        $stmt->bindParam(":tanggal_dikembalikan", $this->tanggal_dikembalikan);
        $stmt->bindParam(":terlambat", $this->terlambat);
        $stmt->bindParam(":denda", $this->denda);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function update() {
        $query = "UPDATE " . $this->table_name . " SET peminjaman_id=:peminjaman_id, tanggal_dikembalikan=:tanggal_dikembalikan, terlambat=:terlambat, denda=:denda WHERE id=:id";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);
        $stmt->bindParam(":peminjaman_id", $this->peminjaman_id);
        $stmt->bindParam(":tanggal_dikembalikan", $this->tanggal_dikembalikan);
        $stmt->bindParam(":terlambat", $this->terlambat);
        $stmt->bindParam(":denda", $this->denda);

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
