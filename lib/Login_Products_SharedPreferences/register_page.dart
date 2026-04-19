import 'package:flutter/material.dart';
import 'utility.dart';
import 'configurations.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _useridcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _userIdErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;

  void checkUniqueUserId() {
    setState(() {
      String userId = _useridcontroller.text;
      if (userId.isEmpty) {
        _userIdErrorText = 'Please enter an email ID';
      } else if (!Utility.validateEmail(userId)) {
        _userIdErrorText = 'Please enter a valid email ID';
      } else {
        bool exists = Configurations.credentials.any((cred) => cred['userid'] == userId);
        if (exists) {
          _userIdErrorText = 'User ID already exists';
        } else {
          _userIdErrorText = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User ID is available!'), duration: Duration(seconds: 2)),
          );
        }
      }
    });
  }

  void validate() {
    setState(() {
      // 1. Validate User ID
      String userId = _useridcontroller.text;
      if (userId.isEmpty) {
        _userIdErrorText = 'Please enter an email ID';
      } else if (!Utility.validateEmail(userId)) {
        _userIdErrorText = 'Please enter a valid email ID';
      } else if (Configurations.credentials.any((cred) => cred['userid'] == userId)) {
        _userIdErrorText = 'User ID already exists';
      } else {
        _userIdErrorText = null;
      }

      // 2. Validate Password
      String password = _passwordcontroller.text;
      if (password.isEmpty) {
        _passwordErrorText = 'Please enter a password';
      } else if (!Utility.isPasswordStrong(password)) {
        _passwordErrorText = 'Password must be 8+ chars, with upper, lower, digit, and symbol';
      } else {
        _passwordErrorText = null;
      }

      // 3. Validate Confirm Password
      if (_confirmPasswordController.text != password) {
        _confirmPasswordErrorText = 'Passwords do not match';
      } else {
        _confirmPasswordErrorText = null;
      }
    });

    // If no errors, add to configuration and pop back to login
    if (_userIdErrorText == null && _passwordErrorText == null && _confirmPasswordErrorText == null) {
      Configurations.credentials.add({
        'userid': _useridcontroller.text,
        'password': _passwordcontroller.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Register'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _useridcontroller,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: checkUniqueUserId,
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text('Check', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  labelText: 'User ID',
                  errorText: _userIdErrorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _passwordErrorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  errorText: _confirmPasswordErrorText,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            ElevatedButton(onPressed: validate, child: const Text('Register'))
          ],
        ),
      ),
    );
  }
}