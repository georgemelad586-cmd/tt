


 import 'package:flutter/material.dart';

class ModelTask {
    String title;
    String date;
    String startTime;
    String endTime;
    Color color;
    String description;
    String statusText;
         ModelTask({required this.title,required this.startTime,required this.endTime,
           required this.color,required this.description,required this.statusText,
           required this.date});


 }

       List<ModelTask> tasks=[
        ];