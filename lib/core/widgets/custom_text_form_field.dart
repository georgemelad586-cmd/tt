import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? nameController;
  final String hintText;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool? readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    this.nameController,
    required this.hintText,
    this.maxLines,
    this.suffixIcon,
    this.readOnly,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      controller: nameController,
      onTap: onTap,
      validator: validator,
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: Colors.indigo.withOpacity(0.5), fontSize: 14.sp),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: Colors.indigo,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
