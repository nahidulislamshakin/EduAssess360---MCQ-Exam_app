import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login({required String email, required String password}) async {
    try{
      
      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch(error){
      if (kDebugMode) {
        print(error.message);
        return error.message;
      }
    }
  }



  //Firebase Sign up with email and password
  Future<Object?> signup({required String email, required String password}) async {
    try{

      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return user;
    } on FirebaseAuthException catch(error){
      if (kDebugMode) {
        print(error.message);
        return error.message;
      }
    }
  }

  Future<void> logOut() async {
    try{
      await _auth.signOut();
    } on FirebaseAuthException catch(error){
      if (kDebugMode) {
        print(error.message);
      }
    }
  }


}