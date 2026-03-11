import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:tack/core/app_constants.dart';
import 'package:tack/features/auth/model/user_model.dart';
import 'package:tack/features/home_screen/home_screen.dart';

import '../auth/authScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      var userBox = Hive.box<UserModel>(AppConstants.userBox);
      
      // التحقق مما إذا كان هناك مستخدم مسجل مسبقاً في Hive
      if (userBox.isNotEmpty) {
        // إذا كان الصندوق غير فارغ، ننتقل مباشرة للشاشة الرئيسية
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else {
        // إذا كان الصندوق فارغاً، ننتقل لشاشة التسجيل
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/splash_image.json"),
            Text(
              "Taskati",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              "its time to organized",
              style: TextStyle(fontSize: 14.sp),
            )
          ],
        ),
      ),
    );
  }
}
