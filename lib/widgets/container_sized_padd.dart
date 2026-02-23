import 'package:flutter/material.dart';

/*
=========================================
FLUTTER NOTES – CONTAINER & SIZEDBOX
=========================================

This file covers:

1) What is Container?
2) Container properties
3) Decoration (color, borderRadius, shadow, shape)
4) Margin vs Padding
5) What is SizedBox?
6) Types / Variations of SizedBox
7) When to use Container vs SizedBox

-----------------------------------------
1) CONTAINER
-----------------------------------------
Container is a box model widget.

It is used when you want:
- height & width
- background color
- padding or margin
- decoration (border, shadow, radius)
- alignment
- child inside it

Think of it like a customizable box.
*/

class ContainerSizedNotes extends StatelessWidget {
  const ContainerSizedNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Container & SizedBox Notes"),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /*
            -----------------------------------------
            BASIC CONTAINER
            -----------------------------------------
            */

            Container(
              height: 100,
              width: 100,
              color: Colors.blue,   // Simple background color
            ),

            const SizedBox(height: 20),


            /*
            -----------------------------------------
            CONTAINER WITH DECORATION
            -----------------------------------------
            If you use decoration, do NOT use color outside.
            Put color inside BoxDecoration.
            */

            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.green,

                // Rounded corners
                borderRadius: BorderRadius.circular(20),

                // Shadow
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),


            /*
            -----------------------------------------
            CIRCULAR CONTAINER
            -----------------------------------------
            */

            Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,   // Makes it circle
              ),
            ),

            const SizedBox(height: 20),


            /*
            -----------------------------------------
            MARGIN vs PADDING
            -----------------------------------------

            margin  -> space OUTSIDE container
            padding -> space INSIDE container
            */

            Container(
              margin: const EdgeInsets.all(10),   // outside space
              padding: const EdgeInsets.all(15),  // inside space
              color: Colors.orange,
              child: const Text(
                "Margin & Padding",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 20),


            /*
            -----------------------------------------
            SIZEDBOX
            -----------------------------------------

            SizedBox is a simpler version of Container.

            It is used mainly:
            - To give fixed height & width
            - To create spacing between widgets

            It does NOT support decoration like Container.
            */

            const SizedBox(
              height: 50,
              width: 150,
              child: ColoredBox(
                color: Colors.red,
                child: Center(
                  child: Text(
                    "SizedBox",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

/*
=========================================
IMPORTANT CONTAINER PROPERTIES
=========================================

height
width
color
padding
margin
alignment
child
decoration

=========================================
IMPORTANT SIZEDBOX TYPES
=========================================

1) SizedBox(height: 20)
   -> Used for vertical spacing

2) SizedBox(width: 20)
   -> Used for horizontal spacing

3) SizedBox(height: 100, width: 100)
   -> Fixed size box

4) SizedBox.expand()
   -> Takes full available space

5) SizedBox.shrink()
   -> Takes minimum possible space

=========================================
CONTAINER vs SIZEDBOX
=========================================

Use Container when:
- You need decoration
- You need padding or margin
- You need styling

Use SizedBox when:
- You only need spacing
- You only need fixed height/width

SizedBox is lighter and cleaner for spacing.

=========================================
END OF NOTES
=========================================
*/