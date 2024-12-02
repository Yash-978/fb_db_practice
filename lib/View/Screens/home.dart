import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/controller.dart';
import '../../Service/AuthService.dart';
import '../Component/dialogBox.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Text(
                      FirebaseAuth.instance.currentUser!.email
                          .toString()[0]
                          .toUpperCase(),
                    ),
                  ),
                  Text(FirebaseAuth.instance.currentUser!.email.toString()),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                AuthService.authService.logout();
                Get.snackbar(
                    FirebaseAuth.instance.currentUser!.email.toString(),
                    "is Logged Out");
                Get.offAllNamed('/login');
              },
              title: Text('Log Out'),
              leading: Icon(Icons.logout),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => entryDialogue(300, 10, homeController),
          );
          homeController.txtId.clear();
          homeController.txtName.clear();
          homeController.txtPhone.clear();
          homeController.txtAge.clear();
          homeController.txtSalary.clear();

          // homeController.insertRecord(user);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                // homeController.uploadDataToFirestore();
              },
              child: Text('Upload To FireStore'))
        ],
        title: Text('Home'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: SizedBox(
            width: 350,
            child: TextField(
              onChanged: (value) {
                homeController.searchRecords(value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: homeController.userList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(homeController.userList[index].name! +
                  homeController.userList[index].age.toString()),
              subtitle: Text(homeController.userList[index].phone.toString() +
                  homeController.userList[index].salary.toString()),
              leading: Text(homeController.userList[index].id.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => updateDialogue(
                              300,
                              10,
                              homeController,
                              index,
                              homeController.userList[index].id!),
                        );
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        homeController
                            .deleteRecord(homeController.userList[index].id!);
                      },
                      icon: Icon(Icons.delete)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
