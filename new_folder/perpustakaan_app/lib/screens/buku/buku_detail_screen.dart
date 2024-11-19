import 'package:flutter/material.dart';
import '../../models/buku.dart';
import '../../services/api_services.dart';

class BukuDetailScreen extends StatefulWidget {
  final int bukuId;

  BukuDetailScreen({required this.bukuId});

  @override
  _BukuDetailScreenState createState() => _BukuDetailScreenState();
}

class _BukuDetailScreenState extends State<BukuDetailScreen> {
  late Future<Buku> _bukuDetail;

  Future<Buku> fetchBukuDetail() async {
    final response = await ApiService.fetchDataById('buku/read.php', widget.bukuId);
    return Buku.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    _bukuDetail = fetchBukuDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Buku')),
      body: FutureBuilder<Buku>(
        future: _bukuDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Data buku tidak ditemukan.'));
          } else {
            final buku = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    buku.judul,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Penulis: ${buku.penulis}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Penerbit: ${buku.penerbit}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Kategori: ${buku.kategori}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tahun Terbit: ${buku.tahunTerbit}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Deskripsi:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    buku.deskripsi ?? 'Tidak ada deskripsi.',
                    style: TextStyle(fontSize: 14),
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
