import 'package:eduasses360/utils/routes/route_name.dart';
import 'package:eduasses360/view_model/loginPage_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  bool valid = true;
  final _formKey = GlobalKey<FormState>();


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage('assets/images/pencil.jpg'), context);
  }


  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lpvProvider = Provider.of<LoginPageViewModel>(context);
    //errorMessage = lpvProvider.validateEmail(emailController);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final availableHeight = height - keyboardHeight;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: ClampingScrollPhysics(),
          child: Container(
            width: width,
            height: availableHeight,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/pencil.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InputBox(
                      width: width,
                      height: height,
                      textField: TextFormField(
                        controller: emailController,
                        validator: (value) {
                          errorMessage =
                              lpvProvider.validateEmail(emailController);
                          return errorMessage;
                          //return lpvProvider.validateEmail(value ?? '');
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          //errorText: "",
                          fillColor: Colors.white,
                          filled: true,
                          labelText: "Enter Email",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.sp),
                          iconColor: Colors.red,
                          //  helperText: "Enter Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    InputBox(
                      width: width,
                      height: height,
                      textField: TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          //icon: const Icon(),
                          labelText: "Enter Password",
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 14.sp),
                          iconColor: Colors.red,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // _formKey.currentState?.validate();
                            // valid = false;
                            Navigator.pushNamed(context,RouteName.home);
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "SIGN UP",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
        //  border: Border.all(width: 1.w, color: Colors.white),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.1,
            blurRadius: 10,
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: textField,
    );
  }
}
