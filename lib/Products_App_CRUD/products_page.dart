import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/Product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // GET - fetch all products
  Future<void> _fetchProducts() async {
    setState(() => _isLoading = true);

    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _products = data.map((item) => Product.fromJson(item)).toList();
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // POST - add new product
  Future<void> _addProduct() async {
    final response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': 'New Product',
        'price': 99.99,
        'description': 'A new product added by me',
        'category': 'electronics',
        'image': 'https://fakestoreapi.com/img/81fAn1232.jpg',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = jsonDecode(response.body);
      setState(() {
        _products.insert(
          0,
          Product(
            id: data['id'],
            title: 'New Product',
            price: 99.99,
            description: 'A new product added by me',
            category: 'electronics',
            image: 'https://fakestoreapi.com/img/81fAn1232.jpg',
            rating: Rating(rate: 0.0, count: 0),
          ),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added!')),
      );
    }
  }

  // PUT - edit product
  Future<void> _editProduct(Product product) async {
    final response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': '${product.title} (edited)',
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        int index = _products.indexWhere((p) => p.id == product.id);
        if (index != -1) {
          _products[index].title = '${product.title} (edited)';
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated!')),
      );
    }
  }

  // DELETE - delete product
  Future<void> _deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _products.removeWhere((p) => p.id == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchProducts,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: _products[index],
            onEdit: () => _editProduct(_products[index]),
            onDelete: () => _deleteProduct(_products[index].id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// StatelessWidget - just displays product info
// receives onEdit and onDelete from parent
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // product image
            Image.network(
              product.image,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.broken_image, size: 70),
            ),
            const SizedBox(width: 10),
            // product details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price}',
                    style: const TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  Text(
                    'Rating: ${product.rating.rate} (${product.rating.count})',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            // edit and delete buttons
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}