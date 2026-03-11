



import 'package:hive/hive.dart';
part 'model_task.g.dart';
 @HiveType(typeId: 1)
class ModelTask extends HiveObject{
    @HiveField(0)
    String title;
    @HiveField(1)
    String date;
    @HiveField(2)
    String startTime;
    @HiveField(3)
    String endTime;
    @HiveField(4)
    int color;
    @HiveField(5)
    String description;
    @HiveField(6)
    String statusText;
         ModelTask({required this.title,required this.startTime,required this.endTime,
           required this.color,required this.description,required this.statusText,
           required this.date});


 }

       List<ModelTask> tasks=[
        ];