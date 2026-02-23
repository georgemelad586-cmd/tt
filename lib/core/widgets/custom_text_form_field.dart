

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? nameController ;
  final String hintText;
  final int? maxLines;
     final Widget?suffixIcon;
     final bool?readOnly;
 final void Function()?onTap;
 final String? Function(String?)?validator;


  const CustomTextFormField({super.key, this.nameController, required this.hintText, this.maxLines, this.suffixIcon, this.readOnly, this.onTap, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      readOnly: readOnly??false,
      controller: nameController ,
      onTap: onTap,
      validator:validator ,
      onTapOutside: (v){
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(

          hintText: hintText,
          suffixIcon:suffixIcon,

          hintStyle: TextStyle(color: Colors.indigo),
          enabledBorder: OutlineInputBorder(),
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.indigo,
              )
          )


      ),

    );
  }
}


