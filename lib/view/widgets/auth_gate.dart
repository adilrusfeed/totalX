import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalx/view/screens/home_screens.dart';
import '../login/login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
       builder: (context, snapshot) {
         if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
         }else if(
          snapshot.hasData && snapshot.data != null
         ){
          return HomeScreen();
         }else{
          return LoginScreen();
         }
       },),
    );
  }
}