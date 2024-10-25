// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fb_db_practice/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
/*
import 'package:fb_db_practice/Service/AuthService.dart';
import 'package:fb_db_practice/View/Screens/home_page.dart';
import 'package:fb_db_practice/View/Screens/signUp_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'View/Screens/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
}

class UserInfoModal {
  String? id;
  String? name;
  String? email;
  String? phone;

  UserInfoModal({this.id, this.name, this.email, this.phone});

  factory UserInfoModal.fromJson(Map<String, dynamic> json) {
    return UserInfoModal(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}

class Data {
  Future<void> createUserProfileInFirebase(UserInfoModal userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_profiles')
          .add(userProfile.toMap());
    } catch (e) {
      print('Error creating user profile in Firebase: $e');
    }
  }

  Future<void> createUserProfileInSQLite(
      UserInfoModal userProfile, Database db) async {
    try {
      await db.insert(
        'user_profiles',
        userProfile.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error creating user profile in SQLite: $e');
    }
  }

  Future<List<UserInfoModal>> readUserProfilesFromFirebase() async {
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('user_profiles').get();

      return querySnapshot.docs
          .map((doc) => UserInfoModal.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error reading user profiles from Firebase: $e');
      return [];
    }
  }

  Future<List<UserInfoModal>> readUserProfilesFromSQLite(Database db) async {
    try {
      final List<Map<String, dynamic>> maps = await db.query('user_profiles');

      return List.generate(maps.length, (i) {
        return UserInfoModal.fromJson(maps[i]);
      });
    } catch (e) {
      print('Error reading user profiles from SQLite: $e');
      return [];
    }
  }

  Future<void> updateUserProfileInFirebase(
      String documentId, UserInfoModal userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_profiles')
          .doc(documentId)
          .update(userProfile.toMap());
    } catch (e) {
      print('Error updating user profile in Firebase: $e');
    }
  }

  Future<void> updateUserProfileInSQLite(
      UserInfoModal userProfile, Database db) async {
    try {
      await db.update(
        'user_profiles',
        userProfile.toMap(),
        where: 'name = ?', // Assuming 'name' is a unique identifier here
        whereArgs: [userProfile.name],
      );
    } catch (e) {
      print('Error updating user profile in SQLite: $e');
    }
  }

  Future<void> deleteUserProfileFromFirebase(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_profiles')
          .doc(documentId)
          .delete();
    } catch (e) {
      print('Error deleting user profile from Firebase: $e');
    }
  }

  Future<void> deleteUserProfileFromSQLite(String name, Database db) async {
    try {
      await db.delete(
        'user_profiles',
        where: 'name = ?',
        whereArgs: [name],
      );
    } catch (e) {
      print('Error deleting user profile from SQLite: $e');
    }
  }
}

class UserProfileController extends GetxController {
  final Data data = Data();
  var userList = <UserInfoModal>[].obs;
  Database? database;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
    fetchUserProfiles();
  }

  Future<void> _initializeDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'user_profiles.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_profiles(id TEXT, name TEXT, email TEXT, phone TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> fetchUserProfiles() async {
    List<UserInfoModal> firebaseProfiles = await data.readUserProfilesFromFirebase();
    if (database != null) {
      List<UserInfoModal> sqliteProfiles =
      await data.readUserProfilesFromSQLite(database!);
      userList.assignAll([...firebaseProfiles, ...sqliteProfiles]);
    }
  }

  Future<void> addUserProfile(UserInfoModal userProfile) async {
    await data.createUserProfileInFirebase(userProfile);
    if (database != null) {
      await data.createUserProfileInSQLite(userProfile, database!);
    }
    fetchUserProfiles();
  }

  Future<void> updateUserProfile(UserInfoModal userProfile) async {
    if (userProfile.id != null) {
      await data.updateUserProfileInFirebase(userProfile.id!, userProfile);
    }
    if (database != null) {
      await data.updateUserProfileInSQLite(userProfile, database!);
    }
    fetchUserProfiles();
  }

  Future<void> deleteUserProfile(UserInfoModal userProfile) async {
    if (userProfile.id != null) {
      await data.deleteUserProfileFromFirebase(userProfile.id!);
    }
    if (database != null && userProfile.name != null) {
      await data.deleteUserProfileFromSQLite(userProfile.name!, database!);
    }
    fetchUserProfiles();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter CRUD App with GetX',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserProfilePage(),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final UserProfileController controller = Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profiles')),
      body: Obx(() {
        if (controller.userList.isEmpty) {
          return Center(child: Text('No User Profiles'));
        }
        return ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return ListTile(
              title: Text(user.name ?? ''),
              subtitle: Text('${user.email ?? ''} - ${user.phone ?? ''}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditDialog(context, user);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      controller.deleteUserProfile(user);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDialog(context);
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add User Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final userProfile = UserInfoModal(
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );
              controller.addUserProfile(userProfile);
              Navigator.of(context).pop();
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, UserInfoModal user) {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final phoneController = TextEditingController(text: user.phone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              final updatedUserProfile = UserInfoModal(
                id: user.id,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              );
              controller.updateUserProfile(updatedUserProfile);
              Navigator.of(context).pop();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }
}
*/