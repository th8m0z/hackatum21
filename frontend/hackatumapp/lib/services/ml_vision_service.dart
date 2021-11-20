import 'package:flutter/material.dart';
import 'package:google_ml_vision/google_ml_vision.dart';

class VisionService {
  static Future<String> processImage(String filePath) async {
    final GoogleVisionImage visionImage =
        GoogleVisionImage.fromFilePath(filePath);

    final TextRecognizer textRecognizer =
        GoogleVision.instance.textRecognizer();

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String text = visionText.text;
    return text;
    print("text == $text");
    for (TextBlock block in visionText.blocks) {
      final Rect boundingBox = block.boundingBox;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<RecognizedLanguage> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        print("line == ${line.text}");
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
  }
}
