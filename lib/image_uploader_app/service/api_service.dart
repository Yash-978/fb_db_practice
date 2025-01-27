import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../utils/global.dart';

/*class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Future<Map<String, dynamic>?> uploadImageToImgur(String imagePath) async {
    // final String clientId = 'YOUR_IMGUR_CLIENT_ID';
    final Uri uri = Uri.parse('https://api.imgur.com/3/image');
    final headers = {'Authorization': 'Client-ID $clientId'};
    final imageBytes = await File(imagePath).readAsBytes();
    final base64Image = base64Encode(imageBytes);

    final response = await http.post(
      uri,
      headers: headers,
      body: {'image': base64Image},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['link'];
    } else {
      // Handle errors
      return null;
    }
  }
}*/

class ApiServices {
  ApiServices._();

  static ApiServices apiServices = ApiServices._();
  String api = "https://api.imgur.com/3/image";

  Future<String?> fetchData(Uint8List img) async {
    const String clientId =
        "74e0e2178663c12"; // Replace with your Imgur Client ID

    String imageBase64 = base64Encode(img);

    var headers = {'Authorization': 'Client-ID $clientId'};
    var body = {'image': imageBase64};

    try {
      final client = http.Client();
      final response = await client.post(
        Uri.parse(api),
        headers: headers,
        body: body,
      );

      client.close();

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Upload successful: ${response.body}");
        return responseData['data']['link'];
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("An error occurred: $e");
      return null;
    }
  }

  Future<Map?> fetchImageData() async {
    Uri url = Uri.parse(api);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print("Upload successful: ${response.body}");
      return responseData;
    } else {
      print("Failed to upload image. Status code: ${response.statusCode}");
      return null;
    }
  }

  Future<bool> deleteImage(String deleteHash) async {
    String api = "https://api.imgur.com/3/image/$deleteHash";
    const String clientId =
        "YOUR_CLIENT_ID"; // Replace with your Imgur Client ID

    var headers = {'Authorization': 'Client-ID $clientId'};

    try {
      final client = http.Client();
      final response = await client.delete(
        Uri.parse(api),
        headers: headers,
      );

      client.close();

      if (response.statusCode == 200) {
        print("Deletion successful: ${response.body}");
        return true;
      } else {
        print("Failed to delete image. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("An error occurred: $e");
      return false;
    }
  }
}

const clientSecret = '20d211fc7fa583ecf345d0dcc0e1da1381acdfd0';
