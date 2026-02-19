




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/models/model_task.dart';

class TaskItem extends StatelessWidget {
  final ModelTask task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: task.color,
          ),
       child:Row(

         children: [
           Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
             spacing: 10.h,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                      Text(task.title,style: TextStyle(fontSize: 20.sp,color: Colors.white,),),
                        Text("${task.startTime} - ${task.endTime}",style: TextStyle(fontSize: 15.sp,color: Colors.white,),),
                            Text(task.description,style: TextStyle(fontSize: 15.sp,color: Colors.white,),)
                 ]

               ),
           ),
           SizedBox(width: 300,),
           Container(
             width: 2.w,
             height: 100.h,
             color: Colors.white,
           ),
            RotatedBox(
                quarterTurns: 3,
                child: Text("To Do",style: TextStyle(fontSize: 20.sp,color: Colors.white,),))

         ]
       ) ,
      ),
    );
  }
}
