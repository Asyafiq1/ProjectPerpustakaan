import 'package:flutter/material.dart';
import '../../models/buku.dart';
import '../../services/api_services.dart';
import 'buku_form_screen.dart';
import 'buku_detail_screen.dart';

class BukuListScreen extends StatefulWidget {
  @override
  _BukuListScreenState createState() => _BukuListScreenState();
}

class _BukuListScreenState extends State<BukuListScreen> {
  late Future<List<Buku>> _bukuList;

  Future<List<Buku>> fetchBuku() async {
    final data = await ApiService.fetchData('buku/read.php');
    return data.map<Buku>((json) => Buku.fromJson(json)).toList();
  }

  void _confirmDelete(Buku buku) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus buku "${buku.judul}"?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Hapus'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                try {
                  await ApiService.deleteData('buku/delete.php', int.parse(buku.id! as String));
                  Navigator.of(context).pop();
                  _refreshList();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Buku berhasil dihapus')),
                  );
                } catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal menghapus buku: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _bukuList = fetchBuku();
  }

  void _refreshList() {
    setState(() {
      _bukuList = fetchBuku();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Buku"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BukuFormScreen()),
              );
              if (result == true) {
                _refreshList();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Buku>>(
        future: _bukuList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data buku."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Buku buku = snapshot.data![index];
                return Dismissible(
                  key: Key(buku.id! as String),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    _confirmDelete(buku);
                    return null;
                  },
                  child: ListTile(
                    leading: buku.foto != null 
                      ? Image.network(
                          buku.foto!, 
                          width: 50, 
                          height: 50, 
                          fit: BoxFit.cover
                        )
                      : Icon(Icons.book, size: 50),
                    title: Text(buku.judul ?? 'Judul Tidak Tersedia'),
                    subtitle: Text(buku.pengarang ?? 'Pengarang Tidak Tersedia'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BukuDetailScreen(bukuId: int.parse(buku.id! as String)),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
  
  BukuFormScreen() {}
}