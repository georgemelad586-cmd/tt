import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_constants.dart';
import '../auth/widgets/task_item.dart';
import '../home/models/model_task.dart';

class TasksListView extends StatelessWidget {
  final String filter;
  const TasksListView({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<ModelTask>(AppConstants.taskBox).listenable(),
      builder: (context, Box<ModelTask> box, _) {
        List<ModelTask> tasks = box.values.toList();

        if (filter == 'To Do') {
          tasks = tasks.where((t) => t.statusText == 'toDo').toList();
        } else if (filter == 'Completed') {
          tasks = tasks.where((t) => t.statusText == 'completed').toList();
        }

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/empty loading state.json",
                  width: 250.w,
                  height: 250.h,
                ),
                SizedBox(height: 10.h),
                Text(
                  "No tasks yet",
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            var task = tasks[index];
            return Dismissible(
              key: Key(task.key.toString()),
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 10.w),
                    Text(
                      "Complete",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
              secondaryBackground: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Delete",
                      style: TextStyle(fontSize: 18.sp, color: Colors.white),
                    ),
                    SizedBox(width: 10.w),
                    const Icon(Icons.delete, color: Colors.white),
                  ],
                ),
              ),
              confirmDismiss: (direction) async {
                if (direction == DismissDirection.startToEnd) {
                  // Swiped to Complete
                  task.statusText = 'completed';
                  await task.save();
                  // Return false so the item isn't dismissed from the list
                  return false;
                }
                // Swiped to Delete, return true to allow dismissal
                return true;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  task.delete();
                }
              },
              child: TaskItem(task: task),
            );
          },
        );
      },
    );
  }
}
