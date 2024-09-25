import 'package:findy/constant/share_preference_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

const noLogin = 'NoLogin';
const firstApp = 'firstApp';

enum FIRSTAPP { none, firstApp, other }

extension EnumExFIRSTAPP on String {
  FIRSTAPP toEnumFirstApp() {
    FIRSTAPP type = FIRSTAPP.none;
    for (FIRSTAPP value in FIRSTAPP.values) {
      if (value.name.toString() == this) {
        type = value;
      }
    }
    return type;
  }
}

class AppPreferencesKey {
  static const String menuDefaultHrm = "menuDefaultHrm";
  static const String menuDefaultIOffice = "menuDefaultIOffice";
  static const String entryAppOffice = "menuDefaultIOffice";
}

// singleton class
// // How to use:
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppPreferencesUtil.init();
//   runApp(MyApp());
// }
class AppPreferencesUtil {
  static final AppPreferencesUtil _instance = AppPreferencesUtil._internal();
  static SharedPreferences? prefs;
  // ignore: prefer_const_constructors
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // Private constructor
  AppPreferencesUtil._internal();

  // Factory constructor returns the same instance
  factory AppPreferencesUtil() {
    return _instance;
  }
  static Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  // FlutterSecureStorage methods
  static Future<void> setSecureStorage(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  static Future<String?> getSecureStorage(String key) async {
    return await secureStorage.read(key: key);
  }

  // Save and Secure AccessToken
  static Future<void> saveAccessToken(String key, String accessToken) async {
    await setSecureStorage(key, accessToken);
  }

  //  Get Secure AccessToken
  static Future<String> getSecureAccessToken(String key) async {
    return await getSecureStorage(key) ?? '';
  }

  static Future<void> deleteSecureStorage(String key) async {
    await secureStorage.delete(key: key);
  }

  // SharedPreferences methods
  static Future<void> setString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  static String? getString(String key) {
    return prefs?.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return prefs?.getBool(key);
  }

  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharePreferenceKeys.userID) ?? '';
  }

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharePreferenceKeys.baseURL) ?? '';
  }

  static Future<void> saveNologin(bool isNoLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(noLogin);
    await prefs.setBool(noLogin, isNoLogin);
  }

  static Future<void> removeNologin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(noLogin);
  }

  static Future<String> getFirstApp() async {
    final prefs = await SharedPreferences.getInstance();
    String typeFirstApp = FIRSTAPP.none.name;
    try {
      typeFirstApp = prefs.getString(firstApp)!;
    } catch (error) {
      return FIRSTAPP.none.name;
    }
    return typeFirstApp;
  }

  static Future<void> saveFirstApp(FIRSTAPP typeFirstApp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(firstApp);
    await prefs.setString(firstApp, typeFirstApp.name);
  }

  static Future<void> removeFirstApp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(firstApp);
  }
}
