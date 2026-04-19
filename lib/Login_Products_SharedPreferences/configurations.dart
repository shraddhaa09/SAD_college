class Configurations {
  static List<Map<String, String>> credentials = [
    {'userid': 'vit1@vit.edu', 'password': 'Vit@1234'},
    {'userid': '1321a@viit.ac.in', 'password': 'Vit@1321a'}
  ];

  // Hardcoded attendance list that resets on app restart
  static List<List<dynamic>> attendance = [
    ["02-02-2026", 1], // 1 = Present
    ["09-02-2026", 0], // 0 = Absent
    ["16-02-2026", 0],
    ["23-02-2026", 1],
    ["01-03-2026", 0],
    ["02-03-2026", 1],
    ["09-03-2026", 0],
    ["16-03-2026", 1],
    ["23-03-2026", 1],
  ];
}