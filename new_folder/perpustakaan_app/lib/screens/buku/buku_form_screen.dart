import 'package:flutter/material.dart';
import '../../services/api_services.dart';

class PeminjamanFormScreen extends StatefulWidget {
  @override
  _PeminjamanFormScreenState createState() => _PeminjamanFormScreenState();
}

class _PeminjamanFormScreenState extends State<PeminjamanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String idAnggota = "";
  String idBuku = "";
  String tanggalPinjam = "";
  String tanggalKembali = "";

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final success = await ApiService.postData('peminjaman/create.php', {
        'id_anggota': idAnggota,
        'id_buku': idBuku,
        'tanggal_pinjam': tanggalPinjam,
        'tanggal_kembali': tanggalKembali,
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Peminjaman berhasil ditambahkan')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan peminjaman')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Peminjaman')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'ID Anggota'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Anggota tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => idAnggota = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'ID Buku'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'ID Buku tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => idBuku = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Pinjam'),
                onSaved: (value) => tanggalPinjam = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Kembali'),
                onSaved: (value) => tanggalKembali = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
