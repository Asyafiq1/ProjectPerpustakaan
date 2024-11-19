class Anggota {
  final int id;
  final String nim;
  final String nama;
  final String alamat;
  final String jenisKelamin;

  Anggota({
    required this.id,
    required this.nim,
    required this.nama,
    required this.alamat,
    required this.jenisKelamin,
  });

  factory Anggota.fromJson(Map<String, dynamic> json) {
    return Anggota(
      id: json['id'],
      nim: json['nim'],
      nama: json['nama'],
      alamat: json['alamat'],
      jenisKelamin: json['jenis_kelamin'],
    );
  }

  get foto => null;

  get kelas => null;

  get noTelp => null;

  get email => null;

  String? get nomorTelepon => null;
}
