import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../utils/global.dart';

// class ApiServices {
//   ApiServices._();
//
//   static ApiServices apiServices = ApiServices._();
//   String api = "https://api.imgur.com/3/image";
//
//   Future<String?> fetchData(Uint8List img) async {
//
//
//     String imageBase64 = base64Encode(img);
//
//     var headers = {'Authorization': 'Client-ID $clientId'};
//     var body = {'image': imageBase64};
//
//     try {
//       final client = http.Client();
//       final response = await client.post(
//         Uri.parse(api),
//         headers: headers,
//         body: body,
//       );
//
//       client.close();
//
//       if (response.statusCode == 200) {
//         var responseData = jsonDecode(response.body);
//         print("Upload successful: ${response.body}");
//         return responseData['data']['link'];
//       } else {
//         print("Failed to upload image. Status code: ${response.statusCode}");
//         return null;
//       }
//     } catch (e) {
//       print("An error occurred: $e");
//       return null;
//     }
//   }
//
//   Future<Map?> fetchImageData() async {
//     Uri url = Uri.parse(api);
//     Response response = await http.get(url);
//     if (response.statusCode == 200) {
//       var responseData = jsonDecode(response.body);
//       print("Upload successful: ${response.body}");
//       return responseData;
//     } else {
//       print("Failed to upload image. Status code: ${response.statusCode}");
//       return null;
//     }
//   }
//
//   Future<bool> deleteImage(String deleteHash) async {
//     String api = "https://api.imgur.com/3/image/$deleteHash";
//
//
//     var headers = {'Authorization': 'Client-ID $clientId'};
//
//     try {
//       final client = http.Client();
//       final response = await client.delete(
//         Uri.parse(api),
//         headers: headers,
//       );
//
//       client.close();
//
//       if (response.statusCode == 200) {
//         print("Deletion successful: ${response.body}");
//         return true;
//       } else {
//         print("Failed to delete image. Status code: ${response.statusCode}");
//         return false;
//       }
//     } catch (e) {
//       print("An error occurred: $e");
//       return false;
//     }
//   }
// }
class ImgurApiHelper {
  static const String _baseUrl = "https://api.imgur.com/3/image";

  // Upload Image (Base64)
  static Future<Map<String, dynamic>> uploadImage(String base64Image) async {
    final url = Uri.parse(_baseUrl);
    final headers = {
      "Authorization": "Client-ID $clientId",
      "Content-Type": "application/json"
    };

    final body = jsonEncode({"image": base64Image, "type": "base64"});

    final response = await http.post(url, headers: headers, body: body);
    return _handleResponse(response);
  }

  // Get Image Details
  static Future<Map<String, dynamic>> getImage(String imageHash) async {
    final url = Uri.parse("$_baseUrl/$imageHash");
    final headers = {"Authorization": "Client-ID $clientId"};

    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  // Delete Image
  static Future<Map<String, dynamic>> deleteImage(
      String imageDeleteHash) async {
    final url = Uri.parse("$_baseUrl/$imageDeleteHash");
    final headers = {"Authorization": "Client-ID $clientId"};

    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  // Handle API Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> decoded = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return decoded;
    } else {
      throw Exception("Error: ${decoded['data']['error']}");
    }
  }
}
