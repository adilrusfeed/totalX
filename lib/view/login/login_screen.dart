import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx/view/login/otp_screen.dart';

import '../../service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(padding: EdgeInsets.all(8),
            child: Consumer<AuthService>(builder: (context, controller, child) =>
            Column(
              children: [
                Container(
                  height: size.height*0.23,
                  width: size.width*0.36,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/otp.jpg"))
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text("Enter Phone Number",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w500),),
                ),
                SizedBox(
                  height: 20
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone_android),
                    hintText: "Enter Phone Number *",
                    hintStyle: GoogleFonts.montserrat(),border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 10)

                  ),
                ),
                SizedBox(height: 20),
                Text("By Continuing, I agree to TotalX's Terms and Conditions & Privacy policy"),
                SizedBox(height: 20),
                InkWell(
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));

                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                     child: Text("Continue",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w600
                      )) ),
                  ),
                )
              ],
            ) ,),),
          )
        ],
      ),
    );
  }
}