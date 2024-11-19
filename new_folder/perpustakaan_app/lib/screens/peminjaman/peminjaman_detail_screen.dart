import 'package:flutter/material.dart';
import '../../models/peminjaman.dart';
import '../../services/api_services.dart';

class PeminjamanDetailScreen extends StatefulWidget {
  final int peminjamanId;

  PeminjamanDetailScreen({required this.peminjamanId});

  @override
  _PeminjamanDetailScreenState createState() => _PeminjamanDetailScreenState();
}

class _PeminjamanDetailScreenState extends State<PeminjamanDetailScreen> {
  late Future<Peminjaman> _peminjamanDetail;

  Future<Peminjaman> fetchPeminjamanDetail() async {
    final response =
        await ApiService.fetchDataById('peminjaman/read.php', widget.peminjamanId);
    return Peminjaman.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    _peminjamanDetail = fetchPeminjamanDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Peminjaman')),
      body: FutureBuilder<Peminjaman>(
        future: _peminjamanDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Data peminjaman tidak ditemukan.'));
          } else {
            final peminjaman = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kode Peminjaman: ${peminjaman.kodePeminjaman}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Peminjam: ${peminjaman.namaPeminjam}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Buku Dipinjam: ${peminjaman.bukuDipinjam}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tanggal Pinjam: ${peminjaman.tanggalPinjam}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tanggal Kembali: ${peminjaman.tanggalKembali}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Kembali'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
