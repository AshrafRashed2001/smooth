import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Login/presentation/pages/log_in_page.dart';
import 'package:smooth/smooth/Profile/presentation/pages/profile_page.dart';
import 'package:smooth/smooth/Settings/presentation/pages/settings_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.data,
  });

  final Map? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: 230.w,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff164863),
            Color(0xffFFFFFF),
          ],
        ),
      ),
      child: Column(
        children: [
          if (data != null) 100.heightBox,
          data!['profile_picture'] == ''
              ? Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: CircleAvatar(
                        radius: 30.h,
                        backgroundImage:
                            const AssetImage('assets/images/blank-avatar.png'),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.h,
                        backgroundImage: NetworkImage(data!['profile_picture']),
                      ),
                    ],
                  ),
                ),
          20.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  '${data!['first_name']} ${data!['last_name']}',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text(
                  '${data!['email']}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[300],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          50.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/s1.png',
                    height: 30.h,
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          5.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/s2.png',
                    height: 30.h,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          5.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/s3.png',
                  height: 30.h,
                ),
                Text(
                  'Help and FAQs',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          5.heightBox,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 3.h),
            child: InkWell(
              onTap: () {
                SharedHelper.removedata(key: 'UID');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/s4.png',
                    height: 30.h,
                  ),
                  Text(
                    'sign out',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
