import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

class StudentProfileProvider with ChangeNotifier{
  bool _isLoding = false;
  bool get isLoading => _isLoding;

 List<dynamic>? weakCategories;
  UserModel? studentData;
  String? userId;
  StudentProfileProvider(){
    userId = FirebaseAuth.instance.currentUser!.uid;
    fetchStudentData();
    fetchWeakCategories();
  }

  Future<void> fetchWeakCategories() async {

    final examsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('exams')
        .get();

     Map<String,dynamic>? weak = {};
    for (var exam in examsSnapshot.docs) {
      final maxWrongCategory = exam.data()['maxWrongCategory'];
      if(maxWrongCategory == '-1'){
        continue;
      }
      if (maxWrongCategory != null) {
        print("max wrong category : ${maxWrongCategory}");
        weak[maxWrongCategory] = (weak[maxWrongCategory] ?? 0) + 1;
      }
       weakCategories = weak.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
    }
    print("weak category : $weakCategories");
    notifyListeners();
  }

  Future<void> fetchStudentData() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
    final userData = userSnapshot.data();
    studentData = UserModel.fromJson(userData!);
print("user Snapshot : $userData");
    notifyListeners();
  }

  Future<void> saveUserData(String name, String dept, String institute) async {
    _isLoding = true;
    notifyListeners();

    UserModel student = UserModel(name: name, instituteName: institute, departmentName:dept);
    Map<String,dynamic> userJson = student.toJson();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userJson);
    await fetchStudentData();
    _isLoding = false;
    notifyListeners();
  }


}