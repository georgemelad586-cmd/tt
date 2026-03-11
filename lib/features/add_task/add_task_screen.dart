import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tack/core/widgets/custom_app_buttom.dart';
import 'package:tack/features/home/models/model_task.dart';

import '../../core/app_constants.dart';
import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey = GlobalKey<FormState>();
  List<Color> taskColors = [
    Colors.indigo,
    Colors.green,
    Colors.orange,
  ];
  int activeIndex = 0;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var startTimeController = TextEditingController();
  var endTimeController = TextEditingController();
  String? date;
  String? startTime;
  String? endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.indigo),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.indigo),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(color: Colors.indigo, fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                            nameController: titleController,
                            hintText: "Enter Title",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter title";
                              }
                              return null;
                            }),
                        SizedBox(height: 16.h),
                        Text(
                          "Description",
                          style: TextStyle(color: Colors.indigo, fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                            nameController: descriptionController,
                            hintText: "Enter Description",
                            maxLines: 4,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please enter description";
                              }
                              return null;
                            }),
                        SizedBox(height: 16.h),
                        Text(
                          "Date",
                          style: TextStyle(color: Colors.indigo, fontSize: 14.sp),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          hintText: "Enter Date",
                          nameController: dateController,
                          suffixIcon: const Icon(
                            Icons.calendar_month,
                            color: Colors.indigo,
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please enter date";
                            }
                            return null;
                          },
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 365)),
                            ).then((d) {
                              if (d != null) {
                                date = DateFormat.yMMMd().format(d);
                                dateController.text = date!;
                              }
                            });
                          },
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Start Time",
                                    style: TextStyle(
                                        color: Colors.indigo, fontSize: 14.sp)),
                                SizedBox(height: 8.h),
                                CustomTextFormField(
                                    hintText: "Start time",
                                    nameController: startTimeController,
                                    suffixIcon: const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.indigo,
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((time) {
                                        if (time != null) {
                                          startTime = time.format(context);
                                          startTimeController.text = startTime!;
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter start time";
                                      }
                                      return null;
                                    }),
                              ],
                            )),
                            SizedBox(width: 10.w),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("End Time",
                                    style: TextStyle(
                                        color: Colors.indigo, fontSize: 14.sp)),
                                SizedBox(height: 8.h),
                                CustomTextFormField(
                                    hintText: "End time",
                                    nameController: endTimeController,
                                    suffixIcon: const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.indigo,
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((time) {
                                        if (time != null) {
                                          endTime = time.format(context);
                                          endTimeController.text = endTime!;
                                        }
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "please enter end time";
                                      }
                                      return null;
                                    }),
                              ],
                            )),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        radius: 25.r,
                        backgroundColor: taskColors[index],
                        child: activeIndex == index
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20.sp,
                              )
                            : null,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      width: 10.h,
                    ),
                    itemCount: taskColors.length,
                  ),
                ),
                SizedBox(height: 30.h),
                CustomAppButtom(
                  text: "Create Task",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Hive.box<ModelTask>(AppConstants.taskBox).add(ModelTask(
                          title: titleController.text,
                          startTime: startTimeController.text,
                          endTime: endTimeController.text,
                          color: taskColors[activeIndex].value,
                          description: descriptionController.text,
                          statusText: "toDo",
                          date: dateController.text));

                      Navigator.pop(context);
                    }
                  },
                )
              ]),
        ),
      ),
    );
  }
}
