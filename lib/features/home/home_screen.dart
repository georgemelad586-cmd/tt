
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/app_constants.dart';
import '../../core/widgets/custom_app_buttom.dart';
import 'model/user_model.dart';
class HomeScreen extends StatefulWidget {
      const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final user=Hive.box<UserModel>(AppConstants.userBox).getAt(0);

  final ImagePicker picker = ImagePicker();
  XFile? image;
  TextEditingController nameController = TextEditingController();

  void openCamera()async{
  image = await picker.pickImage(source: ImageSource.camera);
    setState(() {

    });

  }
  void openGallery()async{
  image =  await picker.pickImage(source: ImageSource.gallery);
   setState(() {

   });
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: SingleChildScrollView(
                padding:  EdgeInsets.only(top: 100.h,left: 20.w,right: 20.w),
                child: Column(
                  spacing: 20.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: image==null,
                      child: CircleAvatar(
                      radius: 100.r,
                      child: Icon(Icons.person,size: 50.sp,),
                    ),
                      replacement: Container(
                        width: 200.w,
                        height: 200.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image:DecorationImage(image: Image.file(File(image?.path??"")).image,fit: BoxFit.cover
                              ),
                        ),
                      )
                    ),
                    CustomAppButtom(
                         text: "up load from camera",
                         onPressed: () {
                             openCamera();

                         },
                       ),
                    CustomAppButtom(
                      text: "up load from gallery",
                      onPressed: ()  {
                        openGallery();
                      },
                    ),
                           Divider(
                             color: Colors.indigo,
                           ),
                    TextFormField(
                      controller: nameController ,
                      onTapOutside: (v){
                         FocusScope.of(context).unfocus();
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.indigo,

                              )
                            )

                      ),

                    ),
                      CustomAppButtom(text: "Done"
                      ,onPressed:(){
                        print("user ${user?.name}");
                        Hive.box<UserModel>(AppConstants.userBox).add(UserModel(name: nameController.text,
                            image: image?.path??"")).then((value){
                          print("done");
                        })
                        .catchError((e){
                          print(e);
                        });

                        } ,),
                    Text(user?.name??"",),
                    Image.file(File(user?.image??"")),

                  ],
                ),
              ),
            );
      }
}
