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
                  return PaymentHistoryItem(snapshot: snapshot);
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentHistoryItem extends StatefulWidget {
  final DataSnapshot snapshot;
  bool isOpen = false;
   PaymentHistoryItem({super.key, required this.snapshot});

  @override
  State<PaymentHistoryItem> createState() => _PaymentHistoryItemState();
}

class _PaymentHistoryItemState extends State<PaymentHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: !widget.isOpen? Container(
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
                  onTap: () {
                    setState(() {
                      widget.isOpen = !widget.isOpen;
                    });
                  },
                  child: Icon(
                    Icons.arrow_downward_sharp,
                    size: 20.h,
                  )),
              5.widthBox,
              Text(
                DateTimeHelper.getDatetimeFormat(
                    DateTime.parse(widget.snapshot.child('date').value.toString())),
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
              ),
              const Spacer(),
              Text(
                '${widget.snapshot.child('amount').value} EGY',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.bottomColor),
              )
            ],
          ),
        ),
      ):Container(
         height: 140.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.h),
            border: Border.all(color: AppColors.bottomColor)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 8.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.isOpen = !widget.isOpen;
                      });
                    },
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      size: 20.h,
                    )),
                    Text(
                    'Details',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.bottomColor),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 1.h),
              child: Row(
                children: [
                    Text(
                    'Date:',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  5.widthBox,
                   Text(
                DateTimeHelper.getDatetimeFormat(
                    DateTime.parse(widget.snapshot.child('date').value.toString())),
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
              ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 1.h),
              child: Row(
                children: [
                    Text(
                    'Time:',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  5.widthBox,
                   Text(
                DateTimeHelper.getHoursByAmBm(
                    DateTime.parse(widget.snapshot.child('date').value.toString())),
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
              ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 1.h),
              child: Row(
                children: [
                    Text(
                    'Payment method:',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  5.widthBox,
                Text(
                    widget.snapshot.child('type').value.toString() == 'visa'?'VISA xxxx xxxx xxxx xxxx 6858':'01xxxxxxxxx',
                    style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
              ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 1.h),
              child: Row(
                children: [
                    Text(
                    'Amount:',
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  5.widthBox,
                Text(
                    widget.snapshot.child('amount').value.toString() + ' EGY',
                    style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600]),
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
