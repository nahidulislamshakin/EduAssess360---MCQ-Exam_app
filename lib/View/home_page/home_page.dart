import 'package:eduasses360/View/home_page/exam_section.dart';
import 'package:eduasses360/View/home_page/study_section.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/view_model/homepage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final homeProver = Provider.of<HomePageViewModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
          backgroundColor: Colors.white70,
        title:  Text("EduAsses360",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(DateFormat.yMMMd().format(DateTime.now(),),
            style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),),
          )
        ],
      ),
      

      drawerEdgeDragWidth: deviceHeight/(1.5),
      drawerScrimColor: Colors.grey,
      drawer:Drawer(

        child: ListView(
          //padding: EdgeInsets.only(right: 30),
          children:[ DrawerHeader(
            child: Text("Welcome",style: Theme.of(context).textTheme.bodyLarge,),
          ),
            ListTile(
              onTap: () async {
                await homeProver.firebaseLogOut(context: context);
              },
              leading: const Icon(Icons.logout,color: Colors.black,size: 30,),
              title: Text("Logout",style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            ),
              ]
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.w,
            right: 8.w,
            top: 8.h,
          ),
          child: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 ExamSectionDesign(),
                SizedBox(height: 15),
                 StudySection(),
                

              ],
            ),
          ),
        ),
      ),
    );
  }
}


