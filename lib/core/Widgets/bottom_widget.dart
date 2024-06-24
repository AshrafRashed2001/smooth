// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/resources/extentions.dart';

import '../resources/app_colors.dart';

class BottomWidget extends StatelessWidget {
  bool isLoading;
  String name;
  void Function() onTap;
  BottomWidget(
      {super.key,
      required this.isLoading,
      required this.name,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.height * 0.01, horizontal: context.height * 0.03),
      child: InkWell(
        onTap: !isLoading ? onTap : null,
        child: Container(
          height: context.height * 0.06,
          width: double.infinity,
          decoration: BoxDecoration(
              color: !isLoading ? AppColors.bottomColor : Colors.grey[500],
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: !isLoading
                ? Text(
                    name,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
