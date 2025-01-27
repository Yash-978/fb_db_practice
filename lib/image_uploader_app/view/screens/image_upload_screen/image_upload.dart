import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:fb_db_practice/image_uploader_app/modal/image_modal.dart';
import 'package:fb_db_practice/image_uploader_app/provider/provider.dart';
import 'package:fb_db_practice/image_uploader_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Uint8List? image;
XFile? xFile;
File? _selectedImage;
bool _isImageSelected = false;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  @override
  Widget build(BuildContext context) {
    ImageUploadProvider imageUploadProviderFalse =
        Provider.of<ImageUploadProvider>(context, listen: false);
    ImageUploadProvider imageUploadProviderTrue =
        Provider.of<ImageUploadProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 150,
              backgroundImage:
                  xFile == null ? null : FileImage(File(xFile!.path)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () {
                      setState(() async {
                        ImagePicker imagePicker = ImagePicker();
                        xFile = await imagePicker.pickImage(
                            source: ImageSource.gallery);
                        image = await xFile!.readAsBytes();
                        String? imageUrl =
                            await ApiServices.apiServices.fetchData(image!);


                      });
                    },
                    child: const Icon(Icons.photo)),
                OutlinedButton(
                    onPressed: () {}, child: const Icon(Icons.camera)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
