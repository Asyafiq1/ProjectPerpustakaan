import 'package:flutter/material.dart';
import '../../models/anggota.dart';
import '../../services/api_services.dart';
import 'anggota_detail_screen.dart';
import 'anggota_form_screen.dart';

class AnggotaListScreen extends StatefulWidget {
  @override
  _AnggotaListScreenState createState() => _AnggotaListScreenState();
}

class _AnggotaListScreenState extends State<AnggotaListScreen> {
  late Future<List<Anggota>> _anggotaList;

  Future<List<Anggota>> fetchAnggotaList() async {
    final data = await ApiService.fetchData('anggota/read.php');
    return data.map<Anggota>((json) => Anggota.fromJson(json)).toList();
  }

  @override
  void initState() {
    super.initState();
    _anggotaList = fetchAnggotaList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Anggota'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnggotaFormScreen()),
              ).then((_) {
                setState(() {
                  _anggotaList = fetchAnggotaList();
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Anggota>>(
        future: _anggotaList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data anggota.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final anggota = snapshot.data![index];
                return ListTile(
                  title: Text(anggota.nama),
                  subtitle: Text(anggota.noTelp),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnggotaDetailScreen(anggotaId: anggota.id),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final success = await ApiService.deleteData(
                          'anggota/delete.php', anggota.id);
                      if (success) {
                        setState(() {
                          _anggotaList = fetchAnggotaList();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Anggota berhasil dihapus')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gagal menghapus anggota')),
                        );
                      }
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
}
