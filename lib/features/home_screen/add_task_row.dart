


      import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tack/core/widgets/custom_app_buttom.dart';



class AddTaskRow extends StatelessWidget {
  final void Function()?onPressed;
        const AddTaskRow({super.key, this.onPressed});

        @override
        Widget build(BuildContext context) {
          return  Row(
            children: [
              Expanded(child: Column(
                children: [
                  Text(
                    DateFormat.MMMEd().format(DateTime.now()),style: TextStyle(fontSize: 20.sp),),

                ],

              )),
              SizedBox(
                  width: 150.w ,
                  child: CustomAppButtom(text: " + Add Task",onPressed: onPressed

                  ))
]
          );
        }
      }
