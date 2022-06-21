import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

convertIMG(value) {
  Uint8List _bytesImage;
  _bytesImage = Base64Decoder().convert(value);

  return Image.memory(
    _bytesImage,
    width: 800,
    height: 400,
  );
}
