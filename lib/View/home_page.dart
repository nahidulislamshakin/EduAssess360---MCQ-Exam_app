import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState () => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(

        child: SingleChildScrollView(
          child: Container(
            width: width,
              height: height,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign Up",style: Theme.of(context).textTheme.titleLarge,),
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}