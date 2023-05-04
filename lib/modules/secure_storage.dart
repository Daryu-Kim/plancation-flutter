import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

class SecureStorage {
  static final storage = const FlutterSecureStorage();
  Future<bool> saveStorage(String key, String value) async {
    await storage.write(key: key, value: value);
    return true;
  }

  Future<String?> readStorage(String key) async {
    String? result = await storage.read(key: key);
    return result;
  }
}
