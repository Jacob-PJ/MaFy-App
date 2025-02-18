import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHandler {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences? getInstance() {
    return _prefs;
  }

  static SharedPreferences? updateRecentMixed(String name, String baseSubject) {
    List<List<String>>? recentMixedList =
        (_prefs?.getStringList("recentMixed") ?? [])
            .map((item) => item.split(","))
            .toList();

    // Check if an item with the same name already exists
    int existingIndex = -1;
    for (int i = 0; i < recentMixedList.length; i++) {
      if (recentMixedList[i].first.toLowerCase() == name.toLowerCase()) {
        existingIndex = i;
        break;
      }
    }

    // If the item exists, move it to the front (index 0)
    if (existingIndex != -1) {
      List<String> existingItem = recentMixedList[existingIndex];
      recentMixedList.removeAt(existingIndex);
      recentMixedList.insert(0, existingItem);
    } else {
      // If the item does not exist, add it to the front
      recentMixedList.insert(0, [name, baseSubject]);
    }

    // Truncate the list to keep only the first 3 items
    if (recentMixedList.length > 3) {
      recentMixedList = recentMixedList.sublist(0, 3);
    }

    List<String> encodedList =
        recentMixedList.map((item) => item.join(",")).toList();

    _prefs?.setStringList("recentMixed", encodedList);

    _prefs?.setString("recent${baseSubject.toLowerCase()}", name);
    return _prefs;
  }

  static List<List<String>> getRecentMixed() {
    List<String>? encodedList = _prefs?.getStringList("recentMixed");
    if (encodedList == null) {
      return [];
    }

    List<List<String>> recentMixedList =
        encodedList.map((item) => item.split(",")).toList();

    return recentMixedList;
  }

  static String getRecentSubject(String baseSubject) {
    String? encodedString =
        _prefs?.getString("recent${baseSubject.toLowerCase()}");

    if (encodedString == null) {
      return "";
    }

    return encodedString;
  }

  static SharedPreferences? login() {
    _prefs?.setBool("loggedIn", true);
    return _prefs;
  }

  static bool loginStatus() {
    bool? status = _prefs?.getBool("loggedIn");

    if (status == null) {
      return false;
    }

    return status;
  }
}
