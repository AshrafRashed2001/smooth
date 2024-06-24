import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';

class FawryPage extends StatelessWidget {
  const FawryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: const PopWidget(),
        leadingWidth: 70.w,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (10) 1.png')
            ],
          ),
          Column(
            children: [
              100.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Fawry',
                    style: TextStyle(
                        fontSize: 33.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.bottomColor),
                  ),
                ],
              ),
              10.heightBox,
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (6) 1.png'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Payment reference code',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.h),
                      border: Border.all(color: AppColors.bottomColor)),
                  child: Center(
                    child: Text(
                      '4875389543987',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
              Text(
                '** This code is valid for 24 hours',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w800),
              ),
              10.heightBox,
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 20.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Center(
                      child: Text(
                        'Change payment',
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
