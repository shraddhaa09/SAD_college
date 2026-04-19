import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// main app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Form",
      debugShowCheckedModeBanner: false,
      home: FormPage(),
    );
  }
}

// form page
class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  // form key
  final _formKey = GlobalKey<FormState>();

  // controllers
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();

  bool showPass = false;
  bool submitted = false;

  // submit
  void submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        submitted = true;
      });
    }
  }

  // reset
  void reset() {
    _formKey.currentState!.reset();
    name.clear();
    email.clear();
    phone.clear();
    pass.clear();

    setState(() {
      submitted = false;
      showPass = false;
    });
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              Text(
                "Register",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              // name
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter name";
                  }
                  if (value.length < 3) {
                    return "Min 3 chars";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // email
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter email";
                  }
                  if (!value.contains("@")) {
                    return "Invalid email";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // phone
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.length != 10) {
                    return "Enter 10 digit number";
                  }
                  return null;
                },
              ),

              SizedBox(height: 15),

              // password
              TextFormField(
                controller: pass,
                obscureText: !showPass,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(showPass
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return "Min 6 chars";
                  }
                  return null;
                },
              ),

              SizedBox(height: 25),

              // submit
              ElevatedButton(
                onPressed: submit,
                child: Text("Submit"),
              ),

              SizedBox(height: 10),

              // reset
              OutlinedButton(
                onPressed: reset,
                child: Text("Reset"),
              ),

              SizedBox(height: 20),

              // result
              if (submitted)
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.green[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Submitted!", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Name: ${name.text}"),
                      Text("Email: ${email.text}"),
                      Text("Phone: ${phone.text}"),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}