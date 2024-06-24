import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';

class PhonePaymentPage extends StatefulWidget {
  const PhonePaymentPage({super.key});

  @override
  State<PhonePaymentPage> createState() => _PhonePaymentPageState();
}

class _PhonePaymentPageState extends State<PhonePaymentPage> {
  TextEditingController phone = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  void payNow() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    DatabaseReference reference2 = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}/payments')
        .push();
    try {
      await reference.update({
        'credit': num.parse(amount.text) +
            num.parse(SharedHelper.getstring(key: 'AMOUNT'))
      });
      await reference2.set({
        'amount': amount.text,
        'date': DateTime.now().toString(),
        'type': 'mobile'
      });
      // ignore: use_build_context_synchronously
      AppSnakBarMessages.snakbarSuccessMesage(
          context: context, message: 'Success');
    } catch (e) {
      // ignore: use_build_context_synchronously
      AppSnakBarMessages.snakbarErrorMesage(
          context: context, message: e.toString());
    }
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                      'assets/images/Black Red Minimalist Speed Car Logo (12) 1.png'),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (10) 1.png')
            ],
          ),
          SingleChildScrollView(
            child: Form(
              key: myKey,
              child: Column(
                children: [
                  80.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select Wallet',
                        style: TextStyle(
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.bottomColor),
                      ),
                    ],
                  ),
                  40.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/vc-300x300.png'),
                      Image.asset('assets/images/unnamed.png'),
                      Image.asset('assets/images/Clip path group (1).png'),
                      Image.asset('assets/images/Clip path group111.png'),
                    ],
                  ),
                  30.heightBox,
                  FieldGeneralWidget(
                    controller: phone,
                    isSecret: false,
                    ispass: false,
                    name: '01xxxxxxxxx',
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    val: (value) {
                      if (value.trim().isEmpty) {
                          return 'field required';
                        } else {}
                    },
                  ),
                  FieldGeneralWidget(
                    controller: amount,
                    isSecret: false,
                    ispass: false,
                     keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    name: '0 EGY',
                    val: (value) {
                      if (value.trim().isEmpty) {
                          return 'field required';
                        } else {}
                    },
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
                  10.heightBox,
                  BottomWidget(
                    isLoading: false,
                    name: 'Confirm Payment',
                    onTap: () {
                      if (myKey.currentState!.validate()) {
                        payNow();
                      } else {
                        
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
