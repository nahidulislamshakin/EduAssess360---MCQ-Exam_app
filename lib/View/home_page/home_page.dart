import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String?> fetchWeakestCategory(String userId) async {
    final examsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('exams')
        .get();

    Map<String, int> categoryMistakes = {};

    for (var exam in examsSnapshot.docs) {
      final maxWrongCategory = exam.data()['maxWrongCategory'];
      if(maxWrongCategory == '-1'){
        continue;
      }
      if (maxWrongCategory != null || maxWrongCategory.toString().isNotEmpty) {
        categoryMistakes[maxWrongCategory] = (categoryMistakes[maxWrongCategory] ?? 0) + 1;
      }
    }

    if (categoryMistakes.isEmpty) return null;

    print(categoryMistakes.entries.toList()..sort((a, b) => b.value.compareTo(a.value)));
    // Find the category with the highest mistakes
    return categoryMistakes.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  String suggestionTitle = "";
  Future<String> fetchSuggestions(String category) async {
    final suggestionSnapshot = await FirebaseFirestore.instance
        .collection('suggestions')
        .doc(category)
        .get();

    if (!suggestionSnapshot.exists) return "";

    final data = suggestionSnapshot.data();
    print(data?['description']);
    suggestionTitle = data?["title"];
    return (data?['description']);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final homeProvider = Provider.of<HomePageViewModel>(context);
    final logProvider = Provider.of<LoginPageViewModel>(context);
    final studentProfileProvider = Provider.of<StudentProfileProvider>(context);

    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

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
          children: [
            DrawerHeader(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.studentProfilePage);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    ClipOval(
                      child: Image.asset(
                        "assets/images/no_person.jpg",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      studentProfileProvider.studentData?.name.toString() ?? '',
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
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.r),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(height: 10.h),
                const ExamSectionDesign(),
                const SizedBox(height: 25),
                const StudySection(),
                const SizedBox(height: 25),
                FutureBuilder<String?>(
                  future: fetchWeakestCategory(userId),
                  builder: (context, weakCategorySnapshot) {
                    if (weakCategorySnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final weakCategory = weakCategorySnapshot.data;

                    if (weakCategory == null) {
                      return const Center(
                        child: Text("No weak category identified."),
                      );
                    }

                    return FutureBuilder(
                      future: fetchSuggestions(weakCategory),
                      builder: (context, suggestionSnapshot) {
                        if (suggestionSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final suggestions = suggestionSnapshot.data ?? "";

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Suggestions for Improvement (${weakCategory})",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            if (suggestions.toString().isEmpty)
                              const Text("No suggestions available.")
                            else

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(suggestionTitle,
                                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Colors.black),),

                                          const SizedBox(height: 5,),
                                          Text(suggestions,
                                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal,color: Colors.black),),
                                          const SizedBox(height: 15,)
                                        ],
                                      ),
                                    ),

                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

