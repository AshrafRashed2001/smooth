import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';

class VisaPaymentPage extends StatefulWidget {
  const VisaPaymentPage({super.key});

  @override
  State<VisaPaymentPage> createState() => _VisaPaymentPageState();
}

class _VisaPaymentPageState extends State<VisaPaymentPage> {
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
        'type': 'visa'
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
                  20.heightBox,
                  Text(
                    'Enter Debit Card',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.bottomColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          'assets/images/Black Red Minimalist Speed Car Logo (11) 1.png'),
                    ],
                  ),
                  10.heightBox,
                  FieldGeneralWidget(
                    height: 40.h,
                    controller: amount,
                    isSecret: false,
                    ispass: false,
                    keyboardType: TextInputType.number,
                    name: '0 EGY',
                    val: (value) {
                      if (value.trim().isEmpty) {
                        return 'field required';
                      } else {}
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 30.w),
                    child: Row(
                      children: [
                        Image.asset('assets/images/Visa 1.png'),
                        10.widthBox,
                        Image.asset('assets/images/Mastercard.png'),
                        30.widthBox,
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: FieldGeneralWidget(
                              height: 40.h,
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(),
                              isSecret: false,
                              ispass: false,
                              name: 'xxx',
                              val: (value) {
                                if (value.trim().isEmpty) {
                                  return 'field required';
                                } else {}
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FieldGeneralWidget(
                    height: 40.h,
                    controller: TextEditingController(),
                    keyboardType: TextInputType.number,
                    isSecret: false,
                    ispass: false,
                    name: 'xxxx xxxx xxxx xxxx',
                    val: (value) {
                      if (value.trim().isEmpty) {
                        return 'field required';
                      } else {}
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: FieldGeneralWidget(
                          height: 40.h,
                          controller: TextEditingController(),
                          isSecret: false,
                          ispass: false,
                          keyboardType: TextInputType.number,
                          name: 'MM',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: FieldGeneralWidget(
                          height: 40.h,
                          controller: TextEditingController(),
                          isSecret: false,
                          ispass: false,
                          keyboardType: TextInputType.number,
                          name: 'YY',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                      ),
                    ],
                  ),
                  20.heightBox,
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
                      } else {}
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
