import 'package:eduasses360/utils/utils.dart';
import 'package:eduasses360/view_model/admin_model_test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/admin/exam_model.dart';
import '../../utils/routes/route_name.dart';

class AdminModelTest extends StatefulWidget{

  final String examType;
  AdminModelTest({super.key, required this.examType});

  @override
  State<AdminModelTest> createState() => _AdminModelTestState();
}

class _AdminModelTestState extends State<AdminModelTest> {
  TextEditingController nameController = TextEditingController();

  bool isSearching = true;
  @override
  void initState() {
    Future.microtask((){
      context.read<AdminModelTestViewModel>().fetchExams(widget.examType);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final modelProvider = Provider.of<AdminModelTestViewModel>(context);
    return
    Scaffold(
      appBar:  AppBar(
        elevation: 25,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white70,
        title:  Text("Model Test",
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
          onPressed: (){

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Center(child: Text("Add Exam")),
                    actions: [
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))],
                    content: SizedBox(
                      width: double.infinity,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              TextFormField(
                               controller: nameController,
                                decoration: InputDecoration(
                                  labelText: "Exam name",
                                  hintText: "Weekly Model Test",
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  )
                                ),
                                validator: (value){
                                 if(value == null || value.toString().isEmpty){
                                   return "Please enter the exam name";
                                 }
                                 return null;
                                },
                              ),

                              const SizedBox(height: 10,),

                              ElevatedButton(
                                  onPressed: () async {
                                    final Exam exam = Exam(name: nameController.text,type: widget.examType,date: DateTime.now().toString());
                                    await modelProvider.addExam(exam);
                                    await modelProvider.fetchExams(widget.examType);
                                    Utils.greenSnackBar(context: context,message: "Successful");
                                    Navigator.of(context).pop();
                                  }, child: const Text("Add Exam"),),
                            ],
                          ),
                        ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
          ),
      body: modelProvider.isSearching == true ?
      const Center(child: CircularProgressIndicator(color: Colors.black,),)
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<AdminModelTestViewModel>(
            builder: (context, modelProvider, child){

              final exams = modelProvider.examsList;
              // if(modelProvider.examsList!.isEmpty){
              //   return const Center(child: CircularProgressIndicator());
              // }

              return ListView.builder(
                itemCount: exams?.length,
                itemBuilder: (context,index){
                  final exam = exams?[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, RouteName.addQuestionPage,arguments: exam?.id);
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 6.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                              height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text(exam?.name ?? "Loading....",style: Theme.of(context).textTheme.titleMedium,)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  );
                },
              );
            },

          ),
        ),
      ),
    );
  }
}