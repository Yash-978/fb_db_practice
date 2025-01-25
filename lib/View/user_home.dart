import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Service/AuthService.dart';

// class UserHome extends StatelessWidget {
//   const UserHome({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppBar(
//           title: Text('home'),
//         ),
//
//       ),
//       body: Column(
//         children: [
//           CircleAvatar(
//             radius: 25,
//             child: Text(
//               FirebaseAuth.instance.currentUser!.email
//                   .toString()[0]
//                   .toUpperCase(),
//             ),
//           ),
//           Text(FirebaseAuth.instance.currentUser!.email.toString()),
//           ListTile(
//             onTap: () {
//               AuthService.authService.logout();
//               Get.snackbar(
//                   FirebaseAuth.instance.currentUser!.email.toString(),
//                   "is Logged Out");
//               Get.offAllNamed('/login');
//             },
//             title: Text('Log Out'),
//             leading: Icon(Icons.logout),
//           )
//         ],
//       ),
//     );
//   }
// }
class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService.authService.logout();
              Get.snackbar(
                'Logged Out',
                'You have been successfully logged out.',
                snackPosition: SnackPosition.BOTTOM,
              );
              Get.offAllNamed('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user?.photoURL != null
                  ? NetworkImage(user!.photoURL!)
                  : null,
              child: user?.photoURL == null
                  ? Text(
                user?.displayName != null
                    ? user!.displayName![0].toUpperCase()
                    : 'U',
                style: const TextStyle(fontSize: 40),
              )
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              user?.displayName ?? 'No Name Provided',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              user?.email ?? 'No Email Provided',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                // Navigate to profile editing page (if implemented)
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings page (if implemented)
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await AuthService.authService.logout();
                Get.snackbar(
                  'Logged Out',
                  'You have been successfully logged out.',
                  snackPosition: SnackPosition.BOTTOM,
                );
                Get.offAllNamed('/login');
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



