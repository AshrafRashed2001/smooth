import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopWidget extends StatelessWidget {
  const PopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(13.h),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: const Color(
                0xff0061B2,
              ),
              borderRadius: BorderRadius.circular(15.h)),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              size: 18.h,
            ),
          ),
        ),
      ),
    );
  }
}