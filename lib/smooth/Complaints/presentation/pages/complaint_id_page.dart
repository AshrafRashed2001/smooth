import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/Widgets/bottom_widget.dart';
import 'package:smooth/core/Widgets/pop_widget.dart';
import 'package:smooth/core/Widgets/text_fieldes.dart';
import 'package:smooth/core/resources/app_colors.dart';
import 'package:smooth/core/resources/extentions.dart';
import 'package:smooth/smooth/Complaints/presentation/pages/feedback_page.dart';

class ComplaintID extends StatefulWidget {
  const ComplaintID({super.key});

  @override
  State<ComplaintID> createState() => _ComplaintIDState();
}

class _ComplaintIDState extends State<ComplaintID> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter complaint-id',
                  style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bottomColor),
                ),
              ],
            ),
            50.heightBox,
            FieldGeneralWidget(
              controller: controller,
              isSecret: false,
              ispass: false,
              name: 'ID',
              val: (value) {
                if (value.trim().isEmpty) {
                  return 'empty field';
                } else {}
              },
            ),
            50.heightBox,
            BottomWidget(
              isLoading: false,
              name: 'SUBMIT',
              onTap: () {
                if (myKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedBackPage(id: controller.text),
                      ));
                } else {}
              },
            )
          ],
        ),
      ),
    );
  }
}
