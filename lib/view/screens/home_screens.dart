import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Nilambur",
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        leading: Icon(
          Icons.location_on,color: Colors.white,
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              
            },child: Icon(Icons.logout,color: Colors.white),
          ))
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8.0),child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),Padding(padding: EdgeInsets.all(8.0),child: 
          TextFormField(decoration: InputDecoration(
            prefixIcon: Icon(Icons.search_sharp,color: Colors.grey,),hintText: "Search by Name",hintStyle: GoogleFonts.montserrat(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),
          ),),))
        ],
      ),),
    );
  }
}