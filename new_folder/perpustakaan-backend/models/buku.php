<?php
class Buku {
    private $conn;
    private $table_name = "buku";

    public $id;
    public $judul;
    public $pengarang;
    public $penerbit;
    public $tahun_terbit;

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
        $query = "INSERT INTO " . $this->table_name . " SET judul=:judul, pengarang=:pengarang, penerbit=:penerbit, tahun_terbit=:tahun_terbit";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":judul", $this->judul);
        $stmt->bindParam(":pengarang", $this->pengarang);
        $stmt->bindParam(":penerbit", $this->penerbit);
        $stmt->bindParam(":tahun_terbit", $this->tahun_terbit);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function update() {
        $query = "UPDATE " . $this->table_name . " SET judul=:judul, pengarang=:pengarang, penerbit=:penerbit, tahun_terbit=:tahun_terbit WHERE id=:id";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);
        $stmt->bindParam(":judul", $this->judul);
        $stmt->bindParam(":pengarang", $this->pengarang);
        $stmt->bindParam(":penerbit", $this->penerbit);
        $stmt->bindParam(":tahun_terbit", $this->tahun_terbit);

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
