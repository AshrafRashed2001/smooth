import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';
import 'package:smooth/smooth/Home/presentation/pages/home_page.dart';

class DoneSendPage extends StatelessWidget {
  final String id;

  const DoneSendPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (7) 3.png')
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Black Red Minimalist Speed Car Logo (7) 2.png',
                    height: 200.h,
                  ),
                ],
              ),
              Text(
                'The Complaint has been',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bottomColor),
              ),
              Text(
                'submitted successfully',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.bottomColor),
              ),
              10.heightBox,
              Text(
                'Complaint id: $id',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.heightBox,
              Text(
                'we will contact you as soon as possible',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              10.heightBox,
              Text(
                '(Please make a screenshot to save the complaint ID)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
              10.heightBox,
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: id)).then((_) {
                    AppSnakBarMessages.snakbarSuccessMesage(
                        context: context,
                        message: 'Copied to your clipboard !');
                  });
                },
                child: Container(
                  height: 20.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Center(
                    child: Text(
                      'Copy id',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              20.heightBox,
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                      color: AppColors.bottomColor,
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Center(
                    child: Text(
                      'send another complaint',
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              10.heightBox,
              InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false);
                  },
                  child: Image.asset('assets/images/Vector.png')),
              80.heightBox,
            ],
          ),
        ],
      )),
    );
  }
}
