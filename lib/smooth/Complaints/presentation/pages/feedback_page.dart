import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Home/presentation/pages/home_page.dart';

class FeedBackPage extends StatefulWidget {
  final String id;
  const FeedBackPage({super.key, required this.id});

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  String answer = '';
  String complaint = '';

  void getData() async {
    DatabaseReference reference1 = FirebaseDatabase.instance
        .ref('complaints/${widget.id}')
        .child('feedback');
    reference1.onValue.listen((event) {
      answer = event.snapshot.value.toString();
      setState(() {});
    });
    DatabaseReference reference2 = FirebaseDatabase.instance
        .ref('complaints/${widget.id}')
        .child('complaint');
    reference2.onValue.listen((event) {
      complaint = event.snapshot.value.toString();
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
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leading: const PopWidget(),
        leadingWidth: 70.w,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            100.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (7) 2.png',
                  height: 140.h,
                ),
              ],
            ),
            Text(
              'Complaint',
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bottomColor),
            ),
            10.heightBox,
             Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                complaint,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            10.heightBox,
            Text(
              'YOUR COMPLAINT FEEDBACK IS',
              style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bottomColor),
            ),
            10.heightBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            30.heightBox,
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 25.h,
                width: 230.w,
                decoration: BoxDecoration(
                    color: AppColors.bottomColor,
                    borderRadius: BorderRadius.circular(10.h)),
                child: Center(
                  child: Text(
                    'inquire about another complaint',
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                      (route) => false);
                },
                child: Image.asset('assets/images/Vector.png')),
          ],
        ),
      ),
    );
  }
}
