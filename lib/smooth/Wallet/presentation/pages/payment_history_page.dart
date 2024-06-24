import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/DateTime/date_time_helper.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  DatabaseReference reference = FirebaseDatabase.instance
      .ref('users/${SharedHelper.getstring(key: 'UID')}/payments');

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
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (4) 2.png')
            ],
          ),
          Column(
            children: [
              80.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Previous payments',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bottomColor),
                  )
                ],
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                query: reference,
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.h),
                    child: Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.h),
                          border: Border.all(color: AppColors.bottomColor)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.arrow_downward_sharp,
                                  size: 1.h,
                                )),
                            5.widthBox,
                            Text(
                              DateTimeHelper.getDatetimeFormat(DateTime.parse(
                                  snapshot.child('date').value.toString())),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            Text(
                              '${snapshot.child('amount').value} EGY',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.bottomColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}


// Padding(
//                   padding:  EdgeInsets.all(8.h),
//                   child: Container(
//                     height: 40.h,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5.h),
//                       border: Border.all(
//                         color: AppColors.bottomColor
//                       )
//                     ),
//                     child: Row(
//                       children: [
//                         // Text(DateTimeHelper.getDatetimeFormat(payData[index]['date']))
//                       ],
//                     ),
//                   ),
//                 );