import 'package:dio/dio.dart';
import 'package:islamy_app/Api/endPoint/api_endPoint.dart';
import 'package:islamy_app/model/RadioModel.dart';

class ApiServiceRadio {
  final Dio _dio = Dio();

  Future<RadioModel?> fetchRadios({required String radio}) async {
    try {
      final response = await _dio.get(
        "${ApiEndpoint.basURL}$radio",
        queryParameters: {"language": "ar"},
      );

      if (response.statusCode == 200) {
        return RadioModel.fromJson(response.data);
      } else {
        print("Error: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
}