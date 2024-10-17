import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:totalx/model/data_model.dart';

class DataService {
   FirebaseFirestore firestore = FirebaseFirestore.instance;
   FirebaseStorage storage = FirebaseStorage.instance;

   Stream<QuerySnapshot> getUsers({
    DocumentSnapshot? lastDocument,
    int pageSize = 10
   }){
    Query query = firestore.collection('users_collection').orderBy('name').limit(pageSize);

    if(lastDocument != null){
      query = query.startAfterDocument(lastDocument);
    }
    return query.snapshots();
   }


   Future<String> uploadImage(File image)async{
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference  reference = storage.ref().child('user_images/$fileName');

      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot  taskSnapshot = await uploadTask;
      String downloadURL  = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    }catch(e){
      throw Exception('Error uploading image: $e');
    }
   }

   Future<void> addUserList({
    required String name,
    required String age,
    required File imageFile,
   })async{
    try {
      String downloadURL = await uploadImage(imageFile);
      DataModel user = DataModel(
        name: name,
        age: age,
        image: downloadURL
      );
      await firestore.collection('users_collection').doc().set(user.toJson());
    }catch(e){
      throw Exception('Error adding user: $e');
    }
   }
   
  Future<void> deleteUserData(String documentId) async {
  try {
    await firestore.collection('users_collection').doc(documentId).delete();
  } catch (e) {
    throw Exception('Error deleting user: $e');
  }
}
   
   
}