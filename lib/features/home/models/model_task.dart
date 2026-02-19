


 import 'package:flutter/material.dart';

class ModelTask {
    String title;
    String startTime;
    String endTime;
    Color color;
    String description;
    String statusText;
         ModelTask({required this.title,required this.startTime,required this.endTime,
           required this.color,required this.description,required this.statusText});


 }

       List<ModelTask> tasks=[
         ModelTask(title: "task1", startTime: "02:33", endTime: "03:33", description: "I will Task Done", color: Colors.indigo, statusText: "Done"),
       ModelTask(title: "task2", startTime: "12:33", endTime: "13:33", description: "I will Task Done", color: Colors.green, statusText: "Done"),
        ModelTask(title: "task3", startTime: "02:33", endTime: "03:33", description: "I will Task Done", color: Colors.yellow, statusText: "Done"),

        ];