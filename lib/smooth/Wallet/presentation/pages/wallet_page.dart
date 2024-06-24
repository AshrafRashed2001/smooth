import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/choose_wallet_page.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/payment_history_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  Map? data;

  void getData() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    reference.onValue.listen((event) {
      data = event.snapshot.value as Map;
      setState(() {});
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70.w,
        leading: const PopWidget(),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                    'assets/images/Black Red Minimalist Speed Car Logo (17) 1.png')
              ],
            ),
            if (data == null) const CircularProgressIndicator(),
            if (data != null)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Wallet',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.bottomColor),
                  ),
                  30.heightBox,
                  Image.asset(
                    'assets/images/wallet.png',
                    height: 80.h,
                  ),
                  10.heightBox,
                  Padding(
                    padding: EdgeInsets.all(12.h),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15.h),
                          border: Border.all(color: AppColors.bottomColor)),
                      child: Center(
                        child: Text(
                          '${data!['credit']} EGY',
                          style: TextStyle(
                              fontSize: 18.sp, fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentHistoryPage(),
                          ));
                    },
                    child: Container(
                      height: 25.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          color: const Color(0xffF7BA1D),
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Center(
                        child: Text(
                          'Payment history',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  10.heightBox,
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChooseWalletPage(),
                          ));
                    },
                    child: Container(
                      height: 25.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          color: const Color(0xff00BF63),
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Center(
                        child: Text(
                          'Wallet charging',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
          ],
        ),
      )),
    );
  }
}
