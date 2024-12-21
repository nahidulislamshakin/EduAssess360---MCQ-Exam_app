// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
//
// class AddQuestionPage extends StatelessWidget{
//   final id;
//   AddQuestionPage({required this.id});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         elevation: 25,
//         iconTheme: const IconThemeData(color: Colors.black),
//         centerTitle: true,
//         backgroundColor: Colors.white70,
//         title:  Text("Add Question",
//           style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24),),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Text(DateFormat.yMMMd().format(DateTime.now(),),
//               style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),),
//           )
//         ],
//       ),
//
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddQuestionPage extends StatefulWidget {
  final String id;
  const AddQuestionPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AddQuestionPage> createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  final TextEditingController correctAnswerController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addQuestion(String examId) async {
    await firestore.collection('exams').doc(examId).collection('questions').add({
      'question': questionController.text,
      'options': [
        option1Controller.text,
        option2Controller.text,
        option3Controller.text,
        option4Controller.text,
      ],
      'correct_answer': (int.parse(correctAnswerController.text))-1,
      'category': categoryController.text,
    });
  }

  Stream<QuerySnapshot> fetchQuestions(String examId) {
    return firestore.collection('exams').doc(examId).collection('questions').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 25,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title:  Text("Add Question Page",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 24),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(DateFormat.yMMMd().format(DateTime.now(),),
              style: TextStyle(fontSize: 12.sp,color: Colors.black,fontWeight: FontWeight.bold),),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Center(child: Text("Add Question")),
                content: SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: questionController,
                          decoration: const InputDecoration(labelText: "Question"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: option1Controller,
                          decoration: const InputDecoration(labelText: "Option 1"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: option2Controller,
                          decoration: const InputDecoration(labelText: "Option 2"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: option3Controller,
                          decoration: const InputDecoration(labelText: "Option 3"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: option4Controller,
                          decoration: const InputDecoration(labelText: "Option 4"),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: correctAnswerController,
                          decoration: const InputDecoration(
                            labelText: "Correct Answer",
                            hintText: "Enter option number (1, 2, 3, or 4)",
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: categoryController,
                          decoration: const InputDecoration(labelText: "Category"),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            await addQuestion(widget.id);
                            Navigator.of(context).pop();
                          },
                          child: const Text("Add Question"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fetchQuestions(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final questions = snapshot.data?.docs ?? [];

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(question['question']),
                  subtitle: Text("Category: ${question['category']}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

