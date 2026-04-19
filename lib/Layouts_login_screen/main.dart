import 'package:flutter/material.dart';

// main function - starting point of app
void main() {
  runApp(MyApp());
}

// main app widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      home: LayoutPage(),
    );
  }
}

// using Stateful because we need to handle input + button click
class LayoutPage extends StatefulWidget {
  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {

  // controllers for text fields
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool showPassword = false;

  // login button function
  void login() {
    String user = userController.text;
    String pass = passController.text;

    if (user.isEmpty || pass.isEmpty) {
      showMsg("Fill all fields", Colors.red);
    } else {
      showMsg("Welcome " + user, Colors.green);
    }
  }

  // function to show snackbar
  void showMsg(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: color,
      ),
    );
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            // top design
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo, Colors.blue],
                    ),
                  ),
                ),

                Container(
                  height: 220,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.white, size: 50),
                      SizedBox(height: 10),
                      Text("Welcome Back",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [

                  SizedBox(height: 10),

                  // user field
                  TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      labelText: "User ID",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 20),

                  // password field
                  TextField(
                    controller: passController,
                    obscureText: !showPassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(showPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(height: 30),

                  // login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: login,
                      child: Text("Login"),
                    ),
                  ),

                  SizedBox(height: 20),

                  // signup text
                  GestureDetector(
                    onTap: () {
                      showMsg("Go to signup page", Colors.blue);
                    },
                    child: Text(
                      "Don't have account? Sign Up",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}