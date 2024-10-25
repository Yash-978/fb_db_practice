import 'package:fb_db_practice/Modal/UserModal.dart';
import 'package:fb_db_practice/Service/LocalDatabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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
}
