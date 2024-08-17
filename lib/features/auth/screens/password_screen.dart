import 'package:dncrp_consumer_app/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/notifiers/loader_notifier.dart';
import '../../../core/utils/snackbar.dart';
import '../../../core/widgets/rounded_elevated_button.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  final String? userId;
  final String phoneNumber;
  final bool isSignup;
  final bool isReset;
  final bool isNeedChange;

  const PasswordScreen({
    super.key,
    required this.phoneNumber,
    required this.userId,
    required this.isSignup,
    required this.isReset,
    required this.isNeedChange,
  });

  @override
  ConsumerState<PasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<PasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);
    final isLoading = ref.watch(loaderProvider);

    String getHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Registration';
        case AppLanguage.bangla:
          return 'রেজিস্ট্রেশন করুন';
        default:
          return 'Registration';
      }
    }

    String getPasswordText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Password';
        case AppLanguage.bangla:
          return 'পাসওয়ার্ড';
      }
    }

    String getConfirmPasswordText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Confirm password';
        case AppLanguage.bangla:
          return 'পাসওয়ার্ড নিশ্চিত করুন';
      }
    }

    String getNextText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Next';
        case AppLanguage.bangla:
          return 'পরবর্তী';
      }
    }

    void signUp(BuildContext context, AppLanguage language, String phone,
        String password) {
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        showSnackbar(
          context,
          language == AppLanguage.bangla
              ? 'অচল পাসওয়ার্ড'
              : 'Invalid password',
        );
        return;
      }
      ref
          .read(authProvider.notifier)
          .signup(context, language, phone, password);
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(Pngs.logo),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: Scaffold(
        extendBody: false,
        extendBodyBehindAppBar: false,
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.95),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(Pngs.logo),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  getHeaderText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: getPasswordText(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: getConfirmPasswordText(),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppPalette.green,
                  ),
                )
              : RoundedElevatedButton(
                  label: getNextText(),
                  onTap: widget.isSignup
                      ? () {
                          signUp(context, languageProvider, widget.phoneNumber,
                              passwordController.text.trim());
                        }
                      : () {},
                ),
        ),
      ),
    );
  }
}
