import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tack/task_app.dart';

import 'core/app_constants.dart';
import 'features/home/model/user_model.dart';

    void main()async{
   await   Hive.initFlutter();
   Hive.registerAdapter(UserModelAdapter());
    await Hive.openBox<UserModel>(AppConstants.userBox);

       runApp(TaskApp());


    }