import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'products_page.dart';
import 'register_page.dart';
import 'utility.dart';

void main() async {
  // 1. We must ensure Flutter is initialized before interacting with native device storage
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Fetch the SharedPreferences instance
  final prefs = await SharedPreferences.getInstance();

  // 3. Read the 'isLoggedIn' flag. If it doesn't exist yet, default to false.
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  // Pass the flag into our app
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store App',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      // 4. If logged in, skip to ProductsPage. Otherwise, show Login.
      home: isLoggedIn ? const ProductsPage() : const MyHomePage(title: 'Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _userID = TextEditingController(), _password = TextEditingController();
  String? _userIDErrorText, _passwordErrorText;

  void validate() async {
    setState(() {
      _userIDErrorText = _setUserIDErrorText(_userID.text);
      _passwordErrorText = _setPasswordErrorText(_password.text);
    });

    if (_userIDErrorText == null && _passwordErrorText == null) {
      bool isAuthorized = Utility.validateCredentials(
          userId: _userID.text,
          password: _password.text
      );

      if (isAuthorized) {
        // --- NEW SHARED PREFS LOGIC ---
        // Save the login state to device memory
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Optionally save the UserID if you want to display it on the profile later
        await prefs.setString('loggedInUser', _userID.text);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Successful!'), backgroundColor: Colors.green),
          );
          // Navigate to ProductsPage and remove the Login page from the backstack
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProductsPage())
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid User ID or Password'), backgroundColor: Colors.red),
        );
      }
    }
  }

  String? _setUserIDErrorText(String value) {
    if (value.isEmpty) return 'Please enter email ID';
    if (!Utility.validateEmail(value)) return 'Please enter valid email ID';
    return null;
  }

  String? _setPasswordErrorText(String value) {
    if (value.isEmpty) return 'Please enter Password';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _userID,
                  builder: (context, value, child) {
                    _userIDErrorText = _setUserIDErrorText(value.text);
                    return TextField(
                      controller: _userID,
                      decoration: InputDecoration(
                        labelText: 'User ID',
                        errorText: _userIDErrorText,
                        hintText: 'dhiraj.jadhav@vit.edu',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    );
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            ElevatedButton(onPressed: validate, child: const Text('Login')),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
            }, child: const Text('Sign Up')),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userID.dispose();
    _password.dispose();
    super.dispose();
  }
}