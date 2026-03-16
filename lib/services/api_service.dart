import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {

  Future<List<Product>> fetchProducts() async {

    final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products")
    );

    if (response.statusCode == 200) {

      List jsonData = json.decode(response.body);

      return jsonData
          .map((product) => Product.fromJson(product))
          .toList();

    } else {
      throw Exception("Failed to load products");
    }
  }
}