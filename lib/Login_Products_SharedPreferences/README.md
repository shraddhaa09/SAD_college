# Login and Products App (with Shared Preferences)

## What Lab Assignments It Covers
- **Lab-9:** Login/Signup (with shared preference) + Products app

## What Files Are Inside
- `main.dart`: The brain of the app that checks device memory before launching to see if the user is already logged in.
- `products_page.dart`: The store page to view products and log out.
- `register_page.dart`: The signup screen.
- `utility.dart`: Regex validation for email and password fields.
- `configurations.dart`: Stores the hardcoded registered users list and static attendance data.
- `models/Product.dart`: Model used to display product structures.

## Topics Covered (Detailed Breakdown)
This app combines authentication and persistent storage into one complete architecture. The main concept is **Shared Preferences** — a way to permanently save small pieces of data (like login status) directly to the physical phone's storage.

* **StatelessWidget:**
    - In `main.dart`, the **`MyApp`** class is a `StatelessWidget`. It receives the `isLoggedIn` boolean read from device storage. Based on that, it either opens the Login screen or directly skips to the Products screen.

* **StatefulWidget:**
    - In `main.dart`, **`MyHomePage`** (Login Screen) is a `StatefulWidget`. It uses `TextEditingController` and `ValueListenableBuilder` to show live validation errors as the user types. On a successful login it writes `isLoggedIn = true` to `SharedPreferences` and navigates to the Products page using `Navigator.pushReplacement`.
    - In `products_page.dart`, the **`ProductsPage`** is a `StatefulWidget`. The AppBar contains a logout icon. Tapping it overwrites the saved flag back to `false` in `SharedPreferences` and pushes the user back to the login screen.

* **Asynchronous `main()` Execution:**
    - Normally `void main()` just calls `runApp()`. Here we use `void main() async` and call `WidgetsFlutterBinding.ensureInitialized()` first. This makes sure Flutter's native bridge is ready so we can safely read from the phone's storage *before* deciding which screen to launch.

* **ValueNotifier + ValueListenableBuilder:**
    - In `main.dart`, the login screen uses `ValueListenableBuilder` on the `_userID` controller instead of plain `setState()`. This is more efficient — only the email text field widget rebuilds when the user types, not the entire screen.

## Default Login Credentials
| Email | Password |
|-------|----------|
| vit1@vit.edu | Vit@1234 |
| 1321a@viit.ac.in | Vit@1321a |

## How to Run in Android Studio
1. Launch Android Studio with your phone plugged in via USB cable.
2. Click the run configurations dropdown at the top and select **Edit Configurations...**.
3. Press the `+` icon and choose **Flutter** from the list.
4. Set the **Dart entrypoint** to `lib/Login_Products_SharedPreferences/main.dart`.
5. Name the configuration `"Login SharedPrefs App"` and click **OK**.
6. Make sure your phone and the new configuration are selected, then hit the green **Play** button.

## Expected Output
- **First launch:** Login screen is shown.
- **After login:** Products page opens and login state is saved to device.
- **Close and reopen app:** Products page opens directly — no login needed.
- **Logout:** Clears saved login state and returns to login screen.