import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../service/api_service.dart';
import '../service/firestore_service.dart';

class ImgurController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = RxnString();
  User? user = FirebaseAuth.instance.currentUser;

  // Upload Image and Save to Firestore
  Future<void> uploadImage(Uint8List imageBytes) async {
    try {
      isLoading(true);
      String base64Image = base64Encode(imageBytes);
      final response = await ImgurApiHelper.uploadImage(base64Image);

      final imageUrl = response['data']['link'];
      final imageHash = response['data']['id'];
      final deleteHash = response['data']['deletehash'];

      // Save to Firestore
      await FirestoreService.instance
          .saveImage(user, imageUrl, imageHash, deleteHash);
      errorMessage.value = null;
      print("Uploaded Image URL: $imageUrl");
      print("Uploaded Image URL: $imageHash");
      print("Uploaded Image URL: $deleteHash");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  // Delete Image from Firestore and Imgur
  Future<void> deleteImage(String imageHash, String deleteHash) async {
    try {
      isLoading(true);
      await ImgurApiHelper.deleteImage(deleteHash);
      await FirestoreService.instance.deleteImage(user, imageHash);
      errorMessage.value = null;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

class UserController extends GetxController {
  var userList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUsers();
  }

  _fetchUsers() async {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      userList.value =
          snapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    });
  }

  Future<void> uploadImageToGallery(
      String userId, String imageUrl, String imageId, String deleteId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'galleryList': FieldValue.arrayUnion([
        {'imageUrl': imageUrl, 'imageId': imageId, 'deleteId': deleteId}
      ])
    });
  }
}

class UserModel {
  final String userId;
  final String email;
  final List<dynamic> galleryList;

  UserModel(
      {required this.userId, required this.email, required this.galleryList});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      userId: doc['userId'],
      email: doc['email'],
      galleryList: doc['galleryList'] ?? [],
    );
  }
}

class ImageUploaderController extends GetxController {
  var images = <Map<String, String>>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Upload Image
  Future<void> pickImageAndUpload(String userId) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      try {
        final response = await ImgurApiHelper.uploadImage(base64Image);
        final imageUrl = response['data']['link'];
        final imageId = response['data']['id'];
        final deleteId = response['data']['deletehash'];

        // Save to Firestore under the user's gallery
        await Get.find<UserController>()
            .uploadImageToGallery(userId, imageUrl, imageId, deleteId);

        // Add image to local list (UI)
        images.add(
            {'imageUrl': imageUrl, 'imageId': imageId, 'deleteId': deleteId});
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  // Fetch User Images
  Future<void> fetchUserImages(String userId) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((doc) {
      var userData = doc.data();
      if (userData != null && userData['galleryList'] != null) {
        images.value = List<Map<String, String>>.from(userData['galleryList']);
      }
    });
  }

  // Delete Image
  Future<void> deleteImage(String imageDeleteId) async {
    try {
      await ImgurApiHelper.deleteImage(imageDeleteId);
    } catch (e) {
      print("Error deleting image: $e");
    }
  }
}
