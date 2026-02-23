
  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tack/core/widgets/custom_app_buttom.dart';
import 'package:tack/features/home/models/model_task.dart';

import '../../core/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
    const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var formKey=GlobalKey<FormState>();
   List<Color>taskColors=[
     Colors.indigo,
     Colors.green,
     Colors.yellow,

];
 int activeIndex=0;
   var titleController=TextEditingController();
   var descriptionController=TextEditingController();
   var dateController=TextEditingController();
   var startTimeController=TextEditingController();
   var endTimeController=TextEditingController();
   String?date;
   String?startTime;
   String?endTime;


    @override
    Widget build(BuildContext context) {
      return Scaffold(
         appBar:AppBar(
           title: Text("Add Task",style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold,color: Colors.indigo),),
           centerTitle: true,
           iconTheme: IconThemeData(color: Colors.indigo),

         ) ,
        body:Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: [
                      Form(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        key: formKey,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 20.h,
                          children: [
                          Text("title",style: TextStyle(color: Colors.indigo,fontSize: 10.sp),),
                          CustomTextFormField(
                            nameController: titleController,
                            hintText: "Enter  Title",
                            validator: (value){
                              if(value==null||value.isEmpty){
                                return "please enter title";
                              }
                          }
                          ),
                          Text("Description",style: TextStyle(color: Colors.indigo,fontSize: 10.sp),),
                          CustomTextFormField(
                            nameController: descriptionController,
                            hintText: "Enter  Description",
                            maxLines: 4,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return "please enter description";
                                }}
                          ),
                          Text("Date",style: TextStyle(color: Colors.indigo,fontSize: 10.sp),),
                          CustomTextFormField(hintText:"Enter Date",
                              nameController: dateController,

                            suffixIcon: Icon(Icons.calendar_month,color: Colors.indigo,),
                            readOnly: true,
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return "please enter date";
                                }},
                            onTap: (){
                              showDatePicker(context: context,firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 365)),).then((d){
                                   date=DateFormat().add_MMMEd().format(d??DateTime.now()).toString();
                                dateController.text=date.toString();
                              }).catchError((e){



                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(child: CustomTextFormField(hintText: "start time",
                                    nameController: startTimeController,
                                suffixIcon: Icon(Icons.watch_later_outlined,color: Colors.indigo,),
                                readOnly: true,
                                onTap: (){
                                  showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time){
                                    startTime=time.toString();
                                    startTimeController.text=startTime.toString();
                                  }).catchError((e){

                                  });

                                },
                              validator: (value){
                                if(value==null||value.isEmpty){
                                  return "please enter start time";
                                }}
                              )
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(child: CustomTextFormField(hintText: "end time",
                                nameController: endTimeController,
                                suffixIcon: Icon(Icons.watch_later_outlined,color: Colors.indigo,),
                                readOnly: true,
                                onTap: (){
                                  showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time){
                                          endTime=time.toString();
                                          endTimeController.text=endTime.toString();
                                  }).catchError((e){




                                  });

                                },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "please enter end time";
                                    }
                                  }
                              )),
                            ],
                          ),
                        ],
                      )),
                        SizedBox(
                          height: 50.h,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context,index) => InkWell(
                                onTap: (){
                                  setState(() {
                                    activeIndex=index;
                                  });
                                },
                                child: CircleAvatar(
                                                            radius: 40.r,
                                                            backgroundColor: taskColors[index],
                                  child: activeIndex==index? Icon(Icons.check,color: Colors.white,size: 30.sp,):null,
                                                          ),
                              ), separatorBuilder: (context,index)=>SizedBox(width: 10.h,), itemCount: taskColors.length,
                          ),
                        ),
                
                
                
                

                CustomAppButtom(text: "Create Task",
                onPressed: (){

                              if( formKey.currentState?.validate()??false){
                                tasks.add(ModelTask(title: titleController.text,
                                    startTime: startTimeController.text, endTime: endTime??"",
                                    color: taskColors[activeIndex],
                                    description: descriptionController.text,  statusText: "TODo", date: dateController.text));
                                Navigator.pop(context);
                              }




                },
                )

















              ]
            ),
          ),
        ),

      );
    }
}
