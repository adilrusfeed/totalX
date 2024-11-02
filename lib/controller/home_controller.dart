import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/data_model.dart';

import '../service/data_service.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  UserService userService = UserService();
  List<DataModel> allUsers = [];
  List<DataModel> searchlist = [];
  File? pickedImage;
  String? uploadedImageUrl;
  bool isloading = false;
  final ImagePicker imagePicker = ImagePicker();
  String selectedSortOption = 'All';

 

  Future<void> addUser(DataModel data)async{
    isloading=true;
    notifyListeners();
    try{
      if(pickedImage!=null){
        uploadedImageUrl = await uploadImage();
        data.image = uploadedImageUrl;
      }
      
      await userService.adduser(data);
      log("user adding success");
      clearControllers();
      pickedImage = null;
      await getUsersAndSort('All');
    }catch(e){
      log("error adding user");
    }
    isloading = false;
    notifyListeners();
  }

    Future<void> getUsersAndSort(String sortOption) async {
    allUsers = await userService.getAllUsers();
    if (sortOption == 'Elder') {
      allUsers = userService.sortUsersByAge(allUsers, true);
    } else if (sortOption == 'Younger') {
      allUsers = userService.sortUsersByAge(allUsers, false);
    }
    searchlist = allUsers;
    selectedSortOption = sortOption;

    notifyListeners();
  }

  // Future<void> getProduct() async {
  //   isloading = true;
  //   notifyListeners();
  //   try {
  //     allUsers = await userService.getAllUsers();
  //     searchlist = allUsers;
  //   } catch (e) {
  //     log("Error fetching users: $e");
  //   }
  //   isloading = false;
  //   notifyListeners();
  // }

  
  Future<String?> uploadImage() async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final imageRef = FirebaseStorage.instance.ref().child("user_images/$fileName.jpg");

      final uploadTask = imageRef.putFile(pickedImage!);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      log("Image uploaded successfully. Download URL: $downloadUrl");
      return downloadUrl;
     
      
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      searchlist = allUsers;
    } else {
      searchlist = allUsers
          .where(
            (user) => user.name!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
          .toList();
    }
    notifyListeners();
  }

  

  Future<void> pickImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      uploadedImageUrl = null;
      notifyListeners();

    }
  }
  
  clearControllers() {
    nameController.clear();
    ageController.clear();
  
  }

  

  void resetImage() {
    pickedImage = null;
    uploadedImageUrl = null;
    notifyListeners();
  }
  }
