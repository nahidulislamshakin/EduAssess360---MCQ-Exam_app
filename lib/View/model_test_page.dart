import 'package:eduasses360/utils/utils.dart';
import 'package:eduasses360/view_model/admin_model_test_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/admin/exam_model.dart';
import '../utils/routes/route_name.dart';

class ModelTestPage extends StatefulWidget{

  final String examType;
  ModelTestPage({super.key, required this.examType});

  @override
  State<ModelTestPage> createState() => _ModelTestPageState();
}

class _ModelTestPageState extends State<ModelTestPage> {
  TextEditingController nameController = TextEditingController();
  //final String examType = "weekly_model_test";

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
    return Scaffold(
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


      body: SafeArea(
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
                          Navigator.pushNamed(
                            context,
                            RouteName.StudentQuestionPage,
                            arguments: {
                              'name': exam?.name,
                              'id': exam?.id,
                            },
                          );

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