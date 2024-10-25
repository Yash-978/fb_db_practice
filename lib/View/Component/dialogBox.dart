import 'package:fb_db_practice/Controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Modal/UserModal.dart';
import '../../Service/crud_services.dart';
import '../Screens/home_page.dart';

Widget addDataDialog(
  double w,
  double h,
) {
  return AlertDialog(
    title: Text("Add Data"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtId,
            decoration: InputDecoration(
              label: Text("Id"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: h * 0.01),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtName,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtEmail,
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtPhone,
            decoration: InputDecoration(
              label: Text("Phone"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            UserInfoModal userInfo = UserInfoModal(
              id: int.parse(controller.txtId.text),
              name: controller.txtName.text,
              email: controller.txtEmail.text,
              phone: int.parse(controller.txtPhone.text),
            );
            controller.insertRecords(userInfo);
            CRUDServices().addDataToFireStore(userInfo);
            clearField();
            Get.back();
          },
          child: Text('Save')),
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel')),
    ],
  );
}



Widget updateDataDialog(
    double w, double h, HomeController controller, int index, id) {
  int pastId=controller.userInfoList[index].id!;

  controller.txtId =
      TextEditingController(text: controller.userInfoList[index].id.toString());
  controller.txtName =
      TextEditingController(text: controller.userInfoList[index].name);
  controller.txtEmail =
      TextEditingController(text: controller.userInfoList[index].email);
  controller.txtPhone = TextEditingController(
      text: controller.userInfoList[index].phone.toString());
  return AlertDialog(
    title: Text("Update Data"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtId,
            decoration: InputDecoration(
              label: Text("Id"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: h * 0.01),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtName,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtEmail,
            decoration: InputDecoration(
              label: Text("Email"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        SizedBox(
          width: w * 0.9,
          child: TextFormField(
            controller: controller.txtPhone,
            decoration: InputDecoration(
              label: Text("Phone"),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    ),
    actions: [
      TextButton(
          onPressed: () {
            UserInfoModal userInfo = UserInfoModal(
              id: int.parse(controller.txtId.text),
              name: controller.txtName.text,
              email: controller.txtEmail.text,
              phone: int.parse(controller.txtPhone.text),
            );
            controller.updateRecords(userInfo, pastId);
            // CRUDServices().addDataToFireStore(userInfo);
            clearField();
            Get.back();
          },
          child: Text('Save')),
      TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel')),
    ],
  );
}