import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 8.w,
            top: 5.h,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 3.0,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 5.0.h, bottom: 8.h, left: 2.w, right: 2.w),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20.h,
                          child: Center(
                            child: Text(
                              "Exam Section",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: SectionDesign(text: "Weekly Model Test"),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("GestureDetextor worked");
                                },
                                child: SectionDesign(text: "BCS Preparation"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: SectionDesign(text: "Job Solution"),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: SectionDesign(
                                    text: "9th grade preparation"),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: SectionDesign(text: "Subject Care"),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: SectionDesign(text: "Bank job"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionDesign extends StatelessWidget {
  final String text;
  SectionDesign({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 8.h),
      child: Container(
        height: 30.h,
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
            ]),
        child: Center(
          child: FittedBox(
              child: Text(text,
                  maxLines: 2, style: Theme.of(context).textTheme.titleSmall)),
        ),
      ),
    );
  }
}
