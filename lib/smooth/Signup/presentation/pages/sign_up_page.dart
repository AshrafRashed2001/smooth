import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth/core/Firebase/fire_base_helper.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';
import 'package:smooth/smooth/Login/presentation/pages/log_in_page.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController idNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController carNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  File? image;
  String? imageUrl;
  void signUpNow({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) async {
        DatabaseReference reference =
            FirebaseDatabase.instance.ref('users/${value.user!.uid}');
        await reference.set({
          'email': email.text,
          'license_plate': carNumber.text,
          'national_id': idNumber.text,
          'phonenumber': phoneNumber.text,
          'profile_picture': imageUrl ?? '',
          'first_name': firstName.text,
          'last_name': lastName.text,
          'credit': 0
        }).then((_) {
          AppSnakBarMessages.snakbarSuccessMesage(
              context: context, message: 'Success');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);
        });
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      AppSnakBarMessages.snakbarErrorMesage(
          context: context, message: e.toString());
    }
  }

  void addPhoto() async {
    await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      if (value != null) {
        image = File(value.path);
        setState(() {});
        await FirebaseHelper.uploadImage(file: File(value.path)).then((value) {
          imageUrl = value;
          setState(() {});
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/images/background.png'),
            ],
          ),
          SizedBox(
            height: 130.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageUrl == null
                    ? CircleAvatar(
                        radius: 28.h,
                        backgroundColor: AppColors.bottomColor,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                addPhoto();
                              },
                              icon: Icon(
                                Icons.person,
                                size: 22.h,
                                color: Colors.white,
                              )),
                        ),
                      )
                    : CircleAvatar(
                        radius: 28.h,
                        backgroundImage: NetworkImage(imageUrl!),
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Image.asset(
                    'assets/images/splash.png',
                    height: 120.h,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Form(
              key: myKey,
              child: Center(
                child: Column(
                  children: [
                    100.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Create an account',
                          style: TextStyle(
                              fontSize: 17.sp, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    8.heightBox,
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: firstName,
                      isSecret: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
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
                        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]'))
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
                        inputFormatters: [LengthLimitingTextInputFormatter(14)],
                        isSecret: false,
                        ispass: false,
                        name: 'ID Number',
                        val: (value) {
                          if (value.trim().isEmpty) {
                            return 'field required';
                          } else if (value.length != 14) {
                            return 'Please enter a 14-digit number'; // رسالة خطأ إذا لم يكن الطول 14 رقمًا
                          }
                        }),
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: carNumber,
                      isSecret: false,
                      ispass: false,
                      name: 'Car Number',
                      val: (value) {
                        if (value.trim().isEmpty) {
                          return 'field required';
                        } else if (!RegExp(r'^[\u0621-\u064A0-9]{1,7}$')
                            .hasMatch(value)) {
                          return 'The car number must be Arabic letters and numbers only and cannot exceed 7 characters';
                        }
                      },
                    ),
                    // يحتوي علي ارقام عربي وحروف عربي فقط
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: phoneNumber,
                      keyboardType: TextInputType.number,
                      isSecret: false,
                      ispass: false,
                      inputFormatters: [LengthLimitingTextInputFormatter(11)],
                      name: 'Phone Number',
                      val: (value) {
                        if (value.trim().isEmpty) {
                          return 'field required';
                        } else if (value.trim().length != 11) {
                          return 'Phone number must be 11 digits';
                        }
                      },
                    ),
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: email,
                      isSecret: false,
                      ispass: false,
                      name: 'Email',
                      val: (value) {
                        if (value.trim().isEmpty) {
                          return 'field required';
                        } else {}
                      },
                    ),
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: password,
                      isSecret: true,
                      ispass: true,
                      name: 'Password',
                      val: (value) {
                        if (value.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        } else if (!RegExp(
                                r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&]).{6,}$')
                            .hasMatch(value)) {
                          return 'Password must include letters, numbers, and symbols';
                        }
                      },
                    ),
                    FieldGeneralWidget(
                      height: 40.h,
                      controller: confirmPassword,
                      isSecret: true,
                      ispass: true,
                      name: 'Re-enter Password',
                      val: (value) {
                        if (password.text != confirmPassword.text) {
                          return 'wrong password';
                        } else {}
                      },
                    ),
                    BottomWidget(
                      isLoading: false,
                      name: 'Sign up now',
                      onTap: () {
                        if (myKey.currentState!.validate()) {
                          signUpNow(context: context);
                        } else {}
                      },
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'do you have an account?',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkprimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
