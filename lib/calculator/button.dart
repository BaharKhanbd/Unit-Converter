import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonIcon extends StatelessWidget {
  final String title;
  final VoidCallback onpased;

  const ButtonIcon({
    super.key,
    required this.title,
    required this.onpased,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: InkWell(
          onTap: onpased,
          child: Container(
            height: 60.h,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Center(
                child: Text(
              title,
              style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}
