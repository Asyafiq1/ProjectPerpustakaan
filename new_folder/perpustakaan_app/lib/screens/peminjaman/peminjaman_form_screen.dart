import 'package:flutter/material.dart';
import '../../services/api_services.dart';

class PeminjamanFormScreen extends StatefulWidget {
  final int? peminjamanId;

  PeminjamanFormScreen({this.peminjamanId});

  @override
  _PeminjamanFormScreenState createState() => _PeminjamanFormScreenState();
}

class _PeminjamanFormScreenState extends State<PeminjamanFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String kodePeminjaman = "";
  String namaPeminjam = "";
  String tanggalPinjam = "";
  String tanggalKembali = "";
  String bukuDipinjam = "";

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final apiUrl = widget.peminjamanId == null
          ? 'peminjaman/create.php'
          : 'peminjaman/update.php';
      final data = {
        'kode_peminjaman': kodePeminjaman,
        'nama_peminjam': namaPeminjam,
        'tanggal_pinjam': tanggalPinjam,
        'tanggal_kembali': tanggalKembali,
        'buku_dipinjam': bukuDipinjam,
      };
      if (widget.peminjamanId != null) data['id'] = widget.peminjamanId.toString();

      final success = await ApiService.postData(apiUrl, data);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.peminjamanId == null
              ? 'Peminjaman berhasil ditambahkan'
              : 'Peminjaman berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data peminjaman')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.peminjamanId == null ? 'Tambah Peminjaman' : 'Edit Peminjaman')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Kode Peminjaman'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode peminjaman tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => kodePeminjaman = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama Peminjam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama peminjam tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => namaPeminjam = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Pinjam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal pinjam tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => tanggalPinjam = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Tanggal Kembali'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal kembali tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => tanggalKembali = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Buku Dipinjam'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Buku dipinjam tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => bukuDipinjam = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.peminjamanId == null ? 'Simpan' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
