import 'package:flutter/material.dart';
import 'configurations.dart';
import 'utility.dart';

class RegisterPage extends StatefulWidget {//_emailError and _passwordError change
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String emailError = '';
  String passwordError = '';
  String confirmError = '';

  void register() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirm = _confirmController.text.trim();

    emailError = '';
    passwordError = '';
    confirmError = '';

    if (!Utility.isValidEmail(email)) {
      emailError = "Invalid email";
    }

    else if (Configurations.registeredUsers
        .any((user) => user['email'] == email)) {
      emailError = "Email already exists";
    }

    else if (!Utility.isValidPassword(password)) {
      passwordError = "Weak password";
    }

    else if (password != confirm) {
      confirmError = "Passwords not match";
    }

    else {
      Configurations.registeredUsers.add({
        'email': email,
        'password': password
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registered successfully"),
        ),
      );

      Navigator.pop(context);
    }

    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: Colors.indigo,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                errorText: emailError.isEmpty ? null : emailError,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                errorText: passwordError.isEmpty ? null : passwordError,
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                errorText: confirmError.isEmpty ? null : confirmError,
              ),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: register,
              child: const Text("Register"),
            ),
          ],
        ),
      ),
    );
  }
}