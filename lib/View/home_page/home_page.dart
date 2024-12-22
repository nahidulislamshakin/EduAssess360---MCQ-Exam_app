import 'package:eduasses360/View/admin_page/admin_home_page.dart';
import 'package:eduasses360/View/home_page/exam_section.dart';
import 'package:eduasses360/View/home_page/study_section.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/view_model/homepage_viewmodel.dart';
import 'package:eduasses360/view_model/loginPage_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../view_model/student_profile_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final homeProvider = Provider.of<HomePageViewModel>(context);
    final logProvider = Provider.of<LoginPageViewModel>(context);
    final studentProfileProvider = Provider.of<StudentProfileProvider>(context);

    return FirebaseAuth.instance.currentUser?.email == "admin@admin1221.com"
        ? AdminHomePage()
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              elevation: 25,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Colors.white70,
              title: Text(
                "EduAsses360",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 24),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    DateFormat.yMMMd().format(
                      DateTime.now(),
                    ),
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            drawerEdgeDragWidth: deviceHeight / (1.5),
            drawerScrimColor: Colors.grey,
            drawer: Drawer(
              child: ListView(
                  //padding: EdgeInsets.only(right: 30),
                  children: [
                    DrawerHeader(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteName.studentProfilePage);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             SizedBox(
                              height: 4.h,
                            ),
                            ClipOval(
                              child: Image.asset(
                                "assets/images/no_person.jpg",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                             SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              studentProfileProvider.studentData?.name
                                      .toString() ??
                                  '',
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      trailing: const Icon(
                        Icons.keyboard_arrow_right_outlined,
                        color: Colors.black,
                        size: 25,
                      ),
                      onTap: () async {
                        await logProvider.firebaseLogOut(context: context);
                      },
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.black,
                        size: 25,
                      ),
                      title: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10.r),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      const ExamSectionDesign(),
                      const SizedBox(height: 25),
                      const StudySection(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
