import 'package:flutter/material.dart';
import '../../models/pengembalian.dart';
import '../../services/api_services.dart';

class PengembalianFormScreen extends StatefulWidget {
  final Pengembalian? pengembalian;

  PengembalianFormScreen({this.pengembalian});

  @override
  _PengembalianFormScreenState createState() => _PengembalianFormScreenState();
}

class _PengembalianFormScreenState extends State<PengembalianFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  late TextEditingController _peminjamanIdController;
  late TextEditingController _tanggalDikembalikanController;
  late TextEditingController _terlambatController;
  late TextEditingController _dendaController;

  @override
  void initState() {
    super.initState();
    _peminjamanIdController =
        TextEditingController(text: widget.pengembalian?.peminjamanId.toString() ?? "");
    _tanggalDikembalikanController =
        TextEditingController(text: widget.pengembalian?.tanggalDikembalikan ?? "");
    _terlambatController =
        TextEditingController(text: widget.pengembalian?.terlambat.toString() ?? "0");
    _dendaController =
        TextEditingController(text: widget.pengembalian?.denda.toString() ?? "0");
  }

  @override
  void dispose() {
    _peminjamanIdController.dispose();
    _tanggalDikembalikanController.dispose();
    _terlambatController.dispose();
    _dendaController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final pengembalian = Pengembalian(
        peminjamanId: int.parse(_peminjamanIdController.text),
        tanggalDikembalikan: _tanggalDikembalikanController.text,
        terlambat: int.parse(_terlambatController.text),
        denda: double.parse(_dendaController.text),
      );

      if (widget.pengembalian == null) {
        await _apiService.createPengembalian(pengembalian);
      } else {
        pengembalian.id = widget.pengembalian!.id;
        await _apiService.updatePengembalian(pengembalian);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pengembalian == null ? "Tambah Pengembalian" : "Edit Pengembalian"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _peminjamanIdController,
                decoration: InputDecoration(labelText: "Peminjaman ID"),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _tanggalDikembalikanController,
                decoration: InputDecoration(labelText: "Tanggal Dikembalikan"),
                validator: (value) => value!.isEmpty ? "Wajib diisi" : null,
              ),
              TextFormField(
                controller: _terlambatController,
                decoration: InputDecoration(labelText: "Terlambat (hari)"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _dendaController,
                decoration: InputDecoration(labelText: "Denda"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
