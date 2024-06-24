import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';
import 'package:smooth/smooth/Home/presentation/pages/home_page.dart';
import 'package:smooth/smooth/Home/presentation/pages/how_to_page.dart';
import 'package:smooth/smooth/Login/presentation/pages/forget_pass_page.dart';
import 'package:smooth/smooth/Signup/presentation/pages/sign_up_page.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((value) {
        SharedHelper.setstring(key: 'UID', value: value.user!.uid);
        SharedHelper.setstring(key: 'EMAIL', value: value.user!.email!);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      AppSnakBarMessages.snakbarErrorMesage(
          context: context, message: e.message!);
    } catch (e) {
      // ignore: use_build_context_synchronously
      AppSnakBarMessages.snakbarErrorMesage(
          context: context, message: e.toString());
    }
  }

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  GlobalKey<FormState> myKey = GlobalKey<FormState>();

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
          SingleChildScrollView(
            child: Form(
              key: myKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HowToPage(),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Row(
                        children: [Image.asset('assets/images/Frame 7.png')],
                      ),
                    ),
                  ),
                  150.heightBox,
                  Text(
                    'Welcome to',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xff0061B2)),
                  ),
                  Text(
                    'Smooth Passage',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xff0061B2)),
                  ),
                  Text(
                    'A new experience in comfort',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  FieldGeneralWidget(
                    controller: email,
                    isSecret: false,
                    ispass: false,
                    name: 'email@gmail.com',
                    val: (value) {
                      if (value.trim().isEmpty) {
                        return 'field required';
                      } else {}
                    },
                  ),
                  FieldGeneralWidget(
                    controller: password,
                    isSecret: true,
                    ispass: true,
                    name: '****************',
                    val: (value) {
                      if (value.trim().isEmpty) {
                        return 'field required';
                      } else {}
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgetPassPage(),
                                ));
                          },
                          child: Text(
                            'forget password?',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.darkprimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BottomWidget(
                    isLoading: false,
                    name: 'Login',
                    onTap: () {
                      if (myKey.currentState!.validate()) {
                        login(context: context);
                      } else {}
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                          (route) => false);
                    },
                    child: Text(
                      'Create an account',
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
        ],
      )),
    );
  }
}
