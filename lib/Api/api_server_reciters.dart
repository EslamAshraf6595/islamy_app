import 'package:dio/dio.dart';
import 'package:islamy_app/Api/endPoint/api_endPoint.dart';
import 'package:islamy_app/model/RecitersModel.dart';

class ApiServerReciters {
  Dio _dio = Dio();
  Future<RecitersModel?> fetchdReciterData({ String? reciter}) async {
    try {
      final respons = await _dio
          .get("https://www.mp3quran.net/api/v3/reciters?language=ar", queryParameters: {"language": "ar"});
      if (respons.statusCode! >= 200 && respons.statusCode! < 400) {
        return RecitersModel.fromJson(respons.data);
      } else {
        print("Error: ${respons.statusMessage}");
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
