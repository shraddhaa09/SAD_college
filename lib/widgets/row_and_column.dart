import 'package:flutter/material.dart';

/*
==========================================================
FLUTTER NOTES – ROW, COLUMN & WRAP
==========================================================

This file demonstrates:

1) MediaQuery (screen size)
2) Column (vertical layout)
3) Row (horizontal layout)
4) MainAxisAlignment
5) CrossAxisAlignment
6) Wrap (auto next line behavior)

==========================================================
*/

class RowsCols extends StatelessWidget {
  const RowsCols({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Getting screen width & height using MediaQuery
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rows and Columns'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /*
            ==================================================
            COLUMN EXAMPLE
            ==================================================
            Column arranges widgets vertically.
            Main Axis -> Vertical
            Cross Axis -> Horizontal
            */

            Container(
              height: 250,
              width: w,
              color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 10),
                  ColoredBox(color: Colors.red, child: SizedBox(height: 60, width: 60)),
                  SizedBox(height: 10),
                  ColoredBox(color: Colors.blue, child: SizedBox(height: 60, width: 60)),
                  SizedBox(height: 10),
                  ColoredBox(color: Colors.green, child: SizedBox(height: 60, width: 60)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /*
            ==================================================
            ROW EXAMPLE
            ==================================================
            Row arranges widgets horizontally.
            Main Axis -> Horizontal
            Cross Axis -> Vertical
            */

            Container(
              height: 120,
              width: w,
              color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  ColoredBox(color: Colors.red, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.blue, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.green, child: SizedBox(height: 60, width: 60)),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /*
            ==================================================
            WRAP EXAMPLE
            ==================================================
            Wrap moves widgets to next line if overflow occurs.
            Useful when content is dynamic.
            */

            Container(
              width: w,
              color: Colors.grey.shade300,
              padding: const EdgeInsets.all(10),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 10,     // space between items horizontally
                runSpacing: 10,  // space between lines vertically
                children: const [
                  ColoredBox(color: Colors.purple, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.black, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.teal, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.pink, child: SizedBox(height: 60, width: 60)),
                  ColoredBox(color: Colors.indigo, child: SizedBox(height: 60, width: 60)),
                ],
              ),
            ),

            const SizedBox(height: 30),

          ],
        ),
      ),
    );
  }
}

/*
==========================================================
IMPORTANT REVISION POINTS
==========================================================

ROW:
- Main Axis -> Horizontal
- Cross Axis -> Vertical

COLUMN:
- Main Axis -> Vertical
- Cross Axis -> Horizontal

WRAP:
- Automatically moves widgets to next line
- Has spacing & runSpacing
- Prevents overflow error

MEDIAQUERY:
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height

Used for responsive UI.

==========================================================
END OF FILE
==========================================================
*/