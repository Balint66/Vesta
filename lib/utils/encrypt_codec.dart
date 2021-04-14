//source: https://github.com/boapps/Szivacs-Naplo/blob/master/lib/Helpers/encrypt_codec.dart
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:meta/meta.dart';

var _random = Random.secure();

/// Random bytes generator
Uint8List _randBytes(int length) {
  return Uint8List.fromList(
      List<int>.generate(length, (i) => _random.nextInt(256)));
}

/// Generate an encryption password based on a user input password
///
/// It uses MD5 which generates a 16 bytes blob, size needed for Salsa20
Uint8List _generateEncryptPassword(String password) {
  var blob = Uint8List.fromList(md5
      .convert(utf8.encode(password))
      .bytes);
  assert(blob.length == 16);
  return blob;
}

/// Salsa20 based encoder
class _EncryptEncoder extends Converter<Map<String, dynamic>, String> {
  final Salsa20 salsa20;

  _EncryptEncoder(this.salsa20);

  @override
  String convert(Map<String, dynamic> input) {
    // Generate random initial value
    var iv = _randBytes(8);
    var ivEncoded = base64.encode(iv);
    assert(ivEncoded.length == 12);

    // Encode the input value
    var encoded =
        Encrypter(salsa20)
            .encrypt(json.encode(input), iv: IV(iv))
            .base64;

    // Prepend the initial value
    return '$ivEncoded$encoded';
  }
}

/// Salsa20 based decoder
class _EncryptDecoder extends Converter<String, Map<String, dynamic>> {
  final Salsa20 salsa20;

  _EncryptDecoder(this.salsa20);

  @override
  Map<String, dynamic> convert(String input) {
    // Read the initial value that was prepended
    assert(input.length >= 12);
    var iv = base64.decode(input.substring(0, 12));

    // Extract the real input
    input = input.substring(12);

    // Decode the input
    var decoded = json.decode(Encrypter(salsa20).decrypt64(input, iv: IV(iv)));
    if (decoded is Map) {
      return decoded.cast<String, dynamic>();
    }
    throw FormatException('invalid input $input');
  }
}

/// Salsa20 based Codec
class _EncryptCodec extends Codec<Map<String, dynamic>, String> {
  _EncryptEncoder _encoder;
  _EncryptDecoder _decoder;

  factory _EncryptCodec(Uint8List passwordBytes) {
    var salsa20 = Salsa20(Key(passwordBytes));
    var _encoder = _EncryptEncoder(salsa20);
    var _decoder = _EncryptDecoder(salsa20);
    return _EncryptCodec._(_encoder, _decoder);
  }

  _EncryptCodec._(this._encoder, this._decoder);


  @override
  Converter<String, Map<String, dynamic>> get decoder => _decoder;

  @override
  Converter<Map<String, dynamic>, String> get encoder => _encoder;
}

Codec<Map<String, dynamic>, String> getCodec(String password) => _EncryptCodec(_generateEncryptPassword(password));