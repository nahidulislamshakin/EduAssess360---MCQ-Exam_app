import 'package:eduasses360/View/home_page/home_page.dart';
import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/utils/utils.dart';
import 'package:eduasses360/view_model/loginPage_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  bool isLoading = false;

  String? errorMessage;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();


  late ImageProvider backgroundImage;

  @override
  initState() {

    confirmPasswordController = TextEditingController();
    backgroundImage =  const AssetImage('assets/images/pencil.jpg',);

    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Use context-dependent logic here
    precacheImage(backgroundImage, context);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logProvider = Provider.of<LoginPageViewModel>(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = height - keyboardHeight;


    return logProvider.isUserLogedIn == true
        ? HomePage()
        : Scaffold(
            body: SafeArea(
              child: Stack(children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/pencil.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  reverse: true,
                  child: SizedBox(
                    width: width,
                    height: availableHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              logProvider.welcomeText,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            SizedBox(height: 15.h),
                            InputBox(
                              width: width,
                              height: height,
                              textField: TextFormField(

                                focusNode: logProvider.emailFocusNode,
                                onTap: () {
                                  logProvider.emailFocusNode.requestFocus();
                                },
                                onTapOutside: (_) {
                                  logProvider.emailFocusNode.unfocus();
                                },
                                onEditingComplete: () {
                                  logProvider.emailFocusNode.nextFocus();
                                },
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                    color: Colors.black),
                                controller: emailController,
                                validator: (value) {
                                  logProvider.validateEmail(value.toString());
                                  return logProvider.errorMessage;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 10.sp,color: Colors.red,
                                      fontWeight: FontWeight.normal),
                                  errorMaxLines: 2,
                                  labelText: "Enter Email",

                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp),
                                  border: InputBorder.none,
                                  // OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(12.r),
                                  //
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            InputBox(
                              width: width,
                              height: height,
                              textField: TextFormField(
                                focusNode: logProvider.passwordFocusNode,
                                keyboardType: TextInputType.visiblePassword,
                                onTap: () {
                                  logProvider.passwordFocusNode.requestFocus();
                                },
                                onTapOutside: (_) {
                                  logProvider.passwordFocusNode.unfocus();
                                },
                                onEditingComplete: () {
                                  logProvider.passwordFocusNode.nextFocus();
                                },
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Please enter your password";
                                  }
                                  else if(value.toString().length<8){
                                    return "Password length should be minimum 8 digit";
                                  }
                                  return null;
                                },
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.sp,
                                  color: Colors.black,
                                ),
                                obscureText: logProvider.isObscure,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(fontSize: 10.sp,color: Colors.red,
                                      fontWeight: FontWeight.normal),
                                  errorMaxLines: 2,
                                  labelText: "Enter Password",

                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.sp),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      logProvider.isPasswordVisible();
                                    },
                                    icon: Icon(logProvider.isObscure
                                        ? Icons.visibility
                                        : Icons
                                            .visibility_off), // Change icon based on visibility state
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if(!logProvider.isLogin)
                              InputBox(
                                width: width,
                                height: height,
                                textField: TextFormField(
                                  focusNode: logProvider.confirmFocusNode,
                                  keyboardType: TextInputType.visiblePassword,
                                  onTap: () {
                                    logProvider.confirmFocusNode.requestFocus();
                                  },
                                  onTapOutside: (_) {
                                    logProvider.confirmFocusNode.unfocus();
                                  },
                                  onFieldSubmitted: (_) {
                                    logProvider.confirmFocusNode.unfocus();
                                  },
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),


                                  validator: (value){
                                    if(value.toString() != passwordController.text.toString()){
                                      return "Password is not matched";
                                    }
                                    return null;
                                  },
                                  obscureText: logProvider.isConfirmObscure,
                                  controller: confirmPasswordController,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontSize: 10.sp,color: Colors.red,
                                    fontWeight: FontWeight.normal),
                                    errorMaxLines: 2,

                                    labelText: "Confirm Password",
                                    labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.sp),
                                    border: InputBorder.none,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        logProvider.isConfirmPasswordVisible();
                                      },
                                      icon: Icon(logProvider.isConfirmObscure
                                          ? Icons.visibility
                                          : Icons
                                          .visibility_off), // Change icon based on visibility state
                                    ),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if(logProvider.isLogin)
                                TextButton(
                                  onPressed: () {
                                    Utils.toastMessage(
                                        "Sorry, This feature is currently unavailable.");
                                  },
                                  child: Text(
                                    "Forget Password?",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            color: Colors.amberAccent,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.yellow,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16.sp),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: logProvider.isLogin ? () async {
                                    if(_formKey.currentState!.validate()){
                                      await logProvider.firebaseLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          context: context);
                                    }
                                    else{
                                      return;
                                    }

                                  } :
                                      () async {
                                    if(_formKey.currentState!.validate()){
                                      await logProvider.firebaseSignUp(
                                          email: emailController.text,
                                          password: confirmPasswordController.text,
                                          context: context);
                                    }
                                    else{
                                      return;
                                    }

                                  },
                                  child: logProvider.isLoading
                                      ? const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        )
                                      : Text(
                                          logProvider.loginButtonText,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            RichText(
                              softWrap: true,
                              maxLines: 2,
                              text: TextSpan(
                                text: logProvider.accountHaveOrNotTextFirstPart,
                                style: Theme.of(context).textTheme.bodyMedium,
                                children: [
                                  // SizedBox(width: 5,),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        logProvider.onAccountHaveOrNotPressed();
                                        _formKey.currentState!.reset();
                                      },
                                    text: logProvider.accountHaveorNotTextSecondPart,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          );
  }
}

class InputBox extends StatelessWidget {
  final double width;
  final double height;
  final Widget textField;

  const InputBox(
      {super.key,
      required this.width,
      required this.height,
      required this.textField});
  @override
  Widget build(BuildContext context) {
    return Container(
      //  width: width,
      height: 65.h,

      // margin: EdgeInsets.only(left: 30.w, right: 30.w),
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      decoration: BoxDecoration(
        border: Border.all(width: 1.w, color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1.r,
            blurRadius: 10.r,
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: textField,
      ),
    );
  }
}
