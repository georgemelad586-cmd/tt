import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tack/core/widgets/custom_text_form_field.dart';
import '../../core/app_constants.dart';
import '../../core/widgets/custom_app_buttom.dart';
import '../home_screen/home_screen.dart';
import 'model/user_model.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController nameController = TextEditingController();

  void openCamera() async {
    image = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void openGallery() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 100.h, left: 20.w, right: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
                visible: image == null,
                child: CircleAvatar(
                  radius: 100.r,
                  child: Icon(
                    Icons.person,
                    size: 50.sp,
                  ),
                ),
                replacement: Container(
                  width: 200.w,
                  height: 200.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: image != null
                        ? DecorationImage(
                            image: kIsWeb
                                ? NetworkImage(image!.path)
                                : FileImage(File(image!.path)) as ImageProvider,
                            fit: BoxFit.cover)
                        : null,
                  ),
                )),
            SizedBox(height: 20.h),
            CustomAppButtom(
              text: "up load from camera",
              onPressed: () {
                openCamera();
              },
            ),
            SizedBox(height: 20.h),
            CustomAppButtom(
              text: "up load from gallery",
              onPressed: () {
                openGallery();
              },
            ),
            SizedBox(height: 20.h),
            const Divider(
              color: Colors.indigo,
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              nameController: nameController,
              hintText: "Enter Your Name",
            ),
            SizedBox(height: 20.h),
            CustomAppButtom(
              text: "Done",
              onPressed: () {
                if (nameController.text.isNotEmpty && image != null) {
                  Hive.box<UserModel>(AppConstants.userBox)
                      .add(UserModel(
                          name: nameController.text, image: image?.path ?? ""))
                      .then((value) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }).catchError((e) {
                    print(e);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter your name and upload an image")),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
