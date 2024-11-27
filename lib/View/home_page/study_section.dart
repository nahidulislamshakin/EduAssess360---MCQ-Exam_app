import 'package:eduasses360/View/home_page/section_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudySection extends StatelessWidget {
  const StudySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.grey,
      color: Colors.white,
      child: Padding(
        padding:
            EdgeInsets.only(top: 5.0.h, bottom: 8.h, left: 2.w, right: 2.w),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            Center(
              child: Text(
                "Study Section",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 22
                ),
              ),
            ),
            SizedBox(
              height:5.h,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: const SectionDesign(text: "PDF Notes"),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: const SectionDesign(text: "Video Section"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "E-Book"),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "English Care"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "Subject Care"),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "Bank job"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}

