class Peminjaman {
  final int id;
  final String namaAnggota;
  final String judulBuku;
  final String tanggalPinjam;
  final String tanggalKembali;
  final bool isLate;

  Peminjaman({
    required this.id,
    required this.namaAnggota,
    required this.judulBuku,
    required this.tanggalPinjam,
    required this.tanggalKembali,
    required this.isLate,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'],
      namaAnggota: json['nama_anggota'],
      judulBuku: json['judul_buku'],
      tanggalPinjam: json['tanggal_pinjam'],
      tanggalKembali: json['tanggal_kembali'],
      isLate: json['is_late'],
    );
  }

  get kodePeminjaman => null;

  get namaPeminjam => null;

  get bukuDipinjam => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_anggota': namaAnggota,
      'judul_buku': judulBuku,
      'tanggal_pinjam': tanggalPinjam,
      'tanggal_kembali': tanggalKembali,
      'is_late': isLate,
    };
  }
}
