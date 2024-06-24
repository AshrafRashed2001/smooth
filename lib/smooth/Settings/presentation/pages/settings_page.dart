import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/smooth/Profile/presentation/pages/edit_profile_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leadingWidth: 70.w,
        leading: const PopWidget(),
      ),
      body: Stack(children: [
        Column(
          children: [
            Image.asset(
              'assets/images/Black Red Minimalist Speed Car Logo (23) 2.png',
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
                'assets/images/Black Red Minimalist Speed Car Logo (23) 1.png'),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/PG122.png',
                  height: 40.h,
                  width: 80.w,
                ),
                InkWell(
                  onTap: () {
                    // استدعاء الدالة للانتقال إلى صفحة EditProfile
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfile()),
                    );
                  },
                  child: Container(
                    height: 25.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                        color: AppColors.bottomColor,
                        borderRadius: BorderRadius.circular(10.h)),
                    child: Center(
                      child: Text(
                        'Editing data',
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
        )
      ]),
    );
  }
}
