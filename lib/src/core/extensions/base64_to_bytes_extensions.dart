import 'dart:convert';
import 'package:flutter/foundation.dart';

extension Base64ImageExtension on String {
  Uint8List get toImageBytes => base64Decode(this);
}
