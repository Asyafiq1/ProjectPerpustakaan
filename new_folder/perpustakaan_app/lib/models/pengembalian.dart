class Pengembalian {
  int? id;
  int peminjamanId;
  String tanggalDikembalikan;
  int terlambat;
  double denda;

  Pengembalian({
    this.id,
    required this.peminjamanId,
    required this.tanggalDikembalikan,
    this.terlambat = 0,
    this.denda = 0.0,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'],
      peminjamanId: json['peminjaman_id'],
      tanggalDikembalikan: json['tanggal_dikembalikan'],
      terlambat: json['terlambat'] ?? 0,
      denda: (json['denda'] ?? 0).toDouble(),
    );
  }

  get kodePengembalian => null;

  get namaPeminjam => null;

  get bukuDikembalikan => null;

  get tanggalPinjam => null;

  get tanggalKembali => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'peminjaman_id': peminjamanId,
      'tanggal_dikembalikan': tanggalDikembalikan,
      'terlambat': terlambat,
      'denda': denda,
    };
  }
}
