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

  Future<bool> createComplainer({
    required String userId,
    required String username,
    required String name,
    required String fatherName,
    required String motherName,
    required String email,
    required String profilePicture,
    required String address,
    required String gender,
    required String identificationType,
    required String identificationNo,
    required String division,
    required String divisionId,
    required String district,
    required String districtId,
    required int postalCode,
    required String profession,
    required String birthDate,
  });

  Future<bool> resetPassword({required String phone, required String password});
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
          return jsonEncode(decodedData);
        }
      } catch (e) {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> uploadProfilePicture(File imageFile, String imageName) async {
    final Uri url = Uri.parse('/profilePicture/$fileUploadUrl');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['description'] = 'Profile picture upload'
        ..files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          contentType:
              MediaType('image', path.extension(imageFile.path).substring(1)),
        ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      final decodedData = jsonDecode(responseBody);
      final hasError = decodedData['error'] as bool;

      if (!hasError) {
        return decodedData['data']['image'].toString();
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> createComplainer({
    required String userId,
    required String username,
    required String name,
    required String fatherName,
    required String motherName,
    required String email,
    required String profilePicture,
    required String address,
    required String gender,
    required String identificationType,
    required String identificationNo,
    required String division,
    required String divisionId,
    required String district,
    required String districtId,
    required int postalCode,
    required String profession,
    required String birthDate,
  }) async {
    const String endpoint = '/cmplnr/crt';
    final Uri url = Uri.parse('$baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'username': username,
          'name': name,
          'fatherName': fatherName,
          'motherName': motherName,
          'email': email,
          'profilePicture': profilePicture,
          'address': address,
          'gender': gender,
          'identificationType': identificationType,
          'identificationNo': identificationNo,
          'division': division,
          'divisionId': divisionId,
          'district': district,
          'districtId': districtId,
          'postalCode': postalCode,
          'profession': profession,
          'birthDate': birthDate,
        }),
      );

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
  Future<bool> resetPassword(
      {required String phone, required String password}) async {
    const String endpoint = '/ath/reset';
    final Uri url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': phone,
          'newPassword': password,
        }),
      );
      final responseBody = response.body;
      try {
        final decodedData = jsonDecode(responseBody);
        final hasError = decodedData['error'] as bool;
        if (hasError) {
          return false;
        } else {
          return true;
        }
      } catch (e) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
// -----------------------------------------------------------------------------

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});
