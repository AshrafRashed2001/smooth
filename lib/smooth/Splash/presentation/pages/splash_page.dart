import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/smooth/Home/presentation/pages/home_page.dart';
import 'package:smooth/smooth/Login/presentation/pages/log_in_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SharedHelper.getstring(key: 'UID') != null
                  ? const HomePage()
                  : const LoginPage(),
            ),
            (route) => false);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Center(
        child: Image.asset(
          'assets/images/splash.png',
          height: 250.h,
        ),
      )),
    );
  }
}
