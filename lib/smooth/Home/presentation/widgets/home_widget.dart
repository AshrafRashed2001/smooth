import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/resources/app_colors.dart';

// ignore: must_be_immutable
class HomeWidget extends StatelessWidget {
  final String title;
  final String image;
  final void Function() onTap;
  bool? isHome;
   HomeWidget(
      {super.key,
      required this.image,
      this.isHome,
      required this.onTap,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3.h),
        child: Column(
          children: [
            Container(
              height: 48.h,
              width: 48.h,
              decoration: BoxDecoration(
                color: isHome == null ? AppColors.primaryColor : AppColors.bottomColor,
                border: Border.all(color: AppColors.bottomColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  image,
                  height: 48.h,
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color:  AppColors.bottomColor),
            )
          ],
        ),
      ),
    );
  }
}