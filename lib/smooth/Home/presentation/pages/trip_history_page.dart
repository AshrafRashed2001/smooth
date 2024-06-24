import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/DateTime/date_time_helper.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  DatabaseReference reference = FirebaseDatabase.instance.ref('transactions');
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
            children: [Image.asset('assets/images/cam 2.png')],
          ),
          Column(
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (4) 3.png'),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Trip history',
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.bottomColor),
                  )
                ],
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                query: reference
                    .orderByChild('email')
                    .equalTo(SharedHelper.getstring(key: 'EMAIL')),
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
                                  size: 18.h,
                                )),
                            5.widthBox,
                            Text(
                              snapshot.child('location').value.toString(),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            5.widthBox,
                            Text(
                              DateTimeHelper.getDatetimeFormat(DateTime.parse(
                                  snapshot
                                      .child('date_time')
                                      .value
                                      .toString())),
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            Text(
                              '${snapshot.child('cost').value} EGY',
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
