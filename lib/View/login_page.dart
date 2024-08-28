import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
                height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text("E-mail",style: TextStyle(color: Colors.red,fontSize:14.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp,),
                  InputBox(width:width, height:height,
                  textField: TextFormField(
                    decoration: InputDecoration(
                      //icon: const Icon(),
                        hintText: "Enter Email",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:14.sp
                        ),

                        iconColor: Colors.red,

                        border: InputBorder.none

                    ),
                  ),),
                   SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text("E-mail",style: TextStyle(color: Colors.red,fontSize:14.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.sp,),
                  InputBox(width: width,height: height,
                  textField: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      //icon: const Icon(),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize:14.sp
                        ),

                        iconColor: Colors.red,

                        border: InputBorder.none

                    ),
                  ),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputBox extends StatelessWidget{
  final double width;
  final double height;
  final Widget textField;

  const InputBox({super.key, required this.width, required this.height, required this.textField});
  @override
  Widget build (BuildContext context){
    return Container(
      width: width,
      height: 45.h,
      margin: EdgeInsets.only(left: 30.w,right: 30.w),
      padding: EdgeInsets.only(left: 8.w,right: 8.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w,color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 10,
            offset: const Offset(0, 7),)
        ],
      ),
      child: textField,
    );
  }
}
