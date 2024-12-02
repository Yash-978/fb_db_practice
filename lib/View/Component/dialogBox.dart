/*
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
*/



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/controller.dart';
import '../../Modal/UserModal.dart';


Widget entryDialogue(double h, w, HomeController homeController) {
  return AlertDialog(
    title: Text('Add Data'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: homeController.txtId,
            decoration: InputDecoration(
              label: Text("Id"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: homeController.txtName,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: homeController.txtAge,
            decoration: InputDecoration(
              label: Text("Age"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: homeController.txtPhone,
            decoration: InputDecoration(
              label: Text("Phone"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          TextFormField(
            controller: homeController.txtSalary,
            decoration: InputDecoration(
              label: Text("Salary"),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
      TextButton(
          onPressed: () {
            String name = homeController.txtName.text;
            int id = int.parse(homeController.txtId.text);
            int age = int.parse(homeController.txtAge.text);
            int phone = int.parse(homeController.txtPhone.text);
            double salary = double.parse(homeController.txtSalary.text);
            UserDataModal user = UserDataModal(
              name: name,
              id: id,
              age: age,
              salary: salary,
              phone: phone,
            );
            homeController.insertRecord(user);
            homeController.uploadDataToFirestore(user);
            // DbHelper.dbHelper.insertData(user);
            homeController.txtId.clear();
            homeController.txtName.clear();
            homeController.txtAge.clear();
            homeController.txtSalary.clear();
            homeController.txtPhone.clear();

            Get.back();
          },
          child: Text('Save'))
    ],
  );
}

Widget  updateDialogue(
    double h, w, HomeController homeController, int index, int id) {
  int pastId= homeController.userList[index].id!;
  homeController.txtId =
      TextEditingController(text: homeController.userList[index].id.toString());
  homeController.txtName =
      TextEditingController(text: homeController.userList[index].name);
  homeController.txtAge = TextEditingController(
      text: homeController.userList[index].age.toString());
  homeController.txtSalary = TextEditingController(
      text: homeController.userList[index].salary.toString());
  homeController.txtPhone = TextEditingController(
      text: homeController.userList[index].phone.toString());

  return AlertDialog(
    title: Text('Update Data'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: homeController.txtId,
            decoration: InputDecoration(
              label: Text("Id"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: homeController.txtName,
            decoration: InputDecoration(
              label: Text("Name"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: homeController.txtAge,
            decoration: InputDecoration(
              label: Text("Age"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: homeController.txtPhone,
            decoration: InputDecoration(
              label: Text("Phone"),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: homeController.txtSalary,
            decoration: InputDecoration(
              label: Text("Salary"),
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
      TextButton(
          onPressed: () {
            String name = homeController.txtName.text;
            int id = int.parse(homeController.txtId.text);
            int age = int.parse(homeController.txtAge.text);
            int phone = int.parse(homeController.txtPhone.text);
            double salary = double.parse(homeController.txtSalary.text);
            UserDataModal user = UserDataModal(
              name: name,
              id: id,
              age: age,
              salary: salary,
              phone: phone,
            );
            homeController.updateRecords(user, pastId);

            homeController.txtId.clear();
            homeController.txtName.clear();
            homeController.txtAge.clear();
            homeController.txtSalary.clear();
            homeController.txtPhone.clear();


            Get.back();
          },
          child: Text('Update'))
    ],
  );
}
