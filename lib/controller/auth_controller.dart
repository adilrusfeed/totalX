import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:totalx/service/auth_service.dart';

class AuthenticationController  extends ChangeNotifier{
  AuthService  authService = AuthService();

 Future<void> signinWithPhone({
    required String phoneNumber, required BuildContext context
  })async{
    try {
      log(phoneNumber);
      await authService.signinWithPhone(phoneNumber: phoneNumber, context: context);
    } catch (e) {
      log('Phone authentication failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to sign in with phone number. Please try again.'))
    );
    }
    notifyListeners();
  }

 Future<void> verifyOtp(
    {
      required String verificationId,
      required String otp,
      required Function onSuccess,
      required String phone})
      async{
        try{
          authService.verifyOtp(verificationId: verificationId, otp: otp, phone: phone,onSuccess: onSuccess);
        }catch(e){
          throw Exception('Phone auth interrupted$e');
        }
        notifyListeners();
      }

}