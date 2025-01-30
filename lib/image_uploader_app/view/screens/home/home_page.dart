import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/modal/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../Service/AuthService.dart';
import '../../../service/firestore_service.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> users = [];

    // Fetch all users from Firestore
    Future<void> fetchAllUsers() async {
      try {
        QuerySnapshot querySnapshot = await firestore.collection('users').get();
        List<Map<String, dynamic>> userList = querySnapshot.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        setState(() {
          users = userList;
        });
      } catch (e) {
        print("Error fetching users: $e");
      }
    }

    void initState() {
      // TODO: implement initState
      super.initState();
      fetchAllUsers();
    }

    return Scaffold(
      drawer: Drawer(
        child: DrawerHeader(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user != null
                ? Column(
                    children: [
                      Text("Welcome, ${user.displayName ?? 'Guest'}"),
                      Text("Email: ${user.email}"),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/image-uploader');
                        },
                        child: const Text('Upload Image'),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(),
            CircleAvatar(
              radius: 60,
              child: Text(
                FirebaseAuth.instance.currentUser!.email
                    .toString()[0]
                    .toUpperCase(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.email.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            ListTile(
              onTap: () {
                AuthService.authService.logout();
                Navigator.pushReplacementNamed(context, "/login");
              },
              leading: Icon(
                Icons.logout_outlined,
              ),
              title: Text('Log Out'),
            )
          ],
        )),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              AuthService.authService.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: FirestoreService.instance.fetchAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No users found!"));
          }
          List<Map<String, dynamic>> users = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/upload-image');
                  },
                  child: ListTile(
                    leading: user['photoURL'] != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user['photoURL']))
                        : CircleAvatar(child: Icon(Icons.person)),
                    title: Text(user['displayName'] ?? 'No Name'),
                    subtitle: Text(user['email'] ?? 'No Email'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
/*
class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerHeader(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Text(
                  FirebaseAuth.instance.currentUser!.email
                      .toString()[0]
                      .toUpperCase(),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              ListTile(
                onTap: () {
                  AuthService.authService.logout();
                  Navigator.pushReplacementNamed(context, "/login");
                },
                leading: Icon(
                  Icons.logout_outlined,
                ),
                title: Text('Log Out'),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('All Users '),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.image)),
        ],
      ),
    );
  }
}*/

/* Column(
        children: [
          Text(FirebaseAuth.instance.currentUser!.uid),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
          Text(FirebaseAuth.instance.currentUser!.providerData.toString()),
          Text(FirebaseAuth.instance.currentUser!.emailVerified.toString()),

        ],
      ),*/
// body: FutureBuilder(
//   future: FirestoreService.instance.readAllUserCloudFireStore(),
//   builder: (context, snapshot) {
//     if (snapshot.hasError) {
//       return Center(
//         child: Text(snapshot.error.toString()),
//       );
//     }
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//
//     return SizedBox(
//       height: 150,
//       width: 300,
//     );
//   },
// ),
