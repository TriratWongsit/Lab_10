import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _url = 'https://fakestoreapi.com/products';

  Future<List<dynamic>> fetchProducts() async {
    try {
      final res = await http.get(Uri.parse(_url));
      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}