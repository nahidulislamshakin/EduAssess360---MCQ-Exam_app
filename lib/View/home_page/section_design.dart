import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionDesign extends StatelessWidget {
  final String text;
  const SectionDesign({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(5.r),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 7),
                  blurRadius: 5.r,
                  spreadRadius: 0.1.r)
            ],),
        child: Center(
          child: FittedBox(
              child: Text(text,
                  maxLines: 2, style: Theme.of(context).textTheme.titleSmall),),
        ),
      ),
    );
  }
}
