import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Profile/presentation/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map? data;

  void getData() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    reference.onValue.listen((event) {
      data = event.snapshot.value as Map;
      SharedHelper.setstring(key: 'NAME', value: data!['first_name']);
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
        leadingWidth: 70.w,
        leading: const PopWidget(),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Image.asset('assets/images/4 57787.png')],
          ),
          Column(
            children: [
              if (data == null)
                const Center(
                  child: CircularProgressIndicator(),
                ),
              if (data != null)
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.bottomColor),
                          ),
                        ),
                      ],
                    ),
                    10.heightBox,
                    data!['profile_picture'] == ''
                        ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CircleAvatar(
                              radius: 55.h,
                              backgroundImage: const AssetImage(
                                  'assets/images/blank-avatar.png'),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            child: CircleAvatar(
                              radius: 55.h,
                              backgroundImage:
                                  NetworkImage(data!['profile_picture']),
                            ),
                          ),
                    10.heightBox,
                    Text(
                      '${data!['first_name']} ${data!['last_name']}',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.bottomColor),
                    ),
                    10.heightBox,
                    InfoWidget(
                      title1: 'First Name',
                      title2: data!['first_name'],
                    ),
                    InfoWidget(
                      title1: 'Last Name',
                      title2: data!['last_name'],
                    ),
                    InfoWidget(
                      title1: 'ID Number',
                      title2: data!['national_id'],
                    ),
                    InfoWidget(
                      title1: 'Car Number',
                      title2: data!['license_plate'],
                    ),
                    InfoWidget(
                      title1: 'Phone Number',
                      title2: data!['phonenumber'],
                    ),
                    10.heightBox,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfile(),
                            ));
                      },
                      child: Container(
                        height: 25.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10.h)),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ],
          )
        ],
      )),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String title1;
  final String title2;
  const InfoWidget({super.key, required this.title1, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title1,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
          child: Container(
            height: 35.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.h),
                border: Border.all(color: AppColors.bottomColor, width: 2.h)),
            child: Row(
              children: [
                10.widthBox,
                Text(
                  title2,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700]),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
