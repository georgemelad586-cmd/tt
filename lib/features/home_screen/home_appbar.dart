import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_constants.dart';
import '../auth/model/user_model.dart';

class HomeAppbar extends StatefulWidget {
  final UserModel userData;

  const HomeAppbar({super.key, required this.userData});

  @override
  State<HomeAppbar> createState() => _HomeAppbarState();
}

class _HomeAppbarState extends State<HomeAppbar> {
  ImageProvider _getImageProvider(String path) {
    if (kIsWeb) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  Future<void> _changeProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      var userBox = Hive.box<UserModel>(AppConstants.userBox);
      UserModel updatedUser = UserModel(
        name: widget.userData.name,
        image: image.path,
      );
      await userBox.putAt(0, updatedUser);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<UserModel>(AppConstants.userBox).listenable(),
      builder: (context, Box<UserModel> box, _) {
        var user = box.getAt(0) ?? widget.userData;
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  Text(
                    "Have a nice day",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: _changeProfileImage,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 35.r,
                    backgroundColor: Colors.indigo.shade100,
                    backgroundImage: user.image.isNotEmpty
                        ? _getImageProvider(user.image)
                        : null,
                    child: user.image.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 12.r,
                      backgroundColor: Colors.indigo,
                      child: Icon(
                        Icons.edit,
                        size: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
