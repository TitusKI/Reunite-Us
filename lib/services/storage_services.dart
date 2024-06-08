import 'package:afalagi/views/common/values/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> storeToken({
    String? accessToken,
    String? refreshToken,
    String? resetToken,
  }) async {
    if (accessToken != null) {
      await _prefs.setString('access_token', accessToken);
    }
    if (refreshToken != null) {
      await _prefs.setString('refresh_token', refreshToken);
    }
    if (resetToken != null) {
      await _prefs.setString('resetToken', resetToken);
    }
  }

  Future<void> clearTokens() async {
    await _prefs.remove('access_token');
    await _prefs.remove('refresh_token');
    await _prefs.remove('resetToken');
  }

  Future<String?> getAccessToken() async {
    return _prefs.getString('access_token');
  }

  Future<String?> getRefreshToken() async {
    return _prefs.getString('refresh_token');
  }

  Future<String?> getResetToken() async {
    return _prefs.getString('resetToken');
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getIsLoggedIn() {
    return _prefs.getBool(AppConstant.STORAGE_USER_TOKEN_KEY) ?? false;
  }
}
