import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/SharedPref/shared_helper.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/core/utils/app_snakbars.dart';
import 'package:smooth/smooth/Complaints/presentation/pages/complaint_id_page.dart';
import 'package:smooth/smooth/Complaints/presentation/pages/done_send_page.dart';

class ComplaintsPage extends StatefulWidget {
  const ComplaintsPage({super.key});

  @override
  State<ComplaintsPage> createState() => _ComplaintsPageState();
}

class _ComplaintsPageState extends State<ComplaintsPage> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  void sendComplaints() async {
    try {
      DatabaseReference reference =
          FirebaseDatabase.instance.ref('complaints').push();
      await reference.set({
        'complaint': controller.text,
        'date_time': DateTime.now().toString(),
        'user_email': SharedHelper.getstring(key: 'EMAIL'),
        'user_name': SharedHelper.getstring(key: 'NAME'),
        'id': reference.key,
        'feedback': ''
      }).then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoneSendPage(
                id: reference.key!,
              ),
            ));
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
        leadingWidth: 70.w,
        leading: const PopWidget(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                  'assets/images/Black Red Minimalist Speed Car Logo (21) 1.png')
            ],
          ),
          SingleChildScrollView(
            child: Form(
              key: myKey,
              child: Column(
                children: [
                  200.heightBox,
                  Text(
                    'Complaints',
                    style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w800,
                        color: AppColors.bottomColor),
                  ),
                  50.heightBox,
                  FieldGeneralWidget(
                    controller: controller,
                    isSecret: false,
                    maxlines: 100,
                    ispass: false,
                    name: 'Complaints',
                    val: (value) {
                      if (value.trim().isEmpty) {
                        return 'value required';
                      } else {}
                    },
                  ),
                  20.heightBox,
                  InkWell(
                    onTap: () {
                      if (myKey.currentState!.validate()) {
                        sendComplaints();
                      } else {}
                    },
                    child: Container(
                      height: 25.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: AppColors.bottomColor,
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Center(
                        child: Text(
                          'Send',
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  30.heightBox,
                  BottomWidget(
                    isLoading: false,
                    name: 'inquiries',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComplaintID(),
                          ));
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
