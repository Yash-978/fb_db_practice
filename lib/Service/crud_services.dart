import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/Modal/UserModal.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CRUDServices {
  User? user = FirebaseAuth.instance.currentUser;

  Future addDataToFireStore(UserInfoModal userInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.email)
          .collection("usersData")
          .add(userInfo.toMap());
      print('Document Added');
    } catch (e) {
      print("Error occur During the Data Addition in Firebase : $e");
    }
  }

  Stream<QuerySnapshot> readDataFromFireStore() async* {
    try {
      var userdata =await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.email)
          .collection("usersData").orderBy('name')
          .snapshots();
      yield* userdata;
    } catch (e) {
      print(e.toString());
    }
  }
}
