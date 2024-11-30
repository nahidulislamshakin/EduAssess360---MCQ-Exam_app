// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// class StudentQuestionPage extends StatefulWidget {
//   final String id;
//   final String name;
//
//   const StudentQuestionPage({Key? key, required this.id, required this.name}) : super(key: key);
//
//   @override
//   State<StudentQuestionPage> createState() => _StudentQuestionPageState();
// }
//
// class _StudentQuestionPageState extends State<StudentQuestionPage> {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//   List<int> studentAnswers = [];
//   int correctAnswers = 0;
//   int wrongAnswers = 0;
//   Map<String, int> wrongByCategory = {};
//
//   List<Map<String, dynamic>> questions = []; // Store questions locally
//
//   /// Method to calculate results
//   void calculateResults() {
//     correctAnswers = 0;
//     wrongAnswers = 0;
//     wrongByCategory.clear();
//
//     for (int i = 0; i < questions.length; i++) {
//       final correctAnswer = questions[i]['correct_answer'];
//       final selectedAnswer = studentAnswers[i];
//       final category = questions[i]['category'];
//
//       if (selectedAnswer == correctAnswer) {
//         correctAnswers++;
//       } else {
//         wrongAnswers++;
//         if (!wrongByCategory.containsKey(category)) {
//           wrongByCategory[category] = 0;
//         }
//         wrongByCategory[category] = wrongByCategory[category]! + 1;
//       }
//     }
//   }
//
//   /// Method to submit results to Firestore
//   Future<void> submitResults() async {
//     if (wrongByCategory.isNotEmpty) {
//       final maxWrongCategory = wrongByCategory.entries.reduce((a, b) => a.value > b.value ? a : b).key;
//
//       await firestore.collection('student_results').add({
//         'id': widget.id,
//         'name': widget.name,
//         'correctAnswers': correctAnswers,
//         'wrongAnswers': wrongAnswers,
//         'maxWrongCategory': maxWrongCategory,
//         'submittedAt': DateTime.now().toIso8601String(),
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Exam submitted successfully!")),
//       );
//
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No questions answered!")),
//       );
//     }
//   }
//
//   /// Method to fetch questions from Firestore
//   Future<List<Map<String, dynamic>>> fetchQuestions() async {
//     final snapshot = await firestore.collection('exams').doc(widget.id).collection('questions').get();
//     return snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Questions for ${widget.name}"),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: fetchQuestions(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.data == null || snapshot.data!.isEmpty) {
//             return const Center(child: Text("No questions available."));
//           }
//
//           questions = snapshot.data!; // Save the fetched questions locally
//           studentAnswers = List<int>.filled(questions.length, -1);
//
//           return ListView.builder(
//             itemCount: questions.length,
//             itemBuilder: (context, index) {
//               final question = questions[index];
//
//               return Card(
//                 margin: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("${index + 1}. ${question['question']}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 8.0),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: question['options'].length,
//                         itemBuilder: (context, optionIndex) {
//                           return RadioListTile<int>(
//                             value: optionIndex,
//                             groupValue: studentAnswers[index],
//
//                             onChanged: (value) {
//                               setState(() {
//                                 studentAnswers[index] = value!;
//                               });
//                             },
//                             title: Text(question['options'][optionIndex]),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           if (studentAnswers.contains(-1)) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Please answer all questions!")),
//             );
//             return;
//           }
//
//           calculateResults(); // Use the locally saved questions
//           submitResults();
//         },
//         label: const Text("Submit Exam"),
//         icon: const Icon(Icons.check),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class StudentQuestionPage extends StatefulWidget {
  final String id;
  final String name;

  const StudentQuestionPage({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<StudentQuestionPage> createState() => _StudentQuestionPageState();
}

class _StudentQuestionPageState extends State<StudentQuestionPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<int> studentAnswers = []; // Tracks selected answers
  List<Map<String, dynamic>> questions = []; // Stores questions locally

  int correctAnswers = 0;
  int wrongAnswers = 0;
  Map<String, int> wrongByCategory = {};

  bool isLoading = true; // Flag to track if questions are being fetched

  @override
  void initState() {
    super.initState();
    fetchQuestions(); // Fetch questions during initialization
  }

  /// Fetch questions from Firestore
  Future<void> fetchQuestions() async {
    try {
      final snapshot = await firestore.collection('exams').doc(widget.id).collection('questions').get();

      setState(() {
        questions = snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList();
        studentAnswers = List<int>.filled(questions.length, -1); // Initialize answers with -1
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching questions: $e");
    }
  }

  /// Calculate exam results
  void calculateResults() {
    correctAnswers = 0;
    wrongAnswers = 0;
    wrongByCategory.clear();

    for (int i = 0; i < questions.length; i++) {
      final correctAnswer = questions[i]['correct_answer'];
      final selectedAnswer = studentAnswers[i];
      final category = questions[i]['category'];

      if (selectedAnswer == correctAnswer) {
        correctAnswers++;
      } else {
        wrongAnswers++;
        if (!wrongByCategory.containsKey(category)) {
          wrongByCategory[category] = 0;
        }
        wrongByCategory[category] = wrongByCategory[category]! + 1;
      }
    }
  }

  // /// Submit results to Firestore
  // Future<void> submitResults() async {
  //   if (wrongByCategory.isNotEmpty) {
  //     final maxWrongCategory = wrongByCategory.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  //
  //     await firestore.collection('student_results').add({
  //       'examId': widget.id,
  //       'examName': widget.name,
  //       'correctAnswers': correctAnswers,
  //       'wrongAnswers': wrongAnswers,
  //       'maxWrongCategory': maxWrongCategory,
  //       'submittedAt': DateTime.now().toIso8601String(),
  //     });
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Exam submitted successfully!")),
  //     );
  //
  //     Navigator.pop(context);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("No questions answered!")),
  //     );
  //   }
  // }

  Future<void> submitResults(String userId) async {
    if (wrongByCategory.isNotEmpty) {
      final maxWrongCategory = wrongByCategory.entries.reduce((a, b) => a.value > b.value ? a : b).key;

      final resultData = {
        'examType': widget.name,
        'score': correctAnswers,
        'wrongAnswers': wrongAnswers,
        'maxWrongCategory': maxWrongCategory,
        'date': DateTime.now().toIso8601String(),
      };

      // Save the result into the user's exams sub-collection
      await firestore.collection('users').doc(userId).collection('exams').doc(widget.id).set(resultData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Exam submitted successfully!")),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No questions answered!")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 25,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title:  Text(widget.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(DateFormat.yMMMd().format(DateTime.now(),),
              style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),),
          )
        ],
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading indicator
          : ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${index + 1}. ${question['question']}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: question['options'].length,
                    itemBuilder: (context, optionIndex) {
                      return RadioListTile<int>(
                        value: optionIndex,
                        groupValue: studentAnswers[index], // The selected value for this question
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              studentAnswers[index] = value; // Update the selected answer
                            });
                          }
                        },
                        title: Text(question['options'][optionIndex]),
                        activeColor: Colors.black, // Highlight selected option
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     if (studentAnswers.contains(-1)) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(content: Text("Please answer all questions!")),
      //       );
      //       return;
      //     }
      //
      //     calculateResults();
      //     submitResults();
      //   },
      //   label: const Text("Submit Exam"),
      //   icon: const Icon(Icons.check),
      // ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (studentAnswers.contains(-1)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please answer all questions!")),
            );
            return;
          }

          // Retrieve the user ID from authentication (modify based on your setup)
          final userId = FirebaseAuth.instance.currentUser!.uid; // Replace with actual user ID, e.g., FirebaseAuth.instance.currentUser?.uid

          calculateResults(); // Process the answers
          await submitResults(userId); // Submit results to Firestore
        },
        label: const Text("Submit Exam"),
        icon: const Icon(Icons.check),
      ),

    );
  }
}
