import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../base_response/base_response.dart';
import '../exception/cache_exception.dart';

@module
abstract class SharedPreferencesModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@lazySingleton
class CacheHelper {
  final SharedPreferences _prefs;

  CacheHelper(this._prefs);

  // ========== Save Data ==========

  Future<BaseResponse<bool>> saveData({
    required String key,
    required Object value,
  }) async {
    try {
      bool result;

      if (value is String) {
        result = await _prefs.setString(key, value);
      } else if (value is int) {
        result = await _prefs.setInt(key, value);
      } else if (value is bool) {
        result = await _prefs.setBool(key, value);
      } else if (value is double) {
        result = await _prefs.setDouble(key, value);
      } else if (value is List<String>) {
        result = await _prefs.setStringList(key, value);
      } else {
        return BaseResponse.failure(
          CacheException(
            message: 'Unsupported value type: ${value.runtimeType}',
            code: 'UNSUPPORTED_TYPE',
          ),
        );
      }

      return BaseResponse.success(result);
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to save data for key: $key',
          code: 'SAVE_ERROR',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // ========== Get Data (Generic) ==========

  BaseResponse<T?> getData<T>({required String key}) {
    try {
      final value = _prefs.get(key);

      if (value == null) {
        return const BaseResponse.success(null);
      }

      if (value is! T) {
        return BaseResponse.failure(
          CacheException(
            message: 'Type mismatch: Expected $T but got ${value.runtimeType}',
            code: 'TYPE_MISMATCH',
          ),
        );
      }

      return BaseResponse.success(value as T);
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get data for key: $key',
          code: 'GET_ERROR',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // ========== Type-Specific Getters (Convenience) ==========

  BaseResponse<String?> getString(String key) {
    try {
      return BaseResponse.success(_prefs.getString(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get string for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<int?> getInt(String key) {
    try {
      return BaseResponse.success(_prefs.getInt(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get int for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<bool?> getBool(String key) {
    try {
      return BaseResponse.success(_prefs.getBool(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get bool for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<double?> getDouble(String key) {
    try {
      return BaseResponse.success(_prefs.getDouble(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get double for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<List<String>?> getStringList(String key) {
    try {
      return BaseResponse.success(_prefs.getStringList(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get string list for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // ========== Delete Operations ==========

  Future<BaseResponse<bool>> remove(String key) async {
    try {
      final result = await _prefs.remove(key);
      return BaseResponse.success(result);
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to remove key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  Future<BaseResponse<bool>> clear() async {
    try {
      final result = await _prefs.clear();
      return BaseResponse.success(result);
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to clear all data',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // ========== Utility Methods ==========

  BaseResponse<bool> containsKey(String key) {
    try {
      return BaseResponse.success(_prefs.containsKey(key));
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to check key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<Set<String>> getKeys() {
    try {
      return BaseResponse.success(_prefs.getKeys());
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get all keys',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  // ========== Enum Support ==========

  Future<BaseResponse<bool>> saveEnum<T>(String key, T value) async {
    try {
      final result = await _prefs.setString(key, value.toString());
      return BaseResponse.success(result);
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to save enum for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  BaseResponse<T?> getEnum<T>(String key, List<T> values) {
    try {
      final stringValue = _prefs.getString(key);

      if (stringValue == null) {
        return const BaseResponse.success(null);
      }

      try {
        final enumValue = values.firstWhere((e) => e.toString() == stringValue);
        return BaseResponse.success(enumValue);
      } catch (_) {
        return BaseResponse.failure(
          CacheException(
            message: 'Enum value not found for key: $key',
            code: 'ENUM_NOT_FOUND',
          ),
        );
      }
    } catch (e, stackTrace) {
      return BaseResponse.failure(
        CacheException(
          message: 'Failed to get enum for key: $key',
          originalException: e,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
