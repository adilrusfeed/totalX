import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingWidget extends StatelessWidget {
  const FloatingWidget({super.key,
  required this.ageController,
  required this.nameController,

  });

  final TextEditingController nameController;
  final TextEditingController ageController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        showDialog(context: context, builder: (context) {
          return Consumer(builder: (context, value, child) => AlertDialog(

          ),);
        },);
      },
    );
  }
}