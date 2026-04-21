import 'package:flutter/material.dart';
import 'configurations.dart';

class Content extends StatefulWidget {
  final String userEmail;

  const Content({super.key, required this.userEmail});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {

  int get _presentCount =>//computes its value every time it is accessed instead of storing it and instead of a variable to avoid manual synchronization
      Configurations.attendance.where((a) => a['isPresent'] == true).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: Colors.indigo,
      ),

      body: Column(
        children: [

          // user info
          Container(
            width: double.infinity,
            color: Colors.indigo.shade50,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${widget.userEmail}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Present: $_presentCount / ${Configurations.attendance.length}',
                ),
              ],
            ),
          ),

          // list
          Expanded(
            child: ListView.builder(
              itemCount: Configurations.attendance.length,
              itemBuilder: (context, index) {
                return AttendanceItem(
                  index: index,
                  onToggle: () {
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// each row
class AttendanceItem extends StatefulWidget {
  final int index;
  final VoidCallback onToggle;

  const AttendanceItem({
    super.key,
    required this.index,
    required this.onToggle,
  });

  @override
  State<AttendanceItem> createState() => _AttendanceItemState();
}

class _AttendanceItemState extends State<AttendanceItem> {

  bool get isPresent =>
      Configurations.attendance[widget.index]['isPresent'];

  void toggle() {
    setState(() {
      Configurations.attendance[widget.index]['isPresent'] = !isPresent;
    });
    widget.onToggle();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        title: Text(
          Configurations.attendance[widget.index]['date'],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            GestureDetector(
              onTap: () {
                if (!isPresent) toggle();//why before toggle if isPresent is already true (already Present), tapping P again should do nothing
              },
              child: Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: isPresent ? Colors.green : Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'P',
                    style: TextStyle(
                      color: isPresent ? Colors.white : Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Absent button
            GestureDetector(
              onTap: () {
                if (isPresent) toggle();
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: !isPresent ? Colors.red : Colors.grey[300],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: !isPresent ? Colors.white : Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}