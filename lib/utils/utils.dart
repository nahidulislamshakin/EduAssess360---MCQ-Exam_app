import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        backgroundColor: Colors.red
    );

  }

  static redSnackBar({required BuildContext context, required String message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.red,
      duration: const Duration(seconds: 1),
    showCloseIcon: true,),
    );
  }

  static greenSnackBar({required BuildContext context, required String message}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
      showCloseIcon: true,),
    );
  }

}