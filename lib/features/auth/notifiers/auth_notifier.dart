import 'dart:convert';

import 'package:dncrp_consumer_app/apis/auth_api.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/core/utils/snackbar.dart';
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

class AuthNotifier extends StateNotifier<List<DivisionWithDistricts>> {
  final LoaderNotifier _loader;
  final AuthApi _authApi;
  AuthNotifier({required LoaderNotifier loader, required AuthApi authApi})
      : _loader = loader,
        _authApi = authApi,
        super([]);

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
      final decodedResponse = json.decode(response);
      final data = decodedResponse['data'];
      final accessToken = data['accessToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', accessToken);
      await prefs.setString('phone', phone);
      await prefs.setString('password', password);
      //
      navigateAndRemoveUntil(context, const DashboardInit());
    } else {
      showSnackbar(
        context,
        language == AppLanguage.bangla ? 'লগইন করা যায়নি' : 'Could not login',
      );
    }
  }
}
// -----------------------------------------------------------------------------

final authProvider =
    StateNotifierProvider<AuthNotifier, List<DivisionWithDistricts>>((ref) {
  final loader = ref.watch(loaderProvider.notifier);
  final authApi = ref.watch(authApiProvider);
  return AuthNotifier(loader: loader, authApi: authApi);
});
