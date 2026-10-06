import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'hive_boxes.dart';

/// Thin wrapper over a Hive box. Values are stored as JSON strings so it
/// works the same on mobile, desktop and web (IndexedDB).
class LocalStorageService {
  LocalStorageService(this.box);

  final Box<dynamic> box;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(HiveBoxes.appBox);
  }

  static LocalStorageService app() =>
      LocalStorageService(Hive.box<dynamic>(HiveBoxes.appBox));

  Future<void> saveJson(String key, Object? value) =>
      box.put(key, value == null ? null : jsonEncode(value));

  Object? readJson(String key) {
    final raw = box.get(key);
    if (raw is! String) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      return null;
    }
  }

  Future<void> saveString(String key, String? value) => box.put(key, value);

  String? getString(String key) {
    final value = box.get(key);
    return value is String ? value : null;
  }

  Future<void> remove(String key) => box.delete(key);

  Future<void> clear() => box.clear();
}
