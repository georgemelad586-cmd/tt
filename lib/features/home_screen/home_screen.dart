import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../auth/model/user_model.dart';
import 'tasks_list_view.dart';
import '../add_task/add_task_screen.dart';
import 'add_task_row.dart';
import 'home_appbar.dart';
import '../../core/app_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box<UserModel>(AppConstants.userBox);
    UserModel? userData;
    if (userBox.isNotEmpty) userData = userBox.getAt(0);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (userData != null) HomeAppbar(userData: userData),
              SizedBox(height: 20.h),
              AddTaskRow(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddTaskScreen()),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildFilterButton('All'),
                  _buildFilterButton('To Do'),
                  _buildFilterButton('Completed'),
                ],
              ),
              SizedBox(height: 10.h),
              const Divider(),
              SizedBox(height: 10.h),
              Expanded(
                child: TasksListView(filter: selectedFilter),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title) {
    bool isSelected = selectedFilter == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = title;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.grey[200],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
