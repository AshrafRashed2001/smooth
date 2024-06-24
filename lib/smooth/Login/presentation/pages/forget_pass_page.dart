import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';

class ForgetPassPage extends StatefulWidget {
  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  void sendPassReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controller.text)
          .then((value) {
        AppSnakBarMessages.snakbarSuccessMesage(
            context: context, message: 'Success');
      });
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
      body: Form(
        key: myKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'forgot password',
              style: TextStyle(
                  fontSize: 30.sp,
                  color: AppColors.bottomColor,
                  fontWeight: FontWeight.bold),
            ),
            80.heightBox,
            FieldGeneralWidget(
              controller: controller,
              isSecret: false,
              ispass: false,
              name: 'email@gmail.com',
              val: (value) {
                if (value.trim().isEmpty) {
                  return 'email empty';
                } else {
                  
                }
              },
            ),
            10.heightBox,
            BottomWidget(
              isLoading: false,
              name: 'Next',
              onTap: () {
                if (myKey.currentState!.validate()) {
                  sendPassReset();
                } else {
                  
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
