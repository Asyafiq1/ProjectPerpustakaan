class Buku {
  final int id;
  final String judul;
  final String pengarang;
  final String penerbit;
  final int tahunTerbit;

  Buku({
    required this.id,
    required this.judul,
    required this.pengarang,
    required this.penerbit,
    required this.tahunTerbit,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      judul: json['judul'],
      pengarang: json['pengarang'],
      penerbit: json['penerbit'],
      tahunTerbit: json['tahun_terbit'],
    );
  }

  get foto => null;

  get penulis => null;

  get kategori => null;

  get deskripsi => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'pengarang': pengarang,
      'penerbit': penerbit,
      'tahun_terbit': tahunTerbit,
    };
  }
}
