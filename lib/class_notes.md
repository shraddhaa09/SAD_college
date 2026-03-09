3-9-2026
ATTENDANCE APP LOGIC

Data Layer
Configurations.attendance stores the attendance list.

Structure:
[
["02-02-2026", 1],
["09-02-2026", 0]
]

0 → Date
1 → Attendance Status

1 = Present
0 = Absent


Main Logic
toggleAttendance(index)

Purpose:
Change attendance value when user taps the circle.

Logic:
if value == 1
change to 0
else
change to 1


State Management
setState()

Purpose:
Tell Flutter to rebuild UI when data changes.


Event Trigger
GestureDetector → onTap()

User taps circle → toggleAttendance() called


UI Mapping
bool pamarker = Configurations.attendance[index][1] == 1;

1 → true → P → green
0 → false → A → red