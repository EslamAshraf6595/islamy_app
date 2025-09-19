import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/Api/api_service_time.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PrayerTime>(
      future: PrayerApi.getPrayerTimes(
          city: "Cairo", country: "Egypt"), // ✅ change your city/country
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final data = snapshot.data!;
        final timings = data.timings;
        final gregorian = data.gregorian;
        final hijri = data.hijri;

        final prayers = [
          {"name": "Fajr", "time": timings["Fajr"]},
          {"name": "Dhuhr", "time": timings["Dhuhr"]},
          {"name": "Asr", "time": timings["Asr"]},
          {"name": "Maghrib", "time": timings["Maghrib"]},
          {"name": "Isha", "time": timings["Isha"]},
        ];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 🔹 Main Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                width: 390.w,
                height: 250.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF3D9A4), Color(0xFFE7B97D)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(40.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 🔹 Top Row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${gregorian["day"]} ${gregorian["month"]["en"]},\n${gregorian["year"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.blakeIconElevatedBg,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Column(
                            children: [
                              Text("Pray Time",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blakeIconElevatedBg)),
                              Text(gregorian["weekday"]["en"],
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.blakeIconElevatedBg)),
                            ],
                          ),
                          Text(
                            "${hijri["day"]} ${hijri["month"]["en"]},\n${hijri["year"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.blakeIconElevatedBg,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),

                    // 🔹 Prayer Times
                    SizedBox(
                      height: 120.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        itemBuilder: (context, index) {
                          final prayer = prayers[index];
                          bool isActive = index == 2; // Example: highlight Asr
                          return Container(
                            width: isActive ? 110.w : 95.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22.r),
                              gradient: isActive
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF3C3B3F),
                                        Color(0xFF605C3C)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )
                                  : const LinearGradient(
                                      colors: [
                                        Color(0xFF2E2E2E),
                                        Color(0xFF1C1C1C)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(prayer["name"]!,
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13.sp)),
                                  SizedBox(height: 6.h),
                                  Text(prayer["time"]!,
                                      style: TextStyle(
                                          fontSize: isActive ? 22.sp : 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) => SizedBox(width: 10.w),
                        itemCount: prayers.length,
                      ),
                    ),

                    // 🔹 Next Prayer Row
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Next Pray - 02:32", // 🔹 You can calculate this later
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.blakeIconElevatedBg)),
                          Icon(Icons.volume_off,
                              color: AppColor.blakeIconElevatedBg, size: 22.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15.h),

              // 🔹 Azkar Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildAzkarCard(AppAssets.even_azkar, "Evening Azkar"),
                    _buildAzkarCard(AppAssets.morning_azkar, "Morning Azkar"),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildAzkarCard(String image, String title) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 180.w,
      height: 240.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: AppColor.elevatedBg, width: 2.5),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25.r),
          ),
        ),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}
