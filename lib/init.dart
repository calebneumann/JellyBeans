class Init {
  static Future initialize() async {
    await _loadSettings();
    await _loadAssignments();
  }

  static _loadAssignments() async {
    // Load assignments from database and canvas
  }

  static _loadSettings() async {
    // Load settings from database
  }
}
