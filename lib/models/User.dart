import 'package:app_project/init.dart';

class User {
  static String accessToken = '';

  static void setAccessToken(String? newAccessToken) {
    accessToken = newAccessToken ?? '';
    Init.saveUser();
  }

  static Map<String, dynamic> toDb() {
    return {
      'accessToken': accessToken,
    };
  }

  static void fromDb(dynamic db) {
    return setAccessToken(db?['accessToken']);
  }
}
