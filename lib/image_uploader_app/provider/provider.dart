import 'dart:io';
import 'dart:typed_data';

import 'package:fb_db_practice/image_uploader_app/modal/image_modal.dart';
import 'package:fb_db_practice/image_uploader_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadProvider extends ChangeNotifier {
  ImageUploadModal? imageUploadModal;

  Future<ImageUploadModal?> fromImageApi() async {
    final data = await ApiServices.apiServices.fetchImageData();
    imageUploadModal = ImageUploadModal.fromMap(data as Map);
    print('===========================provider============================');
    print(imageUploadModal);
    return imageUploadModal;
  }
}
