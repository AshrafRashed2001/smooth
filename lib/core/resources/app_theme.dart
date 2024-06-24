import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      appBarTheme:  AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold),
          elevation: 0,
          backgroundColor: AppColors.primaryColor),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showUnselectedLabels: true,
      ));
}
