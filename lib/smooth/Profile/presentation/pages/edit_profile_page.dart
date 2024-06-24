import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth/core/Firebase/fire_base_helper.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Map? data;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController carNumber = TextEditingController();

  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  void getData() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    reference.onValue.listen((event) {
      data = event.snapshot.value as Map;
      SharedHelper.setstring(key: 'NAME', value: data!['first_name']);
      firstName.text = data!['first_name'];
      lastName.text = data!['last_name'];
      idNumber.text = data!['national_id'];
      phoneNumber.text = data!['phonenumber'];
      carNumber.text = data!['license_plate'];
      setState(() {});
    });
  }

  void updateData() async {
    DatabaseReference reference = FirebaseDatabase.instance
        .ref('users/${SharedHelper.getstring(key: 'UID')}');
    await reference.update({
      'first_name': firstName.text,
      'last_name': lastName.text,
      'national_id': idNumber.text,
      'phonenumber': phoneNumber.text,
      'license_plate': carNumber.text
    }).then((value) {
      AppSnakBarMessages.snakbarSuccessMesage(
          context: context, message: 'Success!');
    });
  }

  void editPhoto() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      if (value != null) {
        await FirebaseHelper.uploadImage(file: File(value.path))
            .then((value) async {
          DatabaseReference reference = FirebaseDatabase.instance
              .ref('users/${SharedHelper.getstring(key: 'UID')}');
          await reference.update({'profile_picture': value});
        });
      } else {}
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('assets/images/4 57786.png'),
                ],
              )
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                if (data == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (data != null)
                  Form(
                    key: myKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Text(
                                'Change information',
                                style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.bottomColor),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        if (data!['profile_picture'] == '') Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        editPhoto();
                                      },
                                      child: CircleAvatar(
                                        radius: 35.h,
                                        backgroundImage: const AssetImage(
                                            'assets/images/blank-avatar.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ) else Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        editPhoto();
                                      },
                                      child: CircleAvatar(
                                        radius: 35.h,
                                        backgroundImage: NetworkImage(
                                            data!['profile_picture']),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        20.heightBox,
                        FieldGeneralWidget(
                          height: 40.h,
                          controller: firstName,
                          isSecret: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]'))
                          ],
                          ispass: false,
                          name: 'First Name',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                        FieldGeneralWidget(
                          height: 40.h,
                          controller: lastName,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-Z ]'))
                          ],
                          isSecret: false,
                          ispass: false,
                          name: 'Last Name',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                        FieldGeneralWidget(
                          keyboardType: TextInputType.number,
                          height: 40.h,
                          controller: idNumber,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(14)
                          ],
                          isSecret: false,
                          ispass: false,
                          name: 'ID Number',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                        FieldGeneralWidget(
                          height: 40.h,
                          controller: carNumber,
                          isSecret: false,
                          ispass: false,
                          name: 'Car Number',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                        FieldGeneralWidget(
                          height: 40.h,
                          controller: phoneNumber,
                          keyboardType: TextInputType.number,
                          isSecret: false,
                          ispass: false,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11)
                          ],
                          name: 'Phone Number',
                          val: (value) {
                            if (value.trim().isEmpty) {
                              return 'field required';
                            } else {}
                          },
                        ),
                        10.heightBox,
                        InkWell(
                          onTap: () {
                            if (myKey.currentState!.validate()) {
                              updateData();
                            } else {}
                          },
                          child: Container(
                            height: 25.h,
                            width: 70.w,
                            decoration: BoxDecoration(
                                color: AppColors.bottomColor,
                                borderRadius: BorderRadius.circular(10.h)),
                            child: Center(
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
