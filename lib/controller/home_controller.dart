import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/data_model.dart';
import 'package:totalx/service/data_service.dart';

class HomeController extends ChangeNotifier{
  final imagePicker =  ImagePicker();
  final DataService  dataService = DataService();

  File? selectedImage;
  List<DataModel>allUsers = [];
  List<DataModel> filteredUsers = [];
  String selectedFilter = 'all';
  DocumentSnapshot? lastGoc;
  final int pageSize = 10;
  bool isLoading = false;
  bool hasMore = true;
  bool isLoadingMore = false;

  HomeController(){
    fetchUsers();
  }
  

  Future<void> fetchUsers({
    bool isLoadingMore = false
  })async{
    if(isLoading || !hasMore) return;
    isLoading = true;
    try{
      final users = dataService.getUsers(
        lastDocument: isLoadingMore ? lastGoc : null,
        pageSize: pageSize
      );
      users.listen((snapshot) {
        final users = snapshot.docs.map((doc) {
          Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
          return DataModel.fromJson(data);
        },).toList();
        hasMore = users.length == pageSize;
        if(users.isEmpty){
          hasMore = false;
        }else{
          if(isLoadingMore){
            allUsers.addAll(users);
            log('${allUsers.length}');
          }else{
            allUsers = users;
          }
          lastGoc = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
          filterByAge();

        }isLoading = false;
        notifyListeners();
      });
    }catch(e){
      log('Error fetching users:$e');
      isLoading = false;
    }
  }

  Future<void> refreshUsers()async{
    lastGoc = null;
    hasMore =true;
    pageSize == 10;
    fetchUsers();
  }


    Future<void> pickImage(ImageSource source) async {
    try{
      final pickedFile = await imagePicker.pickImage(source: source);
      if(pickedFile != null){
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    }catch(e){
      log('Error: $e');
    }
  }


  void searchUsers(String query){
  if(query.isEmpty){
    filteredUsers = List.from(allUsers);

  }else{
    filteredUsers = allUsers.where((user) =>
      user.name!.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
  }


  Future<void> addUsersCollections({
    required String name,
    required String age,
    required String imageFile
  })async{
    try{
      await dataService.addUserList(name: name, age: age, imageFile: imageFile);
      refreshUsers();
    }catch(e){
      log('Error adding user:$e');
    }
  }

  Future<void>deleteData()async{
  try{
    await dataService.deteleData();
    refreshUsers();
    notifyListeners();
  }catch(e){
    log('Error deleting data:$e');
  }
  }

  }