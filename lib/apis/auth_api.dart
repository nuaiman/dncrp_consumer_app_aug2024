import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'baseurl.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

abstract class IAuthApi {
  Future<String?> getOTP(String phone);

  Future<bool> verifyOTP(String phone, int otp);

  Future<bool> signup(String phone, String password);

  Future<String?> loginUser(String phone, String password);

  uploadProfilePicture(File imageFile, String imageName);
}
// -----------------------------------------------------------------------------

class AuthApi implements IAuthApi {
  @override
  Future<String?> getOTP(String phone) async {
    const String endpoint = '/ath/otpsend';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phone,
        }),
      );
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final otp = decodedData['data']['otp'];
        return otp.toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> verifyOTP(String phone, int otp) async {
    const String endpoint = '/ath/otpverified';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phone,
          'otpCode': otp,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signup(String phone, String password) async {
    const String endpoint = '/ath/cmplnr/rgstr';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': phone,
          'password': password,
        }),
      );
      print(response.body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String?> loginUser(String phone, String password) async {
    const String endpoint = '/ath/cmplnr/login';
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': phone,
          'password': password,
        }),
      );
      final responseBody = response.body;
      try {
        final decodedData = jsonDecode(responseBody);
        final hasError = decodedData['error'] as bool;
        if (hasError) {
          return null;
        } else {
          return jsonEncode(decodedData['data']);
        }
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> uploadProfilePicture(File imageFile, String imageName) async {
    final String endpoint =
        '/images/evidences-akajsdfljasdfoewruower93427/profilePicture/$imageName';
    final Uri url = Uri.parse('$profileImageUrl$endpoint');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['description'] = 'Profile picture upload'
        ..files.add(await http.MultipartFile.fromPath(
          'file', // The name of the form field
          imageFile.path,
          contentType:
              MediaType('image', path.extension(imageFile.path).substring(1)),
        ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print(responseBody);

      return true;

      // if (response.statusCode == 200) {
      //   print('Upload successful');
      //   print('Response body: $responseBody');
      //   return true;
      // } else {
      //   print('Failed to upload image. Status code: ${response.statusCode}');
      //   print('Response body: $responseBody');
      //   return false;
      // }
    } catch (e) {
      print('Error occurred during file upload: $e');
      return false;
    }
  }
}
// -----------------------------------------------------------------------------

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});
