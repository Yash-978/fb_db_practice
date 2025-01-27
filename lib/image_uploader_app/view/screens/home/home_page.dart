import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/modal/user_modal.dart';
import 'package:flutter/material.dart';

import '../../../service/firestore_service.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Users '),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/upload');
              },
              icon: Icon(Icons.image)),
        ],
      ),
      /*body: FutureBuilder(
          future: FirebaseFireStoreService.firebaseImageUpload
              .readAllUserCloudFireStore(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            List data = snapshot.data!.docs;
            List userList = [];
            for (var user in data) {
              userList.add(UserModal.fromJson(user.data()));
            }
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index].name!),
                );
              },
            );
          },
        )*/
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance.collection("users").snapshots(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasError) {
      //       return Center(
      //         child: Text(snapshot.error.toString()),
      //       );
      //     }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     return ListView.builder(
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (context, index) {
      //         Map<String, dynamic> userList =
      //             snapshot.data!.docs[index].data() as Map<String, dynamic>;
      //         return ListTile(
      //           title: Text(userList['name']),
      //           subtitle: Text(userList['email']),
      //         );
      //       },
      //     );
      //   },
      // ),

    );
  }
}
