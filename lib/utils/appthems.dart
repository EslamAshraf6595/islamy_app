import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThems {
  static ThemeData apptheme = ThemeData(
    scaffoldBackgroundColor: AppColor.scaffoldTransparent,
    canvasColor: AppColor.elevatedBg,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColor.whiteiconElevatedBg,
      unselectedItemColor: AppColor.blakeIconElevatedBg,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.blakeIconElevatedBg,
      centerTitle: true,
      titleTextStyle: TextStyle(color: AppColor.elevatedBg),
      iconTheme: IconThemeData(color: AppColor.elevatedBg),
    ),
  );
}
