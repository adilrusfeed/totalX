import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx/model/user_model.dart';
import 'package:totalx/view/login/otp_screen.dart';

class AuthenticationService {
  FirebaseAuth authentication = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

 Future<void> signinWithPhone(
    {required String phoneNumber,
      required BuildContext context
    })async{
      try {
        await authentication.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:  (phoneAuthCredential) async{
            await  authentication.signInWithCredential(phoneAuthCredential);

          },
          verificationFailed: (error) {
            throw Exception(error);
          },
          codeSent: (verificationId, forceResendingToken) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(
              verificationId: verificationId,
              phoneNumber: phoneNumber,
            ),));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            log(verificationId);
          },
        );
      }on FirebaseAuthException catch (e){
        throw Exception('Phone auth is interrupted$e');
      }
    }

  Future<void>  verifyOtp({
      required String verificationId,
      required String otp,
      required String phone,
      required Function onSuccess
    })async{
      try{
        PhoneAuthCredential credential= PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
        User? user = (await authentication.signInWithCredential(credential)).user;
        if(user != null){
          UserModel userData = UserModel(id: user.uid,phoneNumber: phone);
          await firestore.collection('users').doc(user.uid).set(userData.toJson());
          onSuccess();
        }
      }on FirebaseAuthException catch (e){
        throw Exception('Phone auth is interrupted$e');
      }
    }

    Future<void> signOut()async{
      try {
        await  authentication.signOut();

      } catch (e) {
        throw  Exception('Error on SignOut$e');
      }
    }
}