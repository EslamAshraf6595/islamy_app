import 'package:flutter/services.dart';

class ReadLocalSuraData {
  static Future<String> readSuraData({required String filePath}) async {
    return await rootBundle.loadString(filePath);
  }
}
