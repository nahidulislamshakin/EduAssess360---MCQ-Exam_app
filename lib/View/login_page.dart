import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/utils/utils.dart';
import 'package:eduasses360/view_model/loginPage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  bool isLoading = false;

  String? errorMessage;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  initState(){
     emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children:[
            Positioned.fill(
              child: Image.asset(
                'assets/images/pencil.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    height: availableHeight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 15.h),
                            InputBox(
                              width: width,
                              height: height,
                              textField: TextFormField(
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.black
                                ),
                                controller: emailController,
                                validator: (value) {
                                  final errorMessage =
                                  logProvider.validateEmail(emailController);
                                  return errorMessage;
                                },
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Enter Email",

                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.sp),
                                  border: InputBorder.none,
                                  // OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(12.r),
                                  //
                                  // ),
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),
                            InputBox(
                              width: width,
                              height: height,
                              textField: TextFormField(
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                    color: Colors.black,
                                ),
                                obscureText: true,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  labelText: "Enter Password",

                                  labelStyle: TextStyle(
                                      color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14.sp),
                                  border: InputBorder.none,
                                  // OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(12.r),
                                  //
                                  // ),
                                ),
                              ),
                            ),
                         const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Utils.toastMessage("Sorry, This feature is currently off by the App Developer.");
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Colors.amberAccent,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.yellow

                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await logProvider.firebaseLogin(email: emailController.text, password: passwordController.text, context: context);
                                  },
                                  child:  logProvider.isLoading ?
                                 const Padding(
                                    padding:  EdgeInsets.all(5.0),
                                    child:  CircularProgressIndicator(color: Colors.black,),
                                  )
                                  :
                                  Text(
                                    "Login",
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Utils.toastMessage("Sorry, This feature is currently off by the App Developer.");

                                  },
                                  child: Text(
                                    "SIGN UP",
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
      ]
        ),

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
      height: 55.h,

      // margin: EdgeInsets.only(left: 30.w, right: 30.w),
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      decoration: BoxDecoration(
          border: Border.all(width: 1.w, color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 0.1.r,
        //     blurRadius: 10.r,
        //     offset: const Offset(0, 7),
        //   )
        // ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: textField,
      ),
    );
  }
}
