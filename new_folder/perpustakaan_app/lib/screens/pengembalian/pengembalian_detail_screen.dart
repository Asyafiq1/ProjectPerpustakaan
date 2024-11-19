import 'package:flutter/material.dart';
import '../../models/pengembalian.dart';
import '../../services/api_services.dart';

class PengembalianDetailScreen extends StatefulWidget {
  final int pengembalianId;

  PengembalianDetailScreen({required this.pengembalianId});

  @override
  _PengembalianDetailScreenState createState() =>
      _PengembalianDetailScreenState();
}

class _PengembalianDetailScreenState extends State<PengembalianDetailScreen> {
  late Future<Pengembalian> _pengembalianDetail;

  Future<Pengembalian> fetchPengembalianDetail() async {
    final response = await ApiService.fetchDataById(
        'pengembalian/read.php', widget.pengembalianId);
    return Pengembalian.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    _pengembalianDetail = fetchPengembalianDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Pengembalian')),
      body: FutureBuilder<Pengembalian>(
        future: _pengembalianDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Data pengembalian tidak ditemukan.'));
          } else {
            final pengembalian = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kode Pengembalian: ${pengembalian.kodePengembalian}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Peminjam: ${pengembalian.namaPeminjam}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Buku Dikembalikan: ${pengembalian.bukuDikembalikan}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tanggal Pinjam: ${pengembalian.tanggalPinjam}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tanggal Kembali: ${pengembalian.tanggalKembali}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Denda: Rp${pengembalian.denda.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16, color: Colors.red),
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
