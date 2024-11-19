import 'package:flutter/material.dart';
import '../../models/peminjaman.dart';
import '../../services/api_services.dart';

class PeminjamanListScreen extends StatefulWidget {
  @override
  _PeminjamanListScreenState createState() => _PeminjamanListScreenState();
}

class _PeminjamanListScreenState extends State<PeminjamanListScreen> {
  late Future<List<Peminjaman>> _peminjamanList;

  Future<List<Peminjaman>> fetchPeminjaman() async {
    final data = await ApiService.fetchData('peminjaman/read.php');
    return data.map<Peminjaman>((json) => Peminjaman.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _peminjamanList = fetchPeminjaman();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Peminjaman")),
      body: FutureBuilder<List<Peminjaman>>(
        future: _peminjamanList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data peminjaman."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final peminjaman = snapshot.data![index];
                return ListTile(
                  title: Text(peminjaman.namaAnggota),
                  subtitle: Text("Buku: ${peminjaman.judulBuku}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
