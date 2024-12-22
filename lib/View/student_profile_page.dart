import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../view_model/student_profile_view_model.dart';

class StudentProfilePage extends StatefulWidget {
  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  String? name = "Nahidul Islam Shakin";

  TextEditingController nameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController instituteController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    final studentProfileProvider =
        Provider.of<StudentProfileProvider>(context, listen: false);
    studentProfileProvider.fetchStudentData();
    studentProfileProvider.fetchWeakCategories();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    departmentController.dispose();
    instituteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentProfileProvider = Provider.of<StudentProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                    left: 20, right: 10, top: 10, bottom: 10),
                //color: Colors.black12,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade50,
                    Colors.white,
                    Colors.blue.shade50
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (studentProfileProvider.studentData?.name == null &&
                          studentProfileProvider.studentData?.departmentName ==
                              null &&
                          studentProfileProvider.studentData?.instituteName ==
                              null)
                        Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Name :   ",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please enter your name";
                                        }
                                        return null;
                                      },
                                      controller: nameController,
                                      onTapOutside: (_) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: "Enter your name here",
                                        labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Department :   ",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please enter your department name";
                                        }
                                        return null;
                                      },
                                      controller: departmentController,
                                      onTapOutside: (_) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                      ),
                                      decoration: InputDecoration(
                                        labelText:
                                            "Enter your department name here",
                                        labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Institute :   ",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextFormField(
                                      maxLines: 2,
                                      validator: (value) {
                                        if (value.toString().isEmpty) {
                                          return "Please enter your institute name";
                                        }
                                        return null;
                                      },
                                      controller: instituteController,
                                      onTapOutside: (_) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12.sp,
                                      ),
                                      decoration: InputDecoration(
                                        labelText:
                                            "Enter your institute name here",
                                        labelStyle: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              studentProfileProvider.isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.black54,
                                      ),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () async {
                                        await studentProfileProvider
                                            .saveUserData(
                                                nameController.text,
                                                departmentController.text,
                                                instituteController.text);
                                      },
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      if (studentProfileProvider.studentData != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              studentProfileProvider.studentData?.name ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              studentProfileProvider
                                      .studentData?.departmentName ??
                                  "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              studentProfileProvider
                                      .studentData?.instituteName ??
                                  "",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.sp,
                              ),
                            ),

                            const SizedBox(height: 5,),
                            //Divider(color: Colors.black54,height: 2,),
                            const SizedBox(height: 10,),

                            Row(
                              children: [
                                Icon(Icons.analytics_outlined,color: Colors.green,),
                                const SizedBox(width: 5,),

                                Text("Exam Analysis",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp,color: Colors.black),),
                              ],
                            ),
                            const SizedBox(height: 5,),

                            Row(
                              children: [
                                const SizedBox(width: 30,),

                                Text("Your weakest category :  ${studentProfileProvider.weakCategories?[0].key}",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,color: Colors.black54,),),
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/no_person.jpg",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
