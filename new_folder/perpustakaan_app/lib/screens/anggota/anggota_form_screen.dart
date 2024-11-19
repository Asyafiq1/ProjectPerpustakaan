import 'package:flutter/material.dart';
import '../../services/api_services.dart';

class AnggotaFormScreen extends StatefulWidget {
  final int? anggotaId;

  AnggotaFormScreen({this.anggotaId});

  @override
  _AnggotaFormScreenState createState() => _AnggotaFormScreenState();
}

class _AnggotaFormScreenState extends State<AnggotaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String nama = "";
  String alamat = "";
  String nomorTelepon = "";

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final apiUrl = widget.anggotaId == null
          ? 'anggota/create.php'
          : 'anggota/update.php';
      final data = {
        'nama': nama,
        'alamat': alamat,
        'nomor_telepon': nomorTelepon,
      };
      if (widget.anggotaId != null) data['id'] = widget.anggotaId.toString();

      final success = await ApiService.postData(apiUrl, data);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.anggotaId == null
              ? 'Anggota berhasil ditambahkan'
              : 'Anggota berhasil diperbarui')),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan data anggota')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.anggotaId == null ? 'Tambah Anggota' : 'Edit Anggota')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => nama = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => alamat = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nomor Telepon'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                },
                onSaved: (value) => nomorTelepon = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.anggotaId == null ? 'Simpan' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
