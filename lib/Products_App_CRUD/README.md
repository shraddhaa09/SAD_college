# Products App (FakeStore API + CRUD)

## What Lab Assignments It Covers
- **Lab-7:** Products app – Lists and Dynamic Content
- **Lab-8:** Products app using fakestoreapi – Fetching Data from APIs

## What Files Are Inside
- `main.dart`: Entry point, launches directly into ProductsPage.
- `products_page.dart`: All the logic – fetching, displaying, adding, editing, deleting products.
- `models/Product.dart`: Product and Rating model classes with fromJson() for JSON parsing.

## Topics Covered
- `ListView.builder` – displays dynamic list of products efficiently
- `http` package – makes GET, POST, PUT, DELETE requests
- `jsonDecode` – parses API response string into Dart objects
- `Product.fromJson()` – converts JSON map to typed Product object
- `initState()` – fetches data automatically when screen loads
- `_isLoading` boolean – shows spinner while data is being fetched
- `StatefulWidget` – manages products list and loading state
- `StatelessWidget` (ProductCard) – displays individual product info

## How to Run in Android Studio
1. Open Android Studio and connect your phone.
2. Click **Edit Configurations...** in the top toolbar dropdown.
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Products_App_CRUD/main.dart`.
5. Name it `"Products CRUD"` → click **OK**.
6. Select config + device → hit the green **Play** button.

## Expected Output
- List of 20 products loaded from fakestoreapi.
- Each card shows image, title, price, and rating.
- FAB (+ button) adds a new product to the top of the list.
- Edit icon updates the product title.
- Delete icon removes the product from the list.