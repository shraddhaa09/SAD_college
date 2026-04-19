# Navigation and Routing

## What Lab Assignment It Covers
- **Lab-5:** Navigation and Routing
    - Navigating between multiple screens using Navigator
    - Passing data between screens via constructor
    - Implementing named routes with MaterialApp

## Files Inside
| File | Purpose |
|------|---------|
| `lib/Lab_5_Navigation/main.dart` | App root with named route definitions |
| `lib/Lab_5_Navigation/home_screen.dart` | Home screen with both navigation methods |
| `lib/Lab_5_Navigation/profile_screen.dart` | Receives and displays passed data |
| `lib/Lab_5_Navigation/settings_screen.dart` | Target of named route navigation |

## Concepts Used
- `Navigator.push` + `MaterialPageRoute` – direct screen navigation
- `Navigator.pushNamed` – navigation via named route string
- `Navigator.pop` – return to previous screen
- Passing data via constructor parameters
- `routes` map in `MaterialApp` – named route registration
- `initialRoute` – sets the first screen on app launch

## Navigation Flow
```
HomeScreen
├── Navigator.push  → ProfileScreen (with userName, email, role)
└── Navigator.pushNamed('/settings') → SettingsScreen
```

## How to Run in Android Studio
1. Open Android Studio with your phone connected.
2. Go to **Edit Configurations...** (top toolbar dropdown).
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Lab_5_Navigation/main.dart`.
5. Name it `"Lab 5 - Navigation"` → click **OK**.
6. Select the config + your device → hit the green **Play** button.

## Expected Output
- Home screen with two navigation buttons.
- Profile screen shows name, email, role passed from Home.
- Settings screen is reached via named route `/settings`.
- Back button on both screens returns to Home.