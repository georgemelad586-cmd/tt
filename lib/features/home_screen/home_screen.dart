
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:tack/core/app_constants.dart';
import 'package:tack/features/home_screen/add_task_row.dart';
import '../add_task/add_task_screen.dart';
import '../auth/model/user_model.dart';
import '../auth/widgets/task_item.dart';
import '../home/models/model_task.dart';
import 'home_appbar.dart';

class HomeScreen extends StatefulWidget {
     const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
     @override
     Widget build(BuildContext context) {
       var userData=Hive.box<UserModel>(AppConstants.userBox).getAt(0);
       return Scaffold(
           body: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               children: [
                 if(userData!=null)
                HomeAppbar(userData : userData, name: '',),
                 SizedBox(height: 20.h,),
                 AddTaskRow(
                   onPressed: ()async{
                    await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTaskScreen()));
                              setState(() {

                    });

                   }
                 ),
                 SizedBox(height: 20.h,),
                 Expanded(
                     child:tasks.isEmpty  ? Lottie.asset("assets/empty loading state.json"): ListView.separated(itemBuilder:(context,index)=>Dismissible(
                         key: UniqueKey(),
                         child: TaskItem(
                           task: tasks[index],
                         )), separatorBuilder:
                     (context,index)=>SizedBox(height: 10.h,)

                         , itemCount:tasks.length,
                   )


                   )


               ]
             ),
           ),



       );
     }
}
