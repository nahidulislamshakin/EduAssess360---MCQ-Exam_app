import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentProfilePage extends StatefulWidget{

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  String? name = "Nahidul Islam Shakin";

  TextEditingController nameController  = TextEditingController();


  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,elevation: 0,iconTheme: IconThemeData(color: Colors.black54),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset("assets/images/unknown_person.jpg",width: 100,height: 100,fit: BoxFit.cover,),
                ),
                const SizedBox(height: 12,),
                if(name == null)
                Row(
                  children: [
                    Text("Name",style: TextStyle(fontSize: 16.sp,color: Colors.black,),),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: TextFormField(
                        controller: nameController,

                        onTapOutside: (_){
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          // hintText: "Name",
                          // hintStyle: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 14.sp),
                        ),
                      ),
                    ),
                    TextButton(onPressed: (){
                      setState(() {
                        name = nameController.text;
                      });
                    }, child: Text("Save"))
                  ],
                ),
                if(name != null)
                  Align(
                      alignment: Alignment.center,
                      child: Text(name??"N/A",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18.sp,),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}