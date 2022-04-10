import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  static const String boxName = '_movieApp';
  late Box box;
  static Storage? _instance;
  static Storage get instance => _instance ?? (_instance = Storage());
  Future init() async {
    if (!kIsWeb && !Hive.isBoxOpen(boxName)) {
      Hive.init((await getApplicationDocumentsDirectory()).path);
    }
    box = await Hive.openBox(boxName);
  }

  void set<T>(String key, T value) {
    box.put(key, value);
  }

  T get<T>(String key, T defaultValue) {
    return box.get(key, defaultValue: defaultValue) as T;
  }

  ThemeMode get themeMode =>
      get('lightTheme', true) ? ThemeMode.light : ThemeMode.dark;
  set themeMode(ThemeMode value) => set('lightTheme', value == ThemeMode.light);

  List<String> get searchHistory => get('searchHistory', []);
  set searchHistory(List<String> value) => set('searchHistory', value);

  void addToSearchHistory(String key) {
    var history = searchHistory;
    if (history.contains(key)) history.remove(key);
    history.insert(0, key);
    if (history.length > 10) history = history.sublist(0, 10);
    searchHistory = history;
  }
}
