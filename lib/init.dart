import 'package:app_project/models/Assignment.dart';
import 'package:app_project/models/User.dart';
import 'package:app_project/pages/AssignmentPage.dart';
import 'package:app_project/utils/canvas/fetchAssignments.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

class Init {
  static Database? db;
  static StoreRef store = StoreRef.main();

  static Future initialize() async {
    print('Initializing...');

    try {
      final documentsDirectory = await getApplicationDocumentsDirectory();

      final dbPath = "${documentsDirectory.path}/database.db";

      db = await databaseFactoryIo.openDatabase(dbPath);

      // order matters here
      final storedData = await _loadStoredData();
      final assignments = await _loadAssignments();

      userSettings.setFontSize(storedData?['settings']?['fontSize'] ?? 20);

      print('Initialized');
      return [storedData, assignments];
    } catch (e) {
      print(e);
    }
  }

  static Future<Map<String, dynamic>?> _loadStoredData() async {
    // Load data from database
    try {
      User.fromDb(await store.record('user').get(db!));

      final assignments = await store.record('assignments').get(db!);
      final settings = await store.record('settings').get(db!);

      return {'assignments': assignments, 'settings': settings};
    } catch (e) {
      print(e);
    }

    return null;
  }

  static Future<dynamic> _loadAssignments() async {
    // Load assignments from database and canvas
    if (User.accessToken.length != 69) {
      return;
    }

    return await fetchAssignments();
  }

  static Future<void> saveAssignments(List<Assignment> assignments) async {
    await store.record('assignments').put(db!, Assignments.toDb(assignments));
  }

  static Future<void> saveSettings(Map<String, dynamic> settings) async {
    await store.record('settings').put(db!, settings);
  }

  static Future<void> saveUser() async {
    await store.record('user').put(db!, User.toDb());
  }
}
