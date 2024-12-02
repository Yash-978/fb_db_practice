import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/Modal/UserModal.dart';
import 'package:fb_db_practice/Service/LocalDatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchRecords();
  }
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtId = TextEditingController();

  RxList<UserInfoModal> userInfoList = <UserInfoModal>[].obs;

  Future<void> fetchRecords() async {
    List data = await DbHelper.dbHelper.readData();
    userInfoList.value = data
        .map(
          (e) => UserInfoModal.fromJson(e),
        )
        .toList();
  }

  Future<void> insertRecords(UserInfoModal userInfo) async {
    await DbHelper.dbHelper.insertData(userInfo);
    userInfoList.add(userInfo);
    fetchRecords();
  }

  Future<void> updateRecords(UserInfoModal userInfo,int id)
  async {
    await DbHelper.dbHelper.updateSqlData(userInfo, id);
    fetchRecords();
  }
}*/

class HomeController extends GetxController {
  var userList = <UserDataModal>[].obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtSalary = TextEditingController();
  TextEditingController txtId = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  onInit() {
    super.onInit();
    fetchRecords();
  }

  Future<void> fetchRecords() async {
    List data = await DbHelper.dbHelper.readData();
    userList.value = data
        .map(
          (e) => UserDataModal.formJson(e),
        )
        .toList();
  }

  Future<void> insertRecord(UserDataModal user) async {
    await DbHelper.dbHelper.insertData(user);
    await fetchRecords();
  }

  Future<void> updateRecords(UserDataModal user, int id) async {
    await DbHelper.dbHelper.updateData(user, id);
    fetchRecords();
  }

  Future<void> deleteRecord(int id) async {
    await DbHelper.dbHelper.deleteData(id);
    fetchRecords();
  }

  // Future<void> readLiveData(String value) async {
  //   List data = await DbHelper.dbHelper.liveSearch(value);
  //   userList.value = data
  //       .map(
  //         (e) => UserDataModal.formJson(e),
  //       )
  //       .toList();
  //   fetchRecords();
  // }
  Future<void> searchRecords(String query) async {
    List<Map<String, dynamic>> data = await DbHelper.dbHelper.searchData(query);

    userList.value = data.map((e) => UserDataModal.formJson(e)).toList();
  }

  // Firestore instance

  // Other existing methods...

  Future<void> uploadDataToFirestore(UserDataModal userInfo) async {
    try {
      // Convert `userList` to JSON
      List<Map<String, dynamic>> dataList =
          userList.map((user) => user.toMap()).toList();

      // Store in Firestore under user's account
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.email)
          .set({'userData': dataList});
      // .collection("usersData")
      // .add(userInfo.toMap());
      print('Document Added');

      Get.snackbar('Success', 'Data uploaded successfully!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload data: $e');
    }
  }

  Stream<QuerySnapshot> readDataFromFireStore() async* {
    try {
      var userdata = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.email)
          .collection("usersData")
          // .orderBy('name')
          .snapshots();
      yield* userdata;
    } catch (e) {
      print(e.toString());
    }
  }
}
