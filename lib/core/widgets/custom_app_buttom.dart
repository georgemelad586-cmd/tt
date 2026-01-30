



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppButtom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomAppButtom({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        minimumSize: Size(double.infinity.w, 60.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r)
        )

    ),
        onPressed: onPressed, child: Text( text,style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold
        ),))
    ;
  }
}
