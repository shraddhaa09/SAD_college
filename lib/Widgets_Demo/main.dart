import 'package:flutter/material.dart';

// Entry point
void main() {
  runApp(MyApp());
}

// Main App
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Lab 2 Demo",
      debugShowCheckedModeBanner: false,
      home: WidgetsDemoPage(),
    );
  }
}

// Main Page
class WidgetsDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab 2 - Widgets Demo"),
        backgroundColor: Colors.indigo,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // 1. Text
            Text("1. Text Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Hello from Text Widget!", style: TextStyle(color: Colors.indigo)),

            SizedBox(height: 20),

            // 2. Container
            Text("2. Container Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              height: 80,
              color: Colors.indigo,
              child: Center(
                child: Text(
                  "I am a Container",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 20),

            // 3. Row
            Text("3. Row Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                box(Colors.red, "Red"),
                box(Colors.green, "Green"),
                box(Colors.blue, "Blue"),
              ],
            ),

            SizedBox(height: 20),

            // 4. Column
            Text("4. Column Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              children: [
                box(Colors.orange, "Orange"),
                SizedBox(height: 10),
                box(Colors.purple, "Purple"),
                SizedBox(height: 10),
                box(Colors.teal, "Teal"),
              ],
            ),

            SizedBox(height: 20),

            // 5. SizedBox
            Text("5. SizedBox Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(height: 2, color: Colors.black),
            SizedBox(height: 15),
            Container(height: 2, color: Colors.black),
            Text("SizedBox used for spacing"),

            SizedBox(height: 20),

            // 6. ListView
            Text("6. ListView Widget", style: TextStyle(fontWeight: FontWeight.bold)),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Item 1"),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Item 2"),
                ),
                ListTile(
                  leading: Icon(Icons.star),
                  title: Text("Item 3"),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  // simple reusable box function
  Widget box(Color color, String text) {
    return Container(
      width: 70,
      height: 50,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}