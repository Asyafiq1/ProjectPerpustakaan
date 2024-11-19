import 'package:flutter/material.dart';
import '../../models/anggota.dart';
import '../../services/api_services.dart';

class AnggotaDetailScreen extends StatefulWidget {
  final int anggotaId;

  AnggotaDetailScreen({required this.anggotaId});

  @override
  _AnggotaDetailScreenState createState() => _AnggotaDetailScreenState();
}

class _AnggotaDetailScreenState extends State<AnggotaDetailScreen> {
  late Future<Anggota> _anggotaDetail;

  Future<Anggota> fetchAnggotaDetail() async {
    final response = await ApiService.fetchDataById('anggota/read.php', widget.anggotaId);
    return Anggota.fromJson(response);
  }

  @override
  void initState() {
    super.initState();
    _anggotaDetail = fetchAnggotaDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Anggota')),
      body: FutureBuilder<Anggota>(
        future: _anggotaDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            Anggota anggota = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: anggota.foto != null 
                            ? NetworkImage(anggota.foto!) 
                            : AssetImage('assets/default_avatar.png') as ImageProvider,
                        ),
                        SizedBox(height: 16),
                        Text(
                          anggota.nama ?? 'Nama Tidak Tersedia', 
                          style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildDetailRow('NIS', anggota.nim ?? 'Tidak Ada'),
                  _buildDetailRow('Kelas', anggota.kelas ?? 'Tidak Ada'),
                  _buildDetailRow('Jenis Kelamin', anggota.jenisKelamin ?? 'Tidak Ada'),
                  _buildDetailRow('Alamat', anggota.alamat ?? 'Tidak Ada'),
                  _buildDetailRow('No Telepon', anggota.noTelp ?? 'Tidak Ada'),
                  _buildDetailRow('Email', anggota.email ?? 'Tidak Ada'),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label, 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black87
              ),
            ),
          ),
        ],
      ),
    );
  }
}