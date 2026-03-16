import 'package:flutter/material.dart';


class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}
class RegisterPageState extends State<RegisterPage>{




  void validate(){
    //validate the page


    // credentials.add({'userid':useridcontroller.text, 'password':passwordcontroller.text});


    // Navigator.pop();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text('Register'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: (){
                      //check for Unique User ID by iterating through Configurations.credentials
                    },
                    child: Text('Check'),
                  ),
                  labelText: 'User ID',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            TextField(),
            TextField(),
            ElevatedButton(onPressed: validate, child: Text('Register'))
          ],
        ),
      ),
    );
  }


}
