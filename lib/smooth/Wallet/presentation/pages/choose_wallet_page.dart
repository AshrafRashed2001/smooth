import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/fawry_page.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/phone_payment_page.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/visa_payment_page.dart';

class ChooseWalletPage extends StatelessWidget {
  const ChooseWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: const PopWidget(),
        leadingWidth: 70.w,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.bottomColor, width: 1.5.h)),
                  child: Image.asset(
                    'assets/images/Black Red Minimalist Speed Car Logo (13) 1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            20.heightBox,
            Text(
              'Choose payment',
              style: TextStyle(
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.bottomColor),
            ),
            70.heightBox,
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FawryPage(),
                      ));
                },
                child: Image.asset('assets/images/Frame 14.png')),
            20.heightBox,
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VisaPaymentPage(),
                      ));
                },
                child: Image.asset('assets/images/Frame 15.png')),
            20.heightBox,
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhonePaymentPage(),
                      ));
                },
                child: Image.asset('assets/images/Frame 16.png')),
            50.heightBox,
            Image.asset(
                'assets/images/Black Red Minimalist Speed Car Logo (14) 1.png'),
            Text(
              'Secure payment',
              style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}
