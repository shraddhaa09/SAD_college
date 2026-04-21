// import 'package:flutter/material.dart';
// import '../models/product_model.dart';
// import '../services/api_service.dart';
//
// class ProductView extends StatefulWidget {
//   @override
//   State<ProductView> createState() => _ProductViewState();
// }
//
// class _ProductViewState extends State<ProductView> {
//
//   late Future<List<Product>> products;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // API call happens ONLY once here
//     products = ApiService().fetchProducts();
//   }
//
//   // Function to refresh data
//   void refreshData() {
//     setState(() {
//       products = ApiService().fetchProducts();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Products"),
//       ),
//
//       body: FutureBuilder<List<Product>>(
//         future: products,
//         builder: (context, snapshot) {
//
//           // Loading state
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           // Error state
//           if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           }
//
//           // Success state
//           if (snapshot.hasData) {
//
//             List<Product> productList = snapshot.data!;
//
//             return ListView.builder(
//               itemCount: productList.length,
//               itemBuilder: (context, index) {
//
//                 final product = productList[index];
//
//                 return Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Card(
//                     elevation: 5,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//
//                         // Image
//                         SizedBox(
//                           height: 180,
//                           width: double.infinity,
//                           child: Image.network(
//                             product.image,
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//
//                         // Title + Rating
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//
//                               Expanded(
//                                 child: Text(
//                                   product.title,
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//
//                               Text(
//                                 "⭐ ${product.rating.rate}",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         // Description
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Text(
//                             product.description,
//                             textAlign: TextAlign.justify,
//                           ),
//                         ),
//
//                         // Category + Price + Buttons
//                         Padding(
//                           padding: const EdgeInsets.all(10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//
//                               Text(product.category),
//
//                               Row(
//                                 children: [
//
//                                   // UPDATE button
//                                   IconButton(
//                                     onPressed: () async {
//                                       await ApiService().updateProduct(product.id);
//                                       refreshData();
//                                     },
//                                     icon: Icon(Icons.edit, color: Colors.blue),
//                                   ),
//
//                                   // DELETE button
//                                   IconButton(
//                                     onPressed: () async {
//                                       await ApiService().deleteProduct(product.id);
//                                       refreshData();
//                                     },
//                                     icon: Icon(Icons.delete, color: Colors.red),
//                                   ),
//                                 ],
//                               ),
//
//                               Text(
//                                 "\$${product.price}",
//                                 style: TextStyle(
//                                   color: Colors.green,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//
//           return Center(child: Text("No data available"));
//         },
//       ),
//
//       // ADD button (POST)
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await ApiService().addProduct();
//           refreshData();
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }