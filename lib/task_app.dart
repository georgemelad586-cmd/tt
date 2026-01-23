

    import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tack/features/splash/splash_screen.dart';

class TaskApp extends StatelessWidget {
      const TaskApp({super.key});

      @override
      Widget build(BuildContext context) {
        return ScreenUtilInit
          (designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              home: SplashScreen(),
            ));
      }
    }
