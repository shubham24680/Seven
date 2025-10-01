import 'package:seven/app/app.dart';

class SPD {
  static SPD? _instance;
  static SharedPreferences? _prefs;

  SPD._();

  static Future<SPD> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _instance ??= SPD._();
  }

  int get profilePicIndex =>
      _prefs?.getInt(StorageConstants.PROFILE_PIC_INDEX) ?? 0;
  String? get name => _prefs?.getString(StorageConstants.NAME);
  String? get email => _prefs?.getString(StorageConstants.EMAIL);
  String? get dateOfBirth => _prefs?.getString(StorageConstants.DATE_OF_BIRTH);
  String? get phoneNumber => _prefs?.getString(StorageConstants.PHONE_NUMBER);

  Future<bool> setProfilePicIndex(int index) async =>
      await _prefs?.setInt(StorageConstants.PROFILE_PIC_INDEX, index) ?? false;
  Future<bool> setName(String name) async =>
      await _prefs?.setString(StorageConstants.NAME, name) ?? false;
  Future<bool> setEmail(String email) async =>
      await _prefs?.setString(StorageConstants.EMAIL, email) ?? false;
  Future<bool> setDateOfBirth(String dateOfBirth) async =>
      await _prefs?.setString(StorageConstants.DATE_OF_BIRTH, dateOfBirth) ??
      false;
  Future<bool> setPhoneNumber(String phoneNumber) async =>
      await _prefs?.setString(StorageConstants.PHONE_NUMBER, phoneNumber) ??
      false;

  Future<bool> clearProfileData() async {
    await _prefs?.remove(StorageConstants.NAME);
    await _prefs?.remove(StorageConstants.EMAIL);
    await _prefs?.remove(StorageConstants.DATE_OF_BIRTH);
    await _prefs?.remove(StorageConstants.PHONE_NUMBER);
    return await _prefs?.remove(StorageConstants.PROFILE_PIC_INDEX) ?? false;
  }

  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }

  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  Set<String> getAllKeys() {
    return _prefs?.getKeys() ?? {};
  }
}
