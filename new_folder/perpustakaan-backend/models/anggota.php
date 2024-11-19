<?php
class Anggota {
    private $conn;
    private $table_name = "anggota";

    public $id;
    public $nim;
    public $nama;
    public $alamat;
    public $jenis_kelamin;

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
        $query = "INSERT INTO " . $this->table_name . " SET nim=:nim, nama=:nama, alamat=:alamat, jenis_kelamin=:jenis_kelamin";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":nim", $this->nim);
        $stmt->bindParam(":nama", $this->nama);
        $stmt->bindParam(":alamat", $this->alamat);
        $stmt->bindParam(":jenis_kelamin", $this->jenis_kelamin);

        if ($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function update() {
        $query = "UPDATE " . $this->table_name . " SET nim=:nim, nama=:nama, alamat=:alamat, jenis_kelamin=:jenis_kelamin WHERE id=:id";
        $stmt = $this->conn->prepare($query);

        $stmt->bindParam(":id", $this->id);
        $stmt->bindParam(":nim", $this->nim);
        $stmt->bindParam(":nama", $this->nama);
        $stmt->bindParam(":alamat", $this->alamat);
        $stmt->bindParam(":jenis_kelamin", $this->jenis_kelamin);

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
