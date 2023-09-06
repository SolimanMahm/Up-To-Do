import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskComponent extends StatelessWidget {
  AddTaskComponent({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    this.suffixIcon,
    this.readOnly = false,
    this.width = 327,
    this.height = 48,
    this.validator,
  });

  final String title, hint;
  final IconButton? suffixIcon;
  final bool readOnly;
  final TextEditingController? controller;
  final double width, height;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: width.w,
          height: height.h,
          child: TextFormField(
            readOnly: readOnly,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: suffixIcon,
            ),
            style: Theme.of(context).textTheme.displaySmall,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
