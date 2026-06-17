import 'package:shared_preferences/shared_preferences.dart';

class CustomSharedPreferences {
  static SharedPreferences? _prefs;


  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance {
    if(_prefs == null) {
      throw Exception('CustomSharedPrefs not initialized, call init() first.');
    }
    return _prefs!;
  }
}