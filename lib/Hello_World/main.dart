import 'package:flutter/material.dart';


void main() {
  dartBasicsDemo();
  runApp(const MyApp());
}

void dartBasicsDemo() {
  String name = 'Flutter';
  int version = 3;
  double rating = 4.9;
  bool isAwesome = true;

  debugPrint('Name: $name, Version: $version, Rating: $rating, Awesome: $isAwesome');

  debugPrint('Sum: ${addNumbers(10, 5)}');

  if (isAwesome) {
    debugPrint('$name is awesome!');
  } else {
    debugPrint('$name is not awesome!');
  }

  for (int i = 1; i <= 3; i++) {
    debugPrint('Lab $i done!');
  }
}

int addNumbers(int a, int b) {
  return a + b;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HelloWorldPage(),
    );
  }
}

class HelloWorldPage extends StatelessWidget {
  const HelloWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('lab 1 - Hello World'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hello, World!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Welcome to Flutter',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}