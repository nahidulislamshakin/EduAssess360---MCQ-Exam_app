import 'package:eduasses360/services/firebase_services/firebase_services.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel with ChangeNotifier {

  String? errorMessage;
  bool isLoading = false;

  void loadingButton(bool isLoad){
    isLoading = isLoad;
    notifyListeners();
  }

  String? validateEmail(TextEditingController emailController) {
    emailController.addListener(() {
      final email = emailController.text;
      if (email.isEmpty) {
        errorMessage = null;
        notifyListeners();
      } else if (!email.contains('@')) {
        errorMessage = 'Email must contain a "@" symbol';
        notifyListeners();

      } else {
        errorMessage = null;
        notifyListeners();
      }
    });

    return errorMessage;
  }

  Future<void> firebaseLogin({required String email, required String password, required BuildContext context}) async {
    loadingButton(true);
    final user = await FirebaseServices().login(email: email, password: password);
    loadingButton(false);
    if(FirebaseAuth.instance.currentUser !=null)
      {
        Utils.greenSnackBar(context: context, message: "Login Successful");
        print("Email : ${FirebaseAuth.instance.currentUser?.email}\nThanks\n");
        Navigator.pushReplacementNamed(context, RouteName.home);
      }
    else{
      Utils.redSnackBar(context: context, message: "Login Failed");
      return;
    }
  }



}
