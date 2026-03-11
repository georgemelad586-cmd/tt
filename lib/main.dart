import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tack/task_app.dart';

import 'core/app_constants.dart';
import 'features/auth/model/user_model.dart';
import 'features/home/models/model_task.dart';

    void main()async{
   await   Hive.initFlutter();
   Hive.registerAdapter(UserModelAdapter());
   Hive.registerAdapter(ModelTaskAdapter());
    await Hive.openBox<UserModel>(AppConstants.userBox);
    await Hive.openBox<ModelTask>(AppConstants.taskBox);


       runApp(TaskApp());


    }