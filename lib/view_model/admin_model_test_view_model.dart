import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/admin/exam_model.dart';
import '../model/admin/question_model.dart';

class AdminModelTestViewModel with ChangeNotifier{


  List<Exam>? _examsList;
  List<Exam>? get examsList => _examsList;

  List<Question>? _questionList;
  List<Question>? get questionList => _questionList;


  bool _isSearching = true;
  bool get isSearching => _isSearching;

  //fetching exam list from firebase
  Future<void> fetchExams(String type) async {
    _isSearching = true;
    notifyListeners();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await firestore
        .collection('exams')
        .where('type', isEqualTo: type)
        .get();

    _examsList = snapshot.docs.map((doc) {
      return Exam.fromFirestore(doc);
    }).toList();
    _isSearching = false;
    notifyListeners();
    print(_examsList);
  }


  //add exam to firebase
  Future<void> addExam(Exam exam) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    await firestore.collection('exams').add(exam.toFirestore());
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

  //add question to firebase by exam id
  Future<void> addQuestions(String examId, List<Question> questions) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference examRef = firestore.collection('exams').doc(examId);

    for (var question in questions) {
      await examRef.collection('questions').add(question.toFirestore());
    }
  }





}