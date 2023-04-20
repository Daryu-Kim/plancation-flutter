import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SecureStorage {
  static final storage = new FlutterSecureStorage();
  Future<bool> saveStorage(String _key, String _value) async {
    await storage.write(key: _key, value: _value);
    return true;
  }

  Future<String?> readStorage(String _key) async {
    String? result = await storage.read(key: _key);
    return result;
  }
}