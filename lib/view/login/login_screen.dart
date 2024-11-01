import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:totalx/controller/auth_controller.dart';
import 'package:totalx/view/screens/home_screens.dart';

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
            child: Consumer<AuthenticationController>(builder: (context, controller, child) =>
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
                    if(phoneController.text.isEmpty || !RegExp(r'^[0-9]{10}$').hasMatch(phoneController.text) ){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a valid 10-digit phone number")),
                      );
                      return ;
                    }
                    // controller.signinWithPhone(phoneNumber: '+91${phoneController.text}', context: context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    child: Center(
                     child: Text("Continue",style: GoogleFonts.montserrat(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white
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