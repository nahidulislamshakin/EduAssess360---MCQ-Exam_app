import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/admin/exam_model.dart';
import '../model/admin/question_model.dart';

class ModelTestViewModel with ChangeNotifier{


  List<Exam>? _examsList;
  List<Exam>? get examsList => _examsList;

  List<Question>? _questionList;
  List<Question>? get questionList => _questionList;



  //fetching exam list from firebase
  Future<void> fetchExams(String type) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection('exams')
        .where('type', isEqualTo: type)
        .get();

    _examsList = snapshot.docs.map((doc) {
      return Exam.fromFirestore(doc);
    }).toList();
    notifyListeners();
    print(_examsList);
  }

  //fetch question from firebase using exam id
  Future<void> fetchQuestions(String examId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection('exams')
        .doc(examId)
        .collection('questions')
        .get();

    _questionList =  snapshot.docs.map((doc) {
      return Question.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

}