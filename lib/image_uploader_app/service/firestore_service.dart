import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/modal/image_modal.dart';
import 'package:fb_db_practice/image_uploader_app/modal/user_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Service/AuthService.dart';

/*class FireStoreService {
  FireStoreService._();

  static final FireStoreService instance = FireStoreService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(User user, {String? name, String? profileUrl}) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'email': user.email,
        'name': name ?? user.displayName ?? '',
        'profile': profileUrl ?? user.photoURL ?? '',
        'gallery': [],
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  Future<void> addGalleryItem(
      String userId, String imageUrl, String deleteId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'gallery': FieldValue.arrayUnion([
          {
            'url': imageUrl,
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'deleteId': deleteId
          }
        ])
      });
    } catch (e) {
      print("Error adding gallery item: $e");
    }
  }

  Future<void> deleteGalleryItem(String userId, String deleteId) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (docSnapshot.exists) {
        List<dynamic> gallery = docSnapshot.get('gallery');
        gallery.removeWhere((item) => item['deleteId'] == deleteId);
        await _firestore
            .collection('users')
            .doc(userId)
            .update({'gallery': gallery});
      }
    } catch (e) {
      print("Error deleting gallery item: $e");
    }
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String email;
  final String name;
  final String profile;
  final List<dynamic> gallery;

  UserModel({
    required this.email,
    required this.name,
    required this.profile,
    required this.gallery,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      profile: map['profile'] ?? '',
      gallery: map['gallery'] ?? [],
    );
  }
}

class FirestoreService {
  FirestoreService._();

  static final FirestoreService instance = FirestoreService._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  // Store user in Firestore if not exists
  Future<void> storeUserInFirestore(User? user) async {
    try {
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.email).get();

        if (!userDoc.exists) {
          await _firestore.collection('users').doc(user.email).set({
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
            'photoURL': user.photoURL,
            'phoneNumber': user.phoneNumber,
            'createdAt': FieldValue.serverTimestamp(),
          });
          print("User added to Firestore.");
        } else {
          print("User already exists in Firestore.");
        }
      }
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
  }

  // Fetch all users as a stream (real-time updates)
  Stream<List<Map<String, dynamic>>> fetchAllUsers() {
    return _firestore.collection('users').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> saveImage(
      User? user, String imageUrl, String imageHash, String deleteHash) async {
    await _firestore
        .collection('users')
        .doc(user!.email)
        .collection('imageGallery')
        .doc(imageHash)
        .set({
      'url': imageUrl,
      'hash': imageHash,
      'deleteHash': deleteHash,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Delete image from Firestore
  Future<void> deleteImage(User? user, String imageHash) async {
    await _firestore
        .collection('users')
        .doc(user!.email)
        .collection('imageGallery')
        .doc(imageHash)
        .delete();
  }

  // Get a real-time stream of images
  Stream<QuerySnapshot> getImagesStream(User? user) {
    return _firestore
        .collection('users')
        .doc(user!.email)
        .collection('imageGallery')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
