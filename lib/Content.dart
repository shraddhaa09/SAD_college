import 'package:flutter/material.dart';
import 'package:my_first_project/configurations.dart';


class Content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ContentState();
  }
}


class ContentState extends State<Content> {

  void toggleAttendance(int index) {
    setState(() {
      if (Configurations.attendance[index][1] == 1) {
        Configurations.attendance[index][1] = 0;
      } else {
        Configurations.attendance[index][1] = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Content"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: Configurations.attendance.length,
          itemBuilder: (context, index) {

            String date = Configurations.attendance[index][0];
            bool pamarker = Configurations.attendance[index][1] == 1;

            return Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Text(date, style: TextStyle(fontSize: 20)),

                  GestureDetector(
                    onTap: () {
                      toggleAttendance(index);
                    },

                    child: CircleAvatar(
                      backgroundColor:
                      pamarker ? Colors.green : Colors.red,

                      child: Text(
                        pamarker ? "P" : "A",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

