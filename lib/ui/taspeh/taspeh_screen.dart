import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/model/tasbeeh_provider.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:provider/provider.dart';

class TaspehScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TasbeehProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            provider.azkar[provider.currentZikrIndex],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.elevatedBg,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            "عدد مرات التسبيح: ${provider.count} / ${provider.totalBeads}",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.elevatedBg, fontSize: 16.sp),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 145.w,
            height: 86.h,
            child: Image.asset(AppAssets.sephahead),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: provider.rotateSebha,
                child: AnimatedRotation(
                  duration: Duration(milliseconds: 200),
                  turns: provider.turnSpeh,
                  child: Image.asset(AppAssets.sebhaBody),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.azkar[provider.currentZikrIndex],
                    style: TextStyle(
                      color: AppColor.elevatedBg,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${provider.count}",
                    style: TextStyle(
                      color: AppColor.elevatedBg,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.h),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColor.elevatedBg)),
            onPressed: provider.resetSebha,
            child: Text(
              "إعادة التصفير",
              style: TextStyle(color: AppColor.blakeIconElevatedBg),
            ),
          ),
        ],
      ),
    );
  }
}
