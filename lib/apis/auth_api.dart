import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'baseurl.dart';

abstract class IAuthApi {
  Future<String?> getOTP(String phone);

  Future<bool> verifyOTP(String phone, int otp);

  Future<bool> signup(String phone, String password);

  Future<String?> loginUser(String phone, String password);
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
  }

  @override
  Future<String?> loginUser(String phone, String password) async {
    const String endpoint = '/ath/cmplnr/login';
    final Uri url = Uri.parse('$baseUrl$endpoint');

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

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
// -----------------------------------------------------------------------------

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi();
});
