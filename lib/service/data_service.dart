import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalx/model/data_model.dart';

class UserService {
  String collection = 'user';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<DataModel> user;
  // CollectionReference user = firestore.collection(collection);

  Reference storage = FirebaseStorage.instance.ref();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String downloadUrl = "";

  UserService() {
    user = firestore.collection(collection).withConverter<DataModel>(
      fromFirestore: (snapshot, options) {
        return DataModel.fromJson(
          snapshot.data()!,
        );
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  Future<void> adduser(DataModel data) async {
    try {
      final docRef = await user.add(data);
      await docRef.update({'uid':docRef.id});
      log("User added with ID : ${docRef.id}");
       
       
    } catch (e) {
      log('Error adding post :$e');
    }
  }

  Future<List<DataModel>> getAllUsers() async {
    try{
    final snapshot = await user.get();
    return snapshot.docs.map((doc) =>doc.data()).toList();
  }catch(e){
    log('Error fetching users :$e');
    return [];
  }
  }

  Future getImage({required source}) async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        return File(pickedImage.path);
      } else {
        log("no image  selected");
      }
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  Future<String?> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      Reference storageReference = storage.child('uploads/$fileName');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      log('Image uploaded: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  List<DataModel> sortUsersByAge(List<DataModel> users, bool isDescending) {
    users.sort((a, b) =>
        isDescending ? b.age!.compareTo(a.age!) : a.age!.compareTo(b.age!));
    return users;
  }
}
