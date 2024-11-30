import 'package:eduasses360/View/home_page/section_design.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamSectionDesign extends StatelessWidget {
  const ExamSectionDesign({super.key});

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
                "Exam Section",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 22
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      const examType = "weekly_model_test";
                      Navigator.pushNamed(context, RouteName.adminModelTestPage,arguments: examType);
                    },
                    child: const SectionDesign(text: "Weekly Model Test"),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print("GestureDetextor worked");
                      }
                    },
                    child: const SectionDesign(text: "BCS Preparation"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "Job Solution"),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: const SectionDesign(text: "9th grade preparation"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      const examType = "subject_care";
                      Navigator.pushNamed(context, RouteName.adminModelTestPage,arguments: examType);
                    },
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

