import 'package:teamtemp/constants/local_storage_key.dart';
import 'package:teamtemp/enums/auth_provider_type.dart';

import '../local_storage.service.dart';

/// Typed access to persistent storage for the last authentication provider type
/// that was used to successfully authenticate.
class AuthProviderTypeCache {
  AuthProviderTypeCache(this._localStorage);
  final LocalStorage _localStorage;

  Future<void> setAuthProviderType(AuthProviderType value) async {
    final valueIndex = AuthProviderType.values.indexOf(value);
    await _localStorage.setInt(LocalStorageKey.AUTH_PROVIDER_TYPE, valueIndex);
  }

  Future<AuthProviderType> getAuthProviderType() async {
    final int valueIndex = await _localStorage.getInt(LocalStorageKey.AUTH_PROVIDER_TYPE);
    if (valueIndex == null) {
      return null;
    }
    return AuthProviderType.values[valueIndex];
  }

  Future<void> removeAuthProviderType() async {
    await _localStorage.remove(LocalStorageKey.AUTH_PROVIDER_TYPE);
  }
}
