import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageStore {
  static Uint8List _image;

  static void setImage(Uint8List newImage) {
    _image = newImage;
  }

  static Uint8List get image => _image;
}
