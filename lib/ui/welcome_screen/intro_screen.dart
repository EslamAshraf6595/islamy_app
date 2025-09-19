import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamy_app/utils/app_colors.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen(
      {required this.image,
      required this.titel,
      this.content = '',
      this.index = 0});
  String image, titel;
  String content;
  int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 25.h,
        ),
        SizedBox(
          width: 398.w,
          height: 415.h,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        index == 0
            ? SizedBox(
                height: 100.h,
              )
            : SizedBox(
                height: 80.h,
              ),
        Text(
          titel,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.elevatedBg, fontSize: 22),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.elevatedBg, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
