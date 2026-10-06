import 'dart:convert';

import 'package:emergencyhr_flutter/data/datasources/local/base/hive_boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  LocalStorageService(this.box);
  final Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(HiveBoxes.appBox);
    await Hive.openBox(HiveBoxes.authBox);
  }

  static Future<void> clearAll() async {
    await Hive.openBox(HiveBoxes.appBox);
    await Hive.openBox(HiveBoxes.authBox);
  }

  save(String key, dynamic value) {
    box.put(key, value);
  }

  saveMap(String key, Map? value) {
    box.put(key, value == null ? null : jsonEncode(value));
  }

  //Save List of Maps
  saveMapList(String key, List<Map> value) {
    box.put(key, value.map((e) => jsonEncode(e)).toList());
  }

  Map<String, dynamic>? getMap(String key) {
    final res = box.get(key, defaultValue: null);
    return res == null ? null : jsonDecode(res);
  }

  //Get List of Maps
  List? getMapList(String key) {
    final res = box.get(key, defaultValue: null);
    if (res == null) return null;
    return (res as List).map((e) => jsonDecode(e)).toList();
  }

  String? getString(String key) {
    return box.get(key, defaultValue: null);
  }

  int? getInt(String key) {
    return box.get(key, defaultValue: null);
  }

  bool? getBool(String key) {
    return box.get(key, defaultValue: null);
  }

  double? getDouble(String key) {
    return box.get(key, defaultValue: null);
  }

  static Future<void> clear() async {
    await Hive.box(HiveBoxes.appBox).clear();
    await Hive.box(HiveBoxes.authBox).clear();
  }
}
