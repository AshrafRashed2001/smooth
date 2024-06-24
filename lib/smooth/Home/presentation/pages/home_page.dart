import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Chat/presentation/pages/chat_page.dart';
import 'package:smooth/smooth/Complaints/presentation/pages/complaints_page.dart';
import 'package:smooth/smooth/Home/presentation/pages/how_to_page.dart';
import 'package:smooth/smooth/Home/presentation/pages/trip_history_page.dart';
import 'package:smooth/smooth/Home/presentation/widgets/custom_drawer_widget.dart';
import 'package:smooth/smooth/Home/presentation/widgets/home_widget.dart';
import 'package:smooth/smooth/Profile/presentation/pages/edit_profile_page.dart';
import 'package:smooth/smooth/Wallet/presentation/pages/wallet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? data;

  void getData() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    reference.onValue.listen((event) {
      data = event.snapshot.value as Map;
      SharedHelper.setstring(key: 'PICTURE', value: data!['profile_picture']);
      SharedHelper.setstring(key: 'NAME', value: data!['first_name']);
      SharedHelper.setstring(key: 'AMOUNT', value: data!['credit'].toString());
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
      extendBodyBehindAppBar: true,
      drawer: CustomDrawer(data: data),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 1, child: Image.asset('assets/images/1back.png')),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/2back.png',
                ),
              )
            ],
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
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          child: Row(
                            children: [
                              Builder(builder: (context) {
                                return IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu,
                                      size: 22.h,
                                    ));
                              }),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(top: 45.h),
                                child: Column(
                                  children: [
                                    Text(
                                      'Hi,',
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data!['first_name'],
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              data!['profile_picture'] == ''
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EditProfile(),
                                                ));
                                          },
                                          child: CircleAvatar(
                                            radius: 25.h,
                                            backgroundImage: const AssetImage(
                                                'assets/images/blank-avatar.png'),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const EditProfile(),
                                                ));
                                          },
                                          child: CircleAvatar(
                                            radius: 25.h,
                                            backgroundImage: NetworkImage(
                                                data!['profile_picture']),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 40.w, top: 90.h),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/splash.png',
                                height: 130.h,
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            180.heightBox,
                            Text(
                              'A new experience in comfort',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            30.heightBox,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const WalletPage(),
                                          ));
                                    },
                                    child: Container(
                                      height: 28.h,
                                      width: 110.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.bottomColor,
                                          borderRadius:
                                              BorderRadius.circular(10.h)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Image.asset(
                                            'assets/images/Clip path group.png',
                                            height: 22.h,
                                          ),
                                          Text(
                                            data!['credit'].toString(),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'EGY',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            150.heightBox,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                        color: AppColors.bottomColor,
                                        width: 3.h),
                                    borderRadius: BorderRadius.circular(20.h)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HomeWidget(
                                      image: 'assets/images/1.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WalletPage(),
                                            ));
                                      },
                                      title: 'Wallet',
                                    ),
                                    HomeWidget(
                                      image: 'assets/images/2.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ChatPage(),
                                            ));
                                      },
                                      title: 'Chatbot',
                                    ),
                                    HomeWidget(
                                      image: 'assets/images/3.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const ComplaintsPage(),
                                            ));
                                      },
                                      title: 'Complaints',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            10.heightBox,
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                        color: AppColors.bottomColor,
                                        width: 3.h),
                                    borderRadius: BorderRadius.circular(20.h)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    HomeWidget(
                                      image: 'assets/images/4.png',
                                      onTap: () {},
                                      title: 'Home',
                                      isHome: true,
                                    ),
                                    HomeWidget(
                                      image: 'assets/images/5.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const TripHistoryPage(),
                                            ));
                                      },
                                      title: 'Trip history',
                                    ),
                                    HomeWidget(
                                      image: 'assets/images/6.png',
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const HowToPage(),
                                            ));
                                      },
                                      title: 'How to',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
            ],
          )
        ],
      )),
    );
  }
}
