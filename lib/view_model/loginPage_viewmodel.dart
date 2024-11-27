import 'package:eduasses360/services/firebase_services/firebase_services.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../View/home_page/home_page.dart';

class LoginPageViewModel with ChangeNotifier {

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmFocusNode = FocusNode();
  bool _isObscure = true;
  bool get isObscure => _isObscure;

  bool _isConfirmObscure = true;
  bool get isConfirmObscure => _isConfirmObscure;

  bool _isLogin = true;
  bool get isLogin => _isLogin;
  bool _isUserLogedIn = false;
  bool get isUserLogedIn => _isUserLogedIn;
  String _welcomeText = "Login";
  String get welcomeText =>_welcomeText;
  String _accountHaveorNotTextSecondPart = "Create new account";
  String get accountHaveorNotTextSecondPart => _accountHaveorNotTextSecondPart;
  String _accountHaveorNotTextFirstPart = "Don't have an account? ";
  String get accountHaveOrNotTextFirstPart => _accountHaveorNotTextFirstPart;
  String _loginButtonText = "Login";
  String get loginButtonText => _loginButtonText;

  late ImageProvider _backgroundImage;
  ImageProvider get backgroundImage => _backgroundImage;

  void welComeText(){
    if(_isLogin){
      _loginButtonText = "Login";
      _welcomeText = "Login";
      _accountHaveorNotTextFirstPart = "Don't have an account?  ";
      _accountHaveorNotTextSecondPart = "Create new account";
    }
    else{
      _loginButtonText = "Signup";
      _welcomeText = "Sign Up";
      _accountHaveorNotTextFirstPart = "Already have an account?  ";
      _accountHaveorNotTextSecondPart = "Login";
    }
    notifyListeners();
  }

  void onAccountHaveOrNotPressed(){
    _isLogin = !_isLogin;
    welComeText();
  }

  void cacheBackgroundImage(){
    _backgroundImage = const AssetImage('assets/images/pencil.jpg',);
  }

  LoginPageViewModel(){
    isLogged();
    welComeText();
  }


  void isLogged() {
    _isUserLogedIn = FirebaseAuth.instance.currentUser == null ? false : true;
    notifyListeners();
  }

  void isConfirmPasswordVisible(){
    _isConfirmObscure = !_isConfirmObscure;
    notifyListeners();
  }

  void isPasswordVisible(){
    _isObscure = !isObscure;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  bool isLoading = false;

  @override
  void dispose() {
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  void loadingButton(bool isLoad){
    isLoading = isLoad;
    notifyListeners();
  }

  void validateEmail(String? value) {


      if (value!.isEmpty) {
        _errorMessage = "Please enter your email";
      //  notifyListeners();
      } else if (!value.contains('@')) {
        _errorMessage = 'Email must contain a "@" symbol';
        //notifyListeners();

      } else {
        _errorMessage = null;
      //  notifyListeners();
      }

  }

  Future<void> firebaseLogin({required String email, required String password, required BuildContext context}) async {
    loadingButton(true);
    final user = await FirebaseServices().login(email: email, password: password);
    loadingButton(false);
    if(FirebaseAuth.instance.currentUser !=null)
      {
      //  Utils.greenSnackBar(context: context, message: "Login Successful");
        print("Email : ${FirebaseAuth.instance.currentUser?.email}\nThanks\n");
        Navigator.of(context).pushReplacement(PageTransition(
            child: HomePage(),
            type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 400),
        )
           );
      }
    else{
      Utils.redSnackBar(context: context, message: "Login Failed");
      return;
    }
  }

  Future<void> firebaseSignUp({required String email, required String password, required BuildContext context}) async {
    loadingButton(true);
    final user = await FirebaseServices().signup(email: email, password: password);
    loadingButton(false);
    if(FirebaseAuth.instance.currentUser !=null)
    {
      //  Utils.greenSnackBar(context: context, message: "Login Successful");
      if (kDebugMode) {
        print("Email : ${FirebaseAuth.instance.currentUser?.email}\nThanks\n");
      }
      Navigator.of(context).pushReplacement(PageTransition(
        child: HomePage(),
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 400),
      )
      );
      _isLogin = true;
      welComeText();
    }
    else{
      Utils.redSnackBar(context: context, message: "Sign up Failed");
      return;
    }
  }


}
