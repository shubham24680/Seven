import 'dart:convert';

import 'package:seven/app/app.dart';

class SPD {
  static SPD? _instance;
  static SharedPreferences? _prefs;

  SPD._();

  static Future<SPD> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _instance ??= SPD._();
  }

  // PROFILE: GET
  bool get isFirstTimeVisit =>
      _prefs?.getBool(StorageConstants.FIRST_VISIT) ?? true;
  int get profilePicIndex =>
      _prefs?.getInt(StorageConstants.PROFILE_PIC_INDEX) ?? 0;
  String? get name => _prefs?.getString(StorageConstants.NAME);
  int get genderIndex => _prefs?.getInt(StorageConstants.GENDER_INDEX) ?? -1;
  String? get dateOfBirth => _prefs?.getString(StorageConstants.DATE_OF_BIRTH);

  // SET
  Future<bool> setFirstTimeVisit(bool value) async =>
      await _prefs?.setBool(StorageConstants.FIRST_VISIT, value) ?? false;
  Future<bool> setProfilePicIndex(int index) async =>
      await _prefs?.setInt(StorageConstants.PROFILE_PIC_INDEX, index) ?? false;
  Future<bool> setName(String name) async =>
      await _prefs?.setString(StorageConstants.NAME, name) ?? false;
  Future<bool> setGenderIndex(int index) async =>
      await _prefs?.setInt(StorageConstants.GENDER_INDEX, index) ?? false;
  Future<bool> setDateOfBirth(String dateOfBirth) async =>
      await _prefs?.setString(StorageConstants.DATE_OF_BIRTH, dateOfBirth) ??
      false;

  // CLEAR
  Future<bool> clearProfileData() async {
    await _prefs?.remove(StorageConstants.FIRST_VISIT);
    await _prefs?.remove(StorageConstants.NAME);
    await _prefs?.remove(StorageConstants.GENDER_INDEX);
    await _prefs?.remove(StorageConstants.DATE_OF_BIRTH);
    return await _prefs?.remove(StorageConstants.PROFILE_PIC_INDEX) ?? false;
  }

  //SHOWS: GET
  Map<String, dynamic>? getShows(String key) {
    final data = _prefs?.getString(key);
    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }

  //SET
  Future<bool> setShows(String key, Map<String, dynamic> value) async {
    final data = jsonEncode(value);
    return await _prefs?.setString(key, data) ?? false;
  }

  // Future<bool> clearAll() async {
  //   return await _prefs?.clear() ?? false;
  // }

  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  Set<String> getAllKeys() {
    return _prefs?.getKeys() ?? {};
  }
}
