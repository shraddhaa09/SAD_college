class Configurations {
  // static list of registered users (acts as a simple database)
  static List<Map<String, String>> registeredUsers = [
    {'email': 'student@vit.edu', 'password': 'Pass@123'},
  ];

  // hardcoded attendance dates
  static List<Map<String, dynamic>> attendance = [
    {'date': '01 July 2025', 'isPresent': false},
    {'date': '02 July 2025', 'isPresent': false},
    {'date': '03 July 2025', 'isPresent': false},
    {'date': '04 July 2025', 'isPresent': false},
    {'date': '05 July 2025', 'isPresent': false},
    {'date': '07 July 2025', 'isPresent': false},
    {'date': '08 July 2025', 'isPresent': false},
    {'date': '09 July 2025', 'isPresent': false},
    {'date': '10 July 2025', 'isPresent': false},
    {'date': '11 July 2025', 'isPresent': false},
  ];
}