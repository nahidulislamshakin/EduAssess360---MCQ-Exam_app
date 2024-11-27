import 'package:eduasses360/View/home_page/home_page.dart';
import 'package:eduasses360/View/main_pages.dart';
import '../../View/login_page.dart';
import '/utils/routes/route_name.dart';
import 'package:flutter/material.dart';
import '../utils.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final argument = settings.arguments;
    switch (settings.name){
      case RouteName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>HomePage(),);

      case RouteName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const LoginPage(),);
      case RouteName.mainPage:
        return MaterialPageRoute(builder: (BuildContext context)=> MainPages(),);

      default: return Utils.toastMessage("No route found");
    }

  }
}