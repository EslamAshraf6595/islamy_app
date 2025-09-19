import 'package:dio/dio.dart';

class PrayerTime {
  final Map<String, dynamic> timings;
  final Map<String, dynamic> gregorian;
  final Map<String, dynamic> hijri;

  PrayerTime({
    required this.timings,
    required this.gregorian,
    required this.hijri,
  });

  factory PrayerTime.fromJson(Map<String, dynamic> json) {
    return PrayerTime(
      timings: json["data"]["timings"],
      gregorian: json["data"]["date"]["gregorian"],
      hijri: json["data"]["date"]["hijri"],
    );
  }
}

class PrayerApi {
  static final Dio _dio = Dio();

  static Future<PrayerTime> getPrayerTimes({
    required String city,
    required String country,
  }) async {
    final url =
        "https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country";
    final response = await _dio.get(url);

    if (response.statusCode == 200) {
      return PrayerTime.fromJson(response.data);
    } else {
      throw Exception("Failed to load prayer times");
    }
  }
}
