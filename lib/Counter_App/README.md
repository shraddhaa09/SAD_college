# Counter App – State Management Basics

## What Lab Assignment It Covers
- **Lab-1:** Setup and Hello World (initial structure)
- **Lab-6:** Counter App with State Management
    - Introduction to setState and StatefulWidget
    - Handling user interactions and updating UI
    - Building a counter app with dynamic state

## Files Inside
| File | Purpose |
|------|---------|
| `lib/Counter_App/main.dart` | Full counter app with increment, decrement, reset |

## Concepts Used
- `StatefulWidget` + `State` – manages `_counter` variable
- `setState()` – triggers UI rebuild when counter changes
- `StatelessWidget` – reusable `_CounterButton` with no internal state
- `VoidCallback` – passes button press function from parent to child
- `AnimatedContainer` – smooth color transition on counter change
- `FloatingActionButton` – primary increment action
- Getter methods – `_counterColor` and `_counterLabel` derived from state
- `IconButton` in `AppBar` – reset action in toolbar

## How to Run in Android Studio
1. Open Android Studio with your phone connected.
2. Go to **Edit Configurations...** (top toolbar dropdown).
3. Click **+** → select **Flutter**.
4. Set **Dart entrypoint** to `lib/Counter_App/main.dart`.
5. Name it `"Counter App"` → click **OK**.
6. Select the config + your device → hit the green **Play** button.

## Expected Output
- Circular display showing current counter value.
- Three buttons: Decrement (red), Reset (grey), Increment (purple).
- Circle color and label change dynamically as count increases.
- FloatingActionButton also increments the counter.
- Reset button in AppBar and on screen both reset to 0.