import 'package:flutter/material.dart';
import 'screens/anggota/anggota_list_screen.dart';
import 'screens/buku/buku_list_screen.dart';
import 'screens/peminjaman/peminjaman_list_scree.dart';
import 'screens/pengembalian/pengembalian_list_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard(
            context,
            icon: Icons.person,
            label: "Anggota",
            screen: AnggotaListScreen(),
          ),
          _buildCard(
            context,
            icon: Icons.book,
            label: "Buku",
            screen: BukuListScreen(),
          ),
          _buildCard(
            context,
            icon: Icons.assignment,
            label: "Peminjaman",
            screen: PeminjamanListScreen(),
          ),
          _buildCard(
            context,
            icon: Icons.assignment_return,
            label: "Pengembalian",
            screen: PengembalianListScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required IconData icon, required String label, required Widget screen}) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.blue),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
