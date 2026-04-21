import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {

  // Base URL
  final String baseUrl = "https://fakestoreapi.com/products";

  // =========================
  // GET → Fetch all products
  // =========================
  Future<List<Product>> fetchProducts() async {

    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {

      List data = json.decode(response.body);

      return data.map((e) => Product.fromJson(e)).toList();

    } else {
      throw Exception("Failed to load products");
    }
  }

  // =========================
  // POST → Add new product
  // =========================
  Future<void> addProduct() async {

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "title": "New Product",
        "price": 100.0,
        "description": "This is a demo product",
        "image": "https://i.pravatar.cc",
        "category": "electronics"
      }),
    );

    print("POST Response: ${response.body}");
  }

  // =========================
  // PUT → Update product
  // =========================
  Future<void> updateProduct(int id) async {

    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "title": "Updated Product",
        "price": 150.0,
        "description": "Updated description",
        "image": "https://i.pravatar.cc",
        "category": "electronics"
      }),
    );

    print("PUT Response: ${response.body}");
  }

  // =========================
  // DELETE → Delete product
  // =========================
  Future<void> deleteProduct(int id) async {

    final response = await http.delete(
      Uri.parse("$baseUrl/$id"),
    );

    print("DELETE Response: ${response.body}");
  }
}