
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/controller/home_controller.dart';

class AddDialogBox extends StatelessWidget {
  const AddDialogBox(
      {super.key,
      required this.ageController,
      required this.nameController,
      required this.homeProvid});

  final HomeController homeProvid;
  final TextEditingController nameController;
  final TextEditingController ageController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Add User',
        style: GoogleFonts.montserrat(),
      ),
      actions: [
        Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: homeProvid.selectedImage != null
                    ? FileImage(File(homeProvid.selectedImage?.path ?? ''))
                    : AssetImage('assets/person.png') as ImageProvider,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Select Image'),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  homeProvid.pickImage(ImageSource.gallery);
                                },
                                child: Icon(Icons.image_outlined),
                              ),
                              InkWell(
                                onTap: () {
                                  homeProvid.pickImage(ImageSource.camera);
                                },
                                child: Icon(Icons.camera_alt_outlined),
                              )
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200))),
                  child: Center(
                    child: Icon(Icons.camera_alt_outlined, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
              hintText: "Name",
              hintStyle: GoogleFonts.montserrat(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(height: 10),
        TextField(
          controller: ageController,
          decoration: InputDecoration(
              hintText: "Age",
              hintStyle: GoogleFonts.montserrat(),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel", style: TextStyle(color: Colors.red))),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.amber)),
              onPressed: () {
                if (homeProvid.selectedImage == null) {
                  return;
                // if (homeProvid.selectedImage == null &&
                //         nameController.text.isEmpty ||
                //     ageController.text.isEmpty) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(content: Text("Please fill all fields")));
                } else {
                  homeProvid.addUsersCollections(
                      name: nameController.text,
                      age: ageController.text,
                      imageFile: homeProvid.selectedImage!
                      );
                  nameController.clear();
                  ageController.clear();
                  homeProvid.selectedImage == null;
                }
              },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            )
          ],
        )
      ],
    );
  }
}
