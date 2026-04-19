# Layouts and Styling – Login Screen

## What Lab Assignment It Covers
- **Lab-3:** Layouts and Styling
    - Using layout widgets: Stack, Expanded, SizedBox
    - Styling UI elements with themes, colors, and fonts
    - Designing a basic login screen with professional appearance

## Files Inside
| File | Purpose |
|------|---------|
| `lib/Lab_3_Layouts/main.dart` | Complete login screen with layout and styling demo |

## Concepts Used
- `StatefulWidget` – manages TextEditingController and password toggle state
- `Stack` – layers gradient background and text in the header
- `LinearGradient` – multi-color gradient inside BoxDecoration
- `SingleChildScrollView` – prevents overflow on small screens
- `TextField` – styled input with prefixIcon, suffixIcon, focusedBorder
- `TextEditingController` – reads user input from TextField
- `ElevatedButton` – styled login button with custom shape and elevation
- `GestureDetector` – makes Sign Up text tappable
- `SizedBox` – fixed spacing and button height
- `ScaffoldMessenger` + `SnackBar` – user feedback messages

## How to Run in Android Studio
1. Open Android Studio with your phone connected.
2. Go to **Edit Configurations...** (top toolbar dropdown).
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Lab_3_Layouts/main.dart`.
5. Name it `"Lab 3 - Layouts"` → click **OK**.
6. Select the config + your device → hit the green **Play** button.

## Expected Output
- Gradient header with lock icon and welcome text.
- Two styled text fields (User ID + Password with show/hide toggle).
- Login button showing a green SnackBar on success.
- Sign Up link showing an indigo SnackBar on tap.