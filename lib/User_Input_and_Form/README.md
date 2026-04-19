# User Input & Forms

## What Lab Assignment It Covers
- **Lab-4:** User Input & Forms
    - Working with TextField for user input
    - Creating forms using Form and TextFormField
    - Implementing basic input validation

## Files Inside
| File | Purpose |
|------|---------|
| `lib/Lab_4_Forms/main.dart` | Complete form with validation for all fields |

## Concepts Used
- `StatefulWidget` – manages form key, controllers, and visibility state
- `Form` + `GlobalKey<FormState>` – groups fields and triggers validation
- `TextFormField` – input widget with built-in `validator` support
- `TextEditingController` – reads field values after validation passes
- `RegExp` – pattern matching for email, phone, and password rules
- `validator` function – returns error `String` or `null`
- `ElevatedButton` – primary submit action
- `OutlinedButton` – secondary reset action
- Success card – displays submitted data after valid form submission

## Validation Rules
| Field | Rules |
|-------|-------|
| Name | Not empty, min 3 characters |
| Email | Valid email format (regex) |
| Phone | Exactly 10 digits |
| Password | Min 8 chars, 1 uppercase, 1 number |

## How to Run in Android Studio
1. Open Android Studio with your phone connected.
2. Go to **Edit Configurations...** (top toolbar dropdown).
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Lab_4_Forms/main.dart`.
5. Name it `"Lab 4 - Forms"` → click **OK**.
6. Select the config + your device → hit the green **Play** button.

## Expected Output
- Form with 4 validated fields (Name, Email, Phone, Password).
- Red error messages appear instantly below invalid fields.
- On valid submit, a teal success card shows entered data.
- Reset button clears all fields and error messages.