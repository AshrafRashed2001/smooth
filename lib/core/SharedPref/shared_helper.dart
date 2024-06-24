import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static late final SharedPreferences pref;
  static Future initshared() async {
    pref = await SharedPreferences.getInstance();
  }

  static setstring({required String key, required String value}) async {
    await pref.setString(key, value);
  }

  static setbool({required String key, required bool value}) async {
    await pref.setBool(key, value);
  }

  static setint({required String key, required int value}) async {
    await pref.setInt(key, value);
  }

  static setdouble({required String key, required double value}) async {
    await pref.setDouble(key, value);
  }

  static getstring({required String key}) {
    String? result = pref.getString(key);
    return result;
  }

  static getint({required String key}) {
    int? result = pref.getInt(key);
    return result;
  }

  static getdouble({required String key}) {
    double? result = pref.getDouble(key);
    return result;
  }

  static getbool({required String key}) {
    bool? result = pref.getBool(key);
    return result;
  }

  static removedata({required String key})async{
    await pref.remove(key);
  }
}
