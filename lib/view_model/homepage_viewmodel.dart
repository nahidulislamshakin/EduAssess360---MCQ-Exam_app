import 'dart:async';
import 'package:flutter/foundation.dart';
import '../model/question_model.dart';
import '../services/api_services.dart';

class HomePageViewModel with ChangeNotifier {
  static const String url = "https://the-trivia-api.com/v2/questions/";

  final List<QuestionModel> questionList = [];

  Future getApiData() async {
    questionList.clear();
    var data = await ApiServices().getApiData(url);

    for (Map<String, dynamic> i in data) {
      questionList.add(
        QuestionModel.fromJson(i),
      );
    }

    if (kDebugMode) {
      print("List added successfully");
    }

    Timer(const Duration(seconds: 100), () {
      notifyListeners();
    });
    return questionList;
  }

  List<String> getShuffledAnswer(QuestionModel question) {
    final List<String> answerList = [];
    if (question.incorrectAnswers != null && question.correctAnswer != null) {
      answerList.addAll(question.incorrectAnswers!);
      answerList.add(question.correctAnswer!);
    }
    answerList.shuffle();
    return answerList;
  }
}
