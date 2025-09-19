import 'package:flutter/material.dart';
import 'package:islamy_app/utils/app_assets.dart';
import 'package:islamy_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BottomNavigationBarItem CustomBottomNavigationBarItem(
    {required int index,
    required String label,
    required String iconImage,
    required int selectedIndex}) {
  return BottomNavigationBarItem(
    icon: selectedIndex == index
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 22),
            decoration: BoxDecoration(
              color: AppColor.iconBgElevated,
              borderRadius: BorderRadius.circular(66),
            ),
            child: ImageIcon(
              AssetImage(
                iconImage,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(66),
            ),
            child: ImageIcon(
              AssetImage(
                iconImage,
              ),
            ),
          ),
    label: label,
  );
}
