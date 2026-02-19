


     import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../auth/model/user_model.dart';

class HomeAppbar extends StatelessWidget {
  final String name;
       const HomeAppbar({super.key, UserModel? userData, required this.name});

       @override
       Widget build(BuildContext context) {
         return  Row(
           children: [
             Expanded(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("george",style: TextStyle(fontSize: 20.sp),),
                   Text("Hive a nice day ",style: TextStyle(fontSize: 15.sp),)
                 ],
               ),
             ),
             CircleAvatar(
               radius: 40.r,
               backgroundImage: Image.file(File(Hive.box<UserModel>("user").getAt(0)?.image??"")).image,
             )
           ],
         );
       }
     }
