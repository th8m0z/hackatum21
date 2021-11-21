import 'dart:typed_data';

import 'package:flutter/material.dart';

class StaticStore {
  static MemoryImage _image;

  static void setImage(MemoryImage newImage) {
    _image = newImage;
  }

  static MemoryImage get image => _image;
}
