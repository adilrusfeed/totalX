import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/auth_controller.dart';
import 'package:totalx/view/screens/home_screens.dart';

// ignore: must_be_immutable
class OtpScreen extends StatelessWidget {
  String verificationId;
  String phoneNumber;
  OtpScreen(
      {super.key, required this.verificationId, required this.phoneNumber});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.23,
                    width: size.width * 0.36,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/otp verify.jpg"))),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "OTP  Verification",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Enter the verification code sent to your number '),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: PinCodeTextField(
                      controller: otpController,
                      pinTextStyle: TextStyle(fontSize: 17, color: Colors.red),
                      maxLength: 6,
                      pinBoxHeight: size.height * 0.13,
                      pinBoxWidth: size.width * 0.08,
                      pinBoxRadius: 10,
                      pinBoxColor: Colors.white.withOpacity(0.5),
                      highlightColor: Colors.red,
                      defaultBorderColor: Colors.grey,
                      onDone: (value) {},
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      verifyOtp(context, otpController.text, phoneNumber);
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Verify',
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('Resend OTP')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void verifyOtp(context, String userOtp, String phoneNumber) {
    final authProvid = Provider.of<AuthController>(context, listen: false);
    authProvid.verifyOtp(
        verificationId: verificationId,
        otp: userOtp,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
        phone: phoneNumber);
  }
}
