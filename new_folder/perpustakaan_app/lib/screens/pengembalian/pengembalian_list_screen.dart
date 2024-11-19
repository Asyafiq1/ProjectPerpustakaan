import 'package:flutter/material.dart';
import '../../models/pengembalian.dart';
import '../../services/api_services.dart';

class PengembalianListScreen extends StatefulWidget {
  @override
  _PengembalianListScreenState createState() => _PengembalianListScreenState();
}

class _PengembalianListScreenState extends State<PengembalianListScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Pengembalian>> _pengembalianList;
  
  get apiService => null;

  @override
  void initState() {
    super.initState();
    _pengembalianList = apiService.getPengembalian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengembalian"),
      ),
      body: FutureBuilder<List<Pengembalian>>(
        future: _pengembalianList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Terjadi kesalahan!"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data pengembalian."));
          }

          final pengembalianList = snapshot.data!;
          return ListView.builder(
            itemCount: pengembalianList.length,
            itemBuilder: (context, index) {
              final pengembalian = pengembalianList[index];
              return ListTile(
                title: Text("Peminjaman ID: ${pengembalian.peminjamanId}"),
                subtitle: Text(
                  "Tanggal: ${pengembalian.tanggalDikembalikan}, Denda: ${pengembalian.denda}",
                ),
                onTap: () {
                  // Navigate to detail or form screen
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to form screen
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
