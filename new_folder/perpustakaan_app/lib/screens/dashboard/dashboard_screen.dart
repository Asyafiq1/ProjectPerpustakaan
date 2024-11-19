import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Berikut adalah ringkasan data perpustakaan Anda.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildDashboardCard(
                    title: "Anggota",
                    count: 120, // Jumlah total anggota (fetch dari API)
                    icon: Icons.people,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.pushNamed(context, '/anggota'); // Route ke list anggota
                    },
                  ),
                  _buildDashboardCard(
                    title: "Buku",
                    count: 500, // Jumlah total buku
                    icon: Icons.book,
                    color: Colors.green,
                    onTap: () {
                      Navigator.pushNamed(context, '/buku'); // Route ke list buku
                    },
                  ),
                  _buildDashboardCard(
                    title: "Peminjaman",
                    count: 45, // Jumlah peminjaman aktif
                    icon: Icons.assignment,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pushNamed(context, '/peminjaman');
                    },
                  ),
                  _buildDashboardCard(
                    title: "Pengembalian",
                    count: 12, // Jumlah pengembalian terlambat
                    icon: Icons.assignment_return,
                    color: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(context, '/pengembalian');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 10),
              Text(
                "$count",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
