# Flutter Lab Assignment: Fake Store API Integration

## Objective

Build a Flutter application that fetches product data from an external
API, converts JSON responses into Dart model objects, and displays the
product details in a scrollable UI.

------------------------------------------------------------------------

## Tools and Technologies

-   Flutter
-   Dart
-   HTTP package
-   FakeStore API
-   Quicktype (JSON to Model Converter)

------------------------------------------------------------------------

## Workflow Overview

Application flow:

User Interface\
↓\
API Request\
↓\
JSON Response\
↓\
Convert JSON → Model Object\
↓\
Display Data in ListView

------------------------------------------------------------------------

## Step 1: Create Flutter Project

``` bash
flutter create fakestore_app
cd fakestore_app
```

The Flutter project contains the main application code inside the
**lib** folder.

------------------------------------------------------------------------

## Step 2: Add HTTP Package

Open `pubspec.yaml` and add:

``` yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.0
```

Run:

``` bash
flutter pub get
```

The HTTP package allows the application to send network requests and
receive responses.

------------------------------------------------------------------------

## Step 3: Understanding the API

API Endpoint:

    https://fakestoreapi.com/products

Example JSON response:

``` json
{
 "id": 1,
 "title": "Fjallraven Backpack",
 "price": 109.95,
 "description": "Your perfect pack for everyday use",
 "category": "men's clothing",
 "image": "https://image-url"
}
```

Returned product fields:

-   id
-   title
-   description
-   category
-   price
-   image

------------------------------------------------------------------------

## Step 4: Convert JSON to Model

Using Quicktype, the JSON structure is converted into a Dart model
class.

Create file:

    lib/models/product_model.dart

Example:

``` dart
class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      price: json["price"].toDouble(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
    );
  }
}
```

Model classes convert JSON data into structured Dart objects.

------------------------------------------------------------------------

## Step 5: API Service

Create file:

    lib/services/api_service.dart

Example code:

``` dart
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
```

The service fetches API data and converts it into a list of Product
objects.

------------------------------------------------------------------------

## Step 6: UI Layout

Each product is displayed using a **Card** containing a **Column**
layout.

Layout structure:

    Card
     └ Column
        ├ Image
        ├ Title
        ├ Description
        ├ Category
        └ Price

Example UI:

``` dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Image.network(product.image),
    Text(product.title),
    Text(product.description),
    Text("Category: ${product.category}"),
    Text("Price: $${product.price}")
  ],
)
```

------------------------------------------------------------------------

## Step 7: Display Products using ListView.builder

``` dart
ListView.builder(
  itemCount: products.length,
  itemBuilder: (context, index) {

    Product product = products[index];

    return Card(
      child: Column(
        children: [
          Image.network(product.image),
          Text(product.title),
          Text(product.description),
          Text(product.category),
          Text("$${product.price}")
        ],
      ),
    );
  },
)
```

`ListView.builder` dynamically generates list items and improves
performance for large lists.

------------------------------------------------------------------------

## Step 8: FutureBuilder

Since API calls are asynchronous, `FutureBuilder` is used to handle data
loading.

``` dart
FutureBuilder<List<Product>>(
  future: products,
  builder: (context, snapshot) {

    if (snapshot.hasData) {
      return ListView.builder(...);
    }

    if (snapshot.hasError) {
      return Text("Error loading data");
    }

    return CircularProgressIndicator();
  },
)
```

FutureBuilder handles:

-   Loading state
-   Success state
-   Error state

------------------------------------------------------------------------

## Folder Structure

    lib
     ├ models
     │   product_model.dart
     │
     ├ services
     │   api_service.dart
     │
     └ main.dart

------------------------------------------------------------------------

## Concepts Learned

-   API integration in Flutter
-   JSON parsing
-   Model class creation
-   HTTP requests
-   Asynchronous programming
-   Future and FutureBuilder
-   Dynamic UI using ListView.builder

------------------------------------------------------------------------

## Conclusion

This assignment demonstrates how Flutter applications interact with
external APIs.\
The app retrieves product data, converts JSON responses into Dart model
objects, and dynamically displays them in a scrollable interface.
