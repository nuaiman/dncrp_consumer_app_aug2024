import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:dncrp_consumer_app/apis/auth_api.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/core/utils/snackbar.dart';
import 'package:dncrp_consumer_app/features/auth/screens/create_profile_screen.dart';
import 'package:dncrp_consumer_app/features/auth/screens/login_screen.dart';
import 'package:dncrp_consumer_app/features/auth/screens/password_screen.dart';
import 'package:dncrp_consumer_app/features/auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/notifiers/language_notifier.dart';
import '../../../core/utils/navigators.dart';
import '../../../models/area.dart';
import '../../dashboard/screens/dashboard_init_screen.dart';

class AuthNotifier extends StateNotifier<bool> {
  final LoaderNotifier _loader;
  final AuthApi _authApi;
  AuthNotifier({required LoaderNotifier loader, required AuthApi authApi})
      : _loader = loader,
        _authApi = authApi,
        super(false);

//         Future<void> checkLoginStatus() async {
//   final prefs = await SharedPreferences.getInstance();
//   final accessToken = prefs.getString('accessToken');
//   final phone = prefs.getString('phone');
//   final password = prefs.getString('password'); // if saved
//   if (accessToken != null && phone != null) {
//     // Use the accessToken to make authenticated requests
//     // Optionally use phone and password if needed
//     // Navigate to the dashboard or main screen
//     // navigateToDashboard();
//   } else {
//     // Navigate to the login screen
//     // navigateToLogin();
//   }
// }

  Future<void> getOTP(
      BuildContext context, AppLanguage language, String phoneNumber) async {
    _loader.updateState(true);
    final response = await _authApi.getOTP(phoneNumber);
    _loader.updateState(false);
    if (response != null) {
      navigate(context, OtpScreen(phoneNumber: phoneNumber));
      showSnackbar(context, response);
    } else {
      showSnackbar(
          context,
          language == AppLanguage.english
              ? 'Couldnot send an OTP'
              : 'ও.টি.পি পাঠানো যায়নি');
      return;
    }
  }

  Future<void> reSendOTP(
      BuildContext context, AppLanguage language, String phoneNumber) async {
    _loader.updateState(true);
    final response = await _authApi.getOTP(phoneNumber);
    _loader.updateState(false);
    if (response != null) {
      showSnackbar(context, response);
    } else {
      showSnackbar(
          context,
          language == AppLanguage.english
              ? 'Couldnot send an OTP'
              : 'ও.টি.পি পাঠানো যায়নি');
      return;
    }
  }

  Future<void> verifyOTP(BuildContext context, AppLanguage language,
      String phoneNumber, int otp) async {
    _loader.updateState(true);
    final response = await _authApi.verifyOTP(phoneNumber, otp);
    _loader.updateState(false);
    if (response == true) {
      navigateAndRemoveUntil(
          context,
          PasswordScreen(
            phoneNumber: phoneNumber,
            userId: null,
            isSignup: true,
            isReset: false,
            isNeedChange: false,
          ));
    } else {
      showSnackbar(
          context,
          language == AppLanguage.english
              ? 'Couldnot verify OTP'
              : 'ও.টি.পি যাচাই করা যায়নি');
      return;
    }
  }

  Future<void> signup(
    BuildContext context,
    AppLanguage language,
    String phone,
    String password,
  ) async {
    if (phone.length < 11) {
      showSnackbar(
        context,
        language == AppLanguage.bangla
            ? 'অচল ফোন নম্বর'
            : 'Invalid phone number',
      );
      return;
    }
    _loader.updateState(true);
    final response = await _authApi.signup(phone, password);
    _loader.updateState(false);
    if (response == true) {
      navigateAndRemoveUntil(context, const LoginScreen());
    } else {
      showSnackbar(
        context,
        language == AppLanguage.bangla
            ? 'সাইন আপ করা যায়নি'
            : 'Could not signup',
      );
    }
  }

  Future<void> login(
    BuildContext context,
    AppLanguage language,
    String phone,
    String password,
  ) async {
    if (phone.length < 11) {
      showSnackbar(
        context,
        language == AppLanguage.bangla
            ? 'অচল ফোন নম্বর'
            : 'Invalid phone number',
      );
      return;
    }
    _loader.updateState(true);
    final response = await _authApi.loginUser(phone, password);
    _loader.updateState(false);

    if (response != null) {
      try {
        final decodedData = jsonDecode(response);
        final hasProfile = decodedData['hasProfile'];
        final userId = decodedData['id'];
        final accessToken = decodedData['accessToken'] ?? '';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('phone', phone);
        await prefs.setString('password', password);
        //
        if (hasProfile) {
          navigateAndRemoveUntil(context, const DashboardInit());
        } else {
          navigateAndRemoveUntil(
              context,
              CreateProfileScreen(
                userId: userId,
                phoneNumber: phone,
              ));
        }
      } catch (e) {
        showSnackbar(
          context,
          language == AppLanguage.bangla
              ? 'লগইন করা যায়নি'
              : 'Could not login',
        );
      }
    } else {
      showSnackbar(
        context,
        language == AppLanguage.bangla ? 'লগইন করা যায়নি' : 'Could not login',
      );
    }
  }

  Future<String?> uploadProfilePicture(File imageFile) async {
    final imageName = path.basename(imageFile.path);
    final response = await _authApi.uploadProfilePicture(imageFile, imageName);
    if (response != null) {
      return response;
    } else {
      return null;
    }
  }

  Future<void> createUser(
    BuildContext context,
    File? imageFile, {
    required String userId,
    required String username,
    required String name,
    required String fatherName,
    required String motherName,
    required String email,
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
    if (imageFile != null) {
      _loader.updateState(true);
      final imageUploadResponse = await uploadProfilePicture(imageFile);
      final response = await _authApi.createComplainer(
        userId: userId,
        username: username,
        name: name,
        fatherName: fatherName,
        motherName: motherName,
        email: email,
        profilePicture: imageUploadResponse!,
        address: address,
        gender: gender,
        identificationType: identificationType,
        identificationNo: identificationNo,
        division: division,
        divisionId: divisionId,
        district: district,
        districtId: districtId,
        postalCode: postalCode,
        profession: profession,
        birthDate: birthDate,
      );
      _loader.updateState(false);
      if (!response) {
        return;
      } else {
        navigateAndRemoveUntil(context, LoginScreen());
      }
    } else {
      _loader.updateState(true);
      final response = await _authApi.createComplainer(
        userId: userId,
        username: username,
        name: name,
        fatherName: fatherName,
        motherName: motherName,
        email: email,
        profilePicture: '',
        address: address,
        gender: gender,
        identificationType: identificationType,
        identificationNo: identificationNo,
        division: division,
        divisionId: divisionId,
        district: district,
        districtId: districtId,
        postalCode: postalCode,
        profession: profession,
        birthDate: birthDate,
      );
      _loader.updateState(false);
      if (!response) {
        return;
      } else {
        navigateAndRemoveUntil(context, LoginScreen());
      }
    }
  }
}
// -----------------------------------------------------------------------------

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final loader = ref.watch(loaderProvider.notifier);
  final authApi = ref.watch(authApiProvider);
  return AuthNotifier(loader: loader, authApi: authApi);
});
