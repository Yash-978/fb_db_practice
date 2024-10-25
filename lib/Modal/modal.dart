import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';

import 'UserModal.dart';

class Data{
  Future<void> createUserProfileInFirebase(UserInfoModal userProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('user_profiles')
          .add(userProfile.toMap());
      print('User profile created in Firebase');
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
      print('User profile created in SQLite');
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
      print('User profile updated in Firebase');
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
      print('User profile updated in SQLite');
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
      print('User profile deleted from Firebase');
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
      print('User profile deleted from SQLite');
    } catch (e) {
      print('Error deleting user profile from SQLite: $e');
    }
  }

  Future<void> saveUserProfile(UserInfoModal userProfile, Database db) async {
    await createUserProfileInFirebase(userProfile);
    await createUserProfileInSQLite(userProfile, db);
  }

  Future<List<UserInfoModal>> getUserProfiles(Database db) async {
    List<UserInfoModal> firebaseProfiles = await readUserProfilesFromFirebase();
    List<UserInfoModal> sqliteProfiles = await readUserProfilesFromSQLite(db);
    return [...firebaseProfiles, ...sqliteProfiles];
  }

  Future<void> updateUserProfile(
      String documentId, UserInfoModal userProfile, Database db) async {
    await updateUserProfileInFirebase(documentId, userProfile);
    await updateUserProfileInSQLite(userProfile, db);
  }

  Future<void> deleteUserProfile(
      String documentId, String name, Database db) async {
    await deleteUserProfileFromFirebase(documentId);
    await deleteUserProfileFromSQLite(name, db);
  }

}