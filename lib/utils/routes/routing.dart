import 'package:eduasses360/View/admin_page/add_question_page.dart';
import 'package:eduasses360/View/admin_page/model_test.dart';
import 'package:eduasses360/View/home_page/home_page.dart';
import 'package:eduasses360/View/main_pages.dart';
import '../../View/home_page/attend_exam.dart';
import '../../View/login_page.dart';
import '../../View/model_test_page.dart';
import '/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import '../utils.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final argument = settings.arguments;
    switch (settings.name){
      case RouteName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>HomePage(),);


      case RouteName.modelTestPage:
        if(argument is String){
          return MaterialPageRoute(builder: (BuildContext context)=>ModelTestPage(examType: argument,));
        }
        // Return an error page or message if argument is invalid
        return MaterialPageRoute(
          builder: (BuildContext context) => const Scaffold(
            body: Center(child: Text("Invalid or missing argument for ModelTest")),
          ),
        );


      case RouteName.adminModelTestPage:
        if(argument is String){
          return MaterialPageRoute(builder: (BuildContext context)=>AdminModelTest(examType: argument,));
        }
        // Return an error page or message if argument is invalid
        return MaterialPageRoute(
          builder: (BuildContext context) => const Scaffold(
            body: Center(child: Text("Invalid or missing argument for ModelTest")),
          ),
        );

      case RouteName.addQuestionPage:
        if(argument is String){
          return MaterialPageRoute(builder: (BuildContext context)=>AddQuestionPage(id: argument,));
        }
        // Return an error page or message if argument is invalid
        return MaterialPageRoute(
          builder: (BuildContext context) => const Scaffold(
            body: Center(child: Text("Invalid or missing argument for ModelTest")),
          ),
        );

      case RouteName.StudentQuestionPage:
        if (argument is Map<String, dynamic> && argument.containsKey('name') && argument.containsKey('id')) {
          return MaterialPageRoute(
            builder: (BuildContext context) => StudentQuestionPage(
              name: argument['name'],
              id: argument['id'],
            ),
          );
        }
        // Return an error page or message if argument is invalid
        return MaterialPageRoute(
          builder: (BuildContext context) => const Scaffold(
            body: Center(child: Text("Invalid or missing arguments for ModelTest")),
          ),
        );

      case RouteName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const LoginPage(),);


      case RouteName.mainPage:
        return MaterialPageRoute(builder: (BuildContext context)=> MainPages(),);

      default: return Utils.toastMessage("No route found");
    }

  }
}