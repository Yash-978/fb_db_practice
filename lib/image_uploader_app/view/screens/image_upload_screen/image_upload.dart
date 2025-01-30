import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/modal/image_modal.dart';
import 'package:fb_db_practice/image_uploader_app/provider/provider.dart';
import 'package:fb_db_practice/image_uploader_app/service/api_service.dart';
import 'package:fb_db_practice/image_uploader_app/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../controller/controller.dart';

/*ImageUploadProvider imageUploadProviderFalse =
        Provider.of<ImageUploadProvider>(context, listen: false);
    ImageUploadProvider imageUploadProviderTrue =
        Provider.of<ImageUploadProvider>(context, listen: true);*/

// File? _selectedImage;
// bool _isImageSelected = false;

ImgurController imgurController = Get.put(ImgurController());
User? user = FirebaseAuth.instance.currentUser;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() async {
            ImagePicker imagePicker = ImagePicker();
            xFile = await imagePicker.pickImage(source: ImageSource.gallery);
            Uint8List? image = await xFile!.readAsBytes();
            await imgurController.uploadImage(image);
          });
        },
        child: const Icon(Icons.photo),
      ),
      appBar: AppBar(
        title: const Text('Image Uploader'),
      ),
      body: StreamBuilder(
        stream: FirestoreService.instance.getImagesStream(user),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No images uploaded yet.'));
          }

          final images = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 9 / 16),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final image = images[index].data() as Map<String, dynamic>;
                final imageHash = image['hash'];
                final deleteHash = image['deleteHash'];

                return Stack(
                  children: [
                    Container(
                      height: 400,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.orangeAccent.shade400,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                image['url'],
                              ))),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: IconButton(
                          onPressed: () async {
                            await imgurController.deleteImage(
                                imageHash, deleteHash);
                          },
                          icon: const Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       CircleAvatar(
      //         radius: 150,
      //         backgroundImage:
      //             xFile == null ? null : FileImage(File(xFile!.path)),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child:
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

/*
ImagePicker imagePicker = ImagePicker();
                        xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        image = await xFile!.readAsBytes();
                        // String? imageUrl =
                        //     await ApiServices.apiServices.fetchData(image!);
*/
