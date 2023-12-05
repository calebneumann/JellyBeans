import 'package:app_project/models/Assignment.dart';
import 'package:app_project/models/User.dart';
import 'package:app_project/models/UserSettings.dart';
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

      print('Initialized');
      return [storedData, assignments];
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> _loadStoredData() async {
    // Load data from database
    try {
      User.fromDb(await store.record('user').get(db!));
      return await store.record('assignments').get(db!);
    } catch (e) {
      print(e);
    }
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

  static Future<void> saveSettings(UserSettings settings) async {
    await store.record('settings').put(db!, settings.toDb());
  }

  static Future<void> saveUser() async {
    await store.record('user').put(db!, User.toDb());
  }
}
