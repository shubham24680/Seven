import 'dart:convert';

import 'package:seven/app/app.dart';

class SPD {
  static SPD? _instance;
  final SharedPreferences? _prefs;

  SPD._(this._prefs);

  static Future<SPD> getInstance() async {
    if(_instance != null) return _instance!;
    final prefs = await SharedPreferences.getInstance();
    return _instance ??= SPD._(prefs);
  }

  bool containsKey(StorageKey storageKey) => _prefs?.containsKey(storageKey.name.toLowerCase()) ?? false;
  Set<String> getAllKeys() => _prefs?.getKeys() ?? {};

  //GET
  T? get<T>(StorageKey storageKey) {
    final key = storageKey.name.toLowerCase();

    return switch (T) {
      const (int) => _prefs?.getInt(key) as T?,
      const (double) => _prefs?.getDouble(key) as T?,
      const (bool) => _prefs?.getBool(key) as T?,
      const (String) => _prefs?.getString(key) as T?,
      const (List<String>) => _prefs?.getStringList(key) as T?,
      const (Map<String, dynamic>) => jsonDecode(_prefs?.getString(key) ?? "{}") as T?,
      _ => null,
    };
  }

  //SET
  Future<bool> set<T>(StorageKey storageKey, T value) async {
    final key = storageKey.name.toLowerCase();
    final prefs = _prefs;

    if (prefs == null || value == null) return false;

    return switch (value) {
      final int v => await prefs.setInt(key, v),
      final double v => await prefs.setDouble(key, v),
      final bool v => await prefs.setBool(key, v),
      final String v => await prefs.setString(key, v),
      final List<String> v => await prefs.setStringList(key, v),
    final Map<String, dynamic> v => await prefs.setString(key, jsonEncode(v)),
      _ => false,
    };
  }

  //CLEAR
  Future<bool> remove(StorageKey storageKey) async => await _prefs?.remove(storageKey.name.toLowerCase()) ?? false;
  Future<bool> clearAll() async => await _prefs?.clear() ?? false;
  Future<bool> clearProfileData() async {
    final prefs = _prefs;
    if (prefs == null) return false;

    final results = await Future.wait([
      prefs.remove(StorageKey.FIRST_VISIT.name),
      prefs.remove(StorageKey.NAME.name),
      prefs.remove(StorageKey.GENDER_INDEX.name),
      prefs.remove(StorageKey.DATE_OF_BIRTH.name),
      prefs.remove(StorageKey.PROFILE_PIC_INDEX.name),
    ]);
    return results.every((r) => r);
  }
}
