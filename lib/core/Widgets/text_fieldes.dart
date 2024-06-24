// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth/core/resources/extentions.dart';

class FieldGeneralWidget extends StatefulWidget {
  bool ispass;
  bool isSecret;
  int? maxlines;
  int? maxlenth;
  List<TextInputFormatter>? inputFormatters;
  String? hintText;
  TextInputType? keyboardType;
  String name;

  Function(String value) val;
  TextEditingController controller;
  Widget? iconPre;
  Widget? suffIcon;
  double? height;
  double? width;
  FieldGeneralWidget(
      {super.key,
      required this.controller,
      this.suffIcon,
      required this.isSecret,
      required this.ispass,
      this.hintText,
      this.inputFormatters,
      this.maxlines,
      this.width,
      this.height,
      this.keyboardType,
      this.maxlenth,
      this.iconPre,
      required this.name,
      required this.val});

  @override
  State<FieldGeneralWidget> createState() => _FieldGeneralWidgetState();
}

class _FieldGeneralWidgetState extends State<FieldGeneralWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: context.height * 0.008, horizontal: context.height * 0.02),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
          
          obscureText: widget.ispass,
          inputFormatters: widget.inputFormatters,
          controller: widget.controller,
          validator: (value) {
            return widget.val(value!);
          },
          minLines: 1,
          maxLength: widget.maxlenth,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxlines ?? 1,
          decoration: InputDecoration(
              prefixIcon: widget.iconPre ?? const SizedBox.shrink(),
              hintText: widget.name,
              label: Text(
                widget.name,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              suffixIcon: widget.suffIcon ?? Visibility(
                visible: widget.isSecret,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.ispass = !widget.ispass;
                      });
                    },
                    icon: Icon(widget.ispass
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined)),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Color(0xff0061B2))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0061B2)),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Color(0xff0061B2)))),
        ),
      ),
    );
  }
}
