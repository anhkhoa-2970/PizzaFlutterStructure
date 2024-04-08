import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferencesHelper? _instance;
  late SharedPreferences _prefsInstance;

  SharedPreferencesHelper._();

  factory SharedPreferencesHelper() {
    _instance ??= SharedPreferencesHelper._();
    return _instance!;
  }

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
  }

  // Function to save data
  Future<void> saveData(String key, String value) async {
    await _prefsInstance.setString(key, value);
  }

  // Function to load data
  Future<String?> loadData(String key) async {
    return _prefsInstance.getString(key);
  }
}