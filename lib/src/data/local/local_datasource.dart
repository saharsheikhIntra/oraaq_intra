import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class LocalDatasource {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<String?> read(String key) async {
    try {
      final value = await _storage.read(key: key);
      return value;
    } on Exception catch (e) {
      Logger().e(e);
      return null;
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } on Exception catch (e) {
      Logger().e(e);
    }
  }

  Future<void> update(String key, String value) async {
    try {
      await write(key, value);
    } on Exception catch (e) {
      Logger().e(e);
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } on Exception catch (e) {
      Logger().e(e);
    }
  }
}
