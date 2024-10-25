import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/Controller/controller.dart';
import 'package:fb_db_practice/Modal/UserModal.dart';
import 'package:fb_db_practice/Service/AuthService.dart';
import 'package:fb_db_practice/Service/crud_services.dart';
import 'package:fb_db_practice/View/Component/dialogBox.dart';
import 'package:fb_db_practice/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var controller = Get.put(HomeController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => addDataDialog(w, h),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, "/cart");

          }, icon: Icon(Icons.shopping_cart))
        ],
      ),
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
                AuthService().logout();
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
      // body: Obx(
      //   () => ListView.builder(
      //     itemCount: controller.userInfoList.length,
      //     itemBuilder: (context, index) {
      //       return Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Card(
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15)),
      //           child: ListTile(
      //             tileColor:
      //                 HomeScreenColorlist[index % HomeScreenColorlist.length],
      //             title: Text(controller.userInfoList[index].name!),
      //             subtitle: Text(controller.userInfoList[index].email!),
      //             leading: Text(controller.userInfoList[index].id.toString()),
      //             trailing: Row(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 IconButton(
      //                     onPressed: () {
      //                       showDialog(
      //                         context: context,
      //                         builder: (context) => updateDataDialog(
      //                             w,
      //                             h,
      //                             controller,
      //                             index,
      //                             controller.userInfoList[index].id),
      //                       );
      //                     },
      //                     icon: Icon(Icons.edit)),
      //                 Text(controller.userInfoList[index].phone!.toString()),
      //               ],
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: CRUDServices().readDataFromFireStore(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map(
                  (DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(data['id'].toString()),
                      ),
                      title: Text(data['email']),
                      subtitle: Text(data['name']),
                      trailing: Text(data['phone'].toString()),
                    );
                  },
                )
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}

void clearField() {
  controller.txtId.clear();
  controller.txtName.clear();
  controller.txtEmail.clear();
  controller.txtPhone.clear();
}
