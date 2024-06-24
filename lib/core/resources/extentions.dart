import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension HeightExtensionBox on num {
  Widget get widthBox => SizedBox(
    width: w,
  );

  Widget get heightBox => SizedBox(
    height:  h,
  );
}


extension MediaQueryVales on BuildContext{

  double get height => MediaQuery.of(this).size.height;

   double get width => MediaQuery.of(this).size.width;
}
