import 'dart:convert';

class Helper {
  /// Encrypts (Encodes) a string using Base64
  String encryptHelper(String value) {
    return base64Encode(utf8.encode(value));
  }

  /// Decrypts (Decodes) a Base64 string
  String decryptHelper(String value) {
    return utf8.decode(base64Decode(value));
  }
}
