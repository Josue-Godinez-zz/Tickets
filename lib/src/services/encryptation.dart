import 'package:encrypt/encrypt.dart';

class Encryptation {
  static final _iv = IV.fromLength(16);
  static final _key = Key.fromUtf8('SXFPCHYKONI6S89U');
  static final _encrypter = Encrypter(AES(_key));

  static String encrypt(String value) {
    return _encrypter.encrypt(value, iv: _iv).base64;
  }

  static String decrypt(String value) {
    return _encrypter.decrypt64(value, iv: _iv);
  }
}
