import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Root> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // --- REUSABLE CONFIRMATION DIALOG ---
  Future<bool> _showConfirmationDialog(String title, String content, Color confirmColor) async {
    // We use await showDialog and expect a bool to be returned when Navigator.pop is called
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Forces user to click a button
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: TextStyle(color: confirmColor, fontWeight: FontWeight.bold)),
          content: Text(content, style: const TextStyle(fontSize: 16)),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Return false on Cancel
              child: const Text('Cancel', style: TextStyle(color: Colors.grey, fontSize: 16)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: confirmColor),
              onPressed: () => Navigator.pop(context, true), // Return true on Confirm
              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    // If the dialog is dismissed by other means, default to false
    return result ?? false;
  }

  // --- READ ---
  Future<void> _fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        setState(() {
          _products = jsonList.map((json) => Root.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error fetching products: $e');
    }
  }

  // --- CREATE & UPDATE FORM DIALOG ---
  Future<void> _showFormDialog({Root? existingProduct}) async {
    final isEditing = existingProduct != null;

    // Core Product Controllers
    final titleController = TextEditingController(text: existingProduct?.title ?? '');
    final priceController = TextEditingController(text: existingProduct?.price?.toString() ?? '');
    final descController = TextEditingController(text: existingProduct?.description ?? '');
    final categoryController = TextEditingController(text: existingProduct?.category ?? '');
    final imageController = TextEditingController(text: existingProduct?.image ?? '');

    // 1. Rating Controllers
    final rateController = TextEditingController(text: existingProduct?.rating?.rate?.toString() ?? '');
    final countController = TextEditingController(text: existingProduct?.rating?.count?.toString() ?? '');

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Product' : 'Add Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
                TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Price (\$)'), keyboardType: TextInputType.number),
                TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
                TextField(controller: imageController, decoration: const InputDecoration(labelText: 'Image URL')),

                // 2. Put Rate and Count side-by-side to save vertical space
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: rateController,
                          decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                          keyboardType: const TextInputType.numberWithOptions(decimal: true)
                      ),
                    ),
                    const SizedBox(width: 16), // Spacing between the two fields
                    Expanded(
                      child: TextField(
                          controller: countController,
                          decoration: const InputDecoration(labelText: 'Review Count'),
                          keyboardType: TextInputType.number
                      ),
                    ),
                  ],
                ),

                TextField(controller: descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 3),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                final newProduct = Root(
                  id: isEditing ? existingProduct.id : DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  description: descController.text,
                  category: categoryController.text,
                  image: imageController.text.isNotEmpty
                      ? imageController.text
                      : 'https://via.placeholder.com/150',
                  // 3. Create a new Rating object from the text fields
                  rating: Rating(
                    rate: double.tryParse(rateController.text) ?? 0.0,
                    count: int.tryParse(countController.text) ?? 0,
                  ),
                );

                if (isEditing) {
                  Navigator.pop(context);
                  _updateProduct(newProduct);
                } else {
                  bool confirm = await _showConfirmationDialog(
                    'Confirm Creation',
                    'Are you sure you want to add "${newProduct.title}" to the store?',
                    Colors.green,
                  );

                  if (confirm && context.mounted) {
                    Navigator.pop(context);
                    _createProduct(newProduct);
                  }
                }
              },
              child: Text(isEditing ? 'Update' : 'Create'),
            ),
          ],
        );
      },
    );
  }

  // --- CREATE (POST) ---
  Future<void> _createProduct(Root product) async {
    try {
      final response = await http.post(
        Uri.parse('https://fakestoreapi.com/products'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() => _products.insert(0, product));
        _showSnackBar('Product Created Successfully!');
      }
    } catch (e) {
      _showSnackBar('Failed to create product.');
    }
  }

  // --- UPDATE (PUT) ---
  Future<void> _updateProduct(Root product) async {
    try {
      final response = await http.put(
        Uri.parse('https://fakestoreapi.com/products/${product.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode == 200) {
        setState(() {
          int index = _products.indexWhere((p) => p.id == product.id);
          if (index != -1) _products[index] = product;
        });
        _showSnackBar('Product Updated Successfully!');
      }
    } catch (e) {
      _showSnackBar('Failed to update product.');
    }
  }

  // --- DELETE (DELETE) ---
  Future<void> _deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('https://fakestoreapi.com/products/$id'));

      if (response.statusCode == 200) {
        setState(() => _products.removeWhere((p) => p.id == id));
        _showSnackBar('Product Deleted Successfully!');
      }
    } catch (e) {
      _showSnackBar('Failed to delete product.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Products'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // LOGOUT BUTTON
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log out',
            onPressed: () async {
              // 1. Access SharedPreferences
              final prefs = await SharedPreferences.getInstance();
              // 2. Clear the login state (or clear everything with prefs.clear())
              await prefs.setBool('isLoggedIn', false);

              if (context.mounted) {
                // 3. Kick user back to the Login Page
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Login'))
                );
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: _products[index],
            onEdit: () => _showFormDialog(existingProduct: _products[index]),
            onDelete: () async {
              // Wait for user confirmation before deleting
              bool confirm = await _showConfirmationDialog(
                'Confirm Deletion',
                'Are you sure you want to delete "${_products[index].title}"? This cannot be undone.',
                Colors.red,
              );
              if (confirm) {
                _deleteProduct(_products[index].id!);
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Reusable Card Widget (Remains Unchanged)
class ProductCard extends StatelessWidget {
  final Root product;
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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Top Row (Image + Title + Price)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      product.image ?? '',
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported, size: 60),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title ?? 'No Title',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          const SizedBox(height: 6),

                          Text(
                            product.category?.toUpperCase() ?? '',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🔥 Price (top-right)
                    Text(
                      '\$${product.price ?? 0.0}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // 🔹 Rating
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating?.rate ?? 0.0} (${product.rating?.count ?? 0})',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // 🔹 Description
                Text(
                  product.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ),

          // 🔴 Floating Edit/Delete buttons (top-right)
          Positioned(
            top: 0,
            right: 0,
            child: Row(
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
          ),
        ],
      ),
    );
  }
}