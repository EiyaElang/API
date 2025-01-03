import 'dart:convert';
import 'package:http/http.dart' as http;
import 'catalog_item.dart'; // Pastikan Anda memiliki kelas CatalogItem yang sesuai

class ApiService {
  static const String baseUrl = 'http://localhost:3000/catalog';

  // Mendapatkan daftar item katalog
  Future<List<CatalogItem>> getCatalogItems() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => CatalogItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load catalog items');
    }
  }

  // Menambahkan item ke katalog
  Future<void> addCatalogItem(String name) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add item');
    }
  }

  // Memperbarui item katalog
  Future<void> updateCatalogItem(int id, String name) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  // Menghapus item katalog
  Future<void> deleteCatalogItem(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete item');
    }
  }
}
