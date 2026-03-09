import 'package:flutter/material.dart';

// This widget represents a screen that contains two buttons
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});   // Constructor

  @override
  Widget build(BuildContext context) {

    // Scaffold creates the basic visual structure of a page
    return Scaffold(

      // Top bar of the application
      appBar: AppBar(
        title: const Text('Button'),
      ),

      // Body contains the main UI elements
      body: Center(

        // Column places widgets vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            // -------- FIRST BUTTON --------
            TextButton(

              // Styling properties of the button
              style: ButtonStyle(

                // Adds space inside the button so it looks larger
                padding: WidgetStateProperty.all(
                  const EdgeInsets.all(30),
                ),

                // When the user taps the button, a dark overlay appears
                // This provides visual feedback that the button is pressed
                overlayColor: WidgetStateProperty.all(Colors.black),

                // Adds shadow depth to the button
                elevation: WidgetStateProperty.all(20),

                // Sets the button background color
                backgroundColor: WidgetStateProperty.all(Colors.yellow),
              ),

              // Text that appears inside the button
              child: const Text(
                'Press me',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              // Code executed when the button is clicked
              onPressed: () {
                // Currently nothing happens
              },
            ),

            // Adds space between the two buttons
            const SizedBox(height: 20),

            // Container controls the size of the second button
            Container(
              height: 50,
              width: 300,

              child: ElevatedButton(

                // Styling for the elevated button
                style: ButtonStyle(

                  // Uses the primary color defined in the app theme
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),

                  // Gives the button rounded corners
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),

                // Action performed when button is pressed
                onPressed: () {

                  // Prints "Like" in the debug console
                  print("Like");
                },

                // Text shown inside the button
                child: const Text(
                  "Press me",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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