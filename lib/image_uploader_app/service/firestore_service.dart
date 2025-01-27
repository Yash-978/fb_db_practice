import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/modal/image_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Service/AuthService.dart';

class FirebaseFireStoreService {
  FirebaseFireStoreService._();

  static FirebaseFireStoreService firebaseImageUpload = FirebaseFireStoreService._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> readUserFromFireStore() async {
    QuerySnapshot snapshot = await fireStore.collection('users').get();


    for (var doc in snapshot.docs) {
      log(doc.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
  readAllUserCloudFireStore() async {
    // User? user = AuthService.authService.getCurrentUser();
    return await fireStore
        .collection("users")
        .where("email", isNotEqualTo: user!.email)
        .get();
  }

  // Future addDataToFireStore(ImageUploadModal imageModal) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(user!.email)
  //         .collection("usersData")
  //         .add(userInfo.toMap());
  //     print('Document Added');
  //   } catch (e) {
  //     print("Error occur During the Data Addition in Firebase : $e");
  //   }
  // }
}
