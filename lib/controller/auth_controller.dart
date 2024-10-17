
import 'package:flutter/material.dart';
import 'package:totalx/service/auth_service.dart';

class AuthenticationController  extends ChangeNotifier{
  AuthService authService = AuthService();
  TextEditingController phoneController = TextEditingController();

  Future<void> getOtp(phoneNumber) async {
    await authService.getOtp(phoneNumber);
    notifyListeners();
  }

}