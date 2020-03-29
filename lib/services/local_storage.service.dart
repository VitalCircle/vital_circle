import 'package:teamtemp/constants/log_zone.dart';
import 'package:teamtemp/services/log/log.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistent local storage using NSUsertDefaults (iOS) or Sharedpreferences (Android).
/// Data is persisted asynchronously and is not guaranteed
/// so we also store the data in an in-memory cache just to be safe.
class LocalStorage {
  final _log = LogService.zone(LogZone.LOCAL_STORAGE);
  final Map<String, dynamic> _cache = <String, dynamic>{};

  Future<void> setInt(String key, int value) async {
    _cache[key] = value;
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(key, value);
    _log.debug('Set int.', <String, dynamic>{'key': key, 'value': value});
  }

  Future<int> getInt(String key) async {
    if (_cache.containsKey(key)) {
      final int value = _cache[key];
      _log.debug('Get int from cache.', <String, dynamic>{'key': key, 'value': value});
      return value;
    }

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      final int value = sharedPreferences.getInt(key);
      _cache[key] = value;
      _log.debug('Get int from shared preferences.', <String, dynamic>{'key': key, 'value': value});
      return value;
    }
    return null;
  }

  Future<void> setString(String key, String value) async {
    _cache[key] = value;
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
    _log.debug('Set string.', <String, dynamic>{'key': key, 'value': value});
  }

  Future<String> getString(String key) async {
    if (_cache.containsKey(key)) {
      final String value = _cache[key];
      _log.debug('Get string from cache.', <String, dynamic>{'key': key, 'value': value});
      return value;
    }

    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(key)) {
      final String value = sharedPreferences.getString(key);
      _cache[key] = value;
      _log.debug('Get string from shared preferences.', <String, dynamic>{'key': key, 'value': value});
      return value;
    }
    return null;
  }

  Future<void> remove(String key) async {
    _cache.remove(key);
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(key);
    _log.debug('Removed.', <String, dynamic>{'key': key});
  }
}
