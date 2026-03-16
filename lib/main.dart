import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Fake Store Products"),
      ),

      body: FutureBuilder<List<Product>>(

        future: products,

        builder: (context, snapshot) {

          if (snapshot.hasData) {

            return ListView.builder(

              itemCount: snapshot.data!.length,

              itemBuilder: (context, index) {

                Product product = snapshot.data![index];

                return Card(
                  margin: EdgeInsets.all(10),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Image.network(product.image, height: 150),

                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          product.title,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(product.description),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                            "Category: ${product.category}"
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Price: \$${product.price}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );

          }

          else if (snapshot.hasError) {
            return Center(child: Text("Error loading data"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}