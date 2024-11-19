import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:perpustakaan_app/models/pengembalian.dart';

class ApiService {
  static const String baseUrl = "http://localhost/perpustakaan-backend/api/";

  static Future<List<dynamic>> fetchData(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<Map<String, dynamic>> fetchSingle(String endpoint, int id) async {
    final url = Uri.parse("$baseUrl$endpoint/$id");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<bool> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl$endpoint");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    return response.statusCode == 201;
  }

  static Future<bool> updateData(String endpoint, int id, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl$endpoint/$id");
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteData(String endpoint, int id) async {
    final url = Uri.parse("$baseUrl$endpoint/$id");
    final response = await http.delete(url);

    return response.statusCode == 200;
  }

  static fetchDataById(String s, int anggotaId) {}

  updatePengembalian(Pengembalian pengembalian) {}

  createPengembalian(Pengembalian pengembalian) {}

  
}
