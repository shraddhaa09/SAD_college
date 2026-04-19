# Flutter Widgets & Project Structure

## What Lab Assignment It Covers
- **Lab-2:** Flutter Project Structure & Widgets
    - Exploring project folders and key files (`pubspec.yaml`, `main.dart`)
    - Understanding Stateless and Stateful widgets
    - Building a basic UI with common widgets

## Files Inside
| File | Purpose |
|------|---------|
| `lib/Widgets_Demo/main.dart` | Entry point + all widget demos |

## Concepts Used
- `StatelessWidget` – UI that never changes; no setState needed
- `MaterialApp` + `Scaffold` – App root and page structure
- `Text` – Display styled text
- `Container` – Box model widget with padding, color, border radius, shadow
- `Row` – Horizontal layout with `mainAxisAlignment`
- `Column` – Vertical layout with `crossAxisAlignment`
- `SizedBox` – Fixed spacing and sizing
- `ListView` – Scrollable list with `shrinkWrap` inside Column
- `SingleChildScrollView` – Prevents screen overflow
- Reusable custom widgets (`SectionTitle`, `ColorBox`)

## How to Run in Android Studio
1. Open Android Studio with your phone connected.
2. Go to **Edit Configurations...** (top toolbar dropdown).
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Widgets_Demo/main.dart`.
5. Name it `"Widgets Demo"` → click **OK**.
6. Select the config + your device → hit the green **Play** button.

## Expected Output
- Scrollable page demonstrating Text, Container, Row, Column, SizedBox, and ListView widgets with labels.