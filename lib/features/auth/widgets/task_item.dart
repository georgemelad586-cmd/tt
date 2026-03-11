import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/models/model_task.dart';

class TaskItem extends StatelessWidget {
  final ModelTask task;
  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = task.statusText == 'completed';
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(task.color).withOpacity(isCompleted ? 0.6 : 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  task.description,
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            width: 1.w,
            height: 60.h,
            color: Colors.white.withOpacity(0.5),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              isCompleted ? "COMPLETED" : "TODO",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
