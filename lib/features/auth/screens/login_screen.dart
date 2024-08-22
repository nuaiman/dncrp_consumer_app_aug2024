import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/notifiers/loader_notifier.dart';
import '../../../core/utils/navigators.dart';
import '../../../core/widgets/phone_number_input.dart';
import '../../../core/widgets/rounded_elevated_button.dart';
import '../notifiers/auth_notifier.dart';
import 'phone_number_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final PhoneController phoneController = PhoneController(
    const PhoneNumber(isoCode: IsoCode.BD, nsn: ''),
  );
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(
    WidgetRef ref,
    AppLanguage language,
    String phone,
    String password,
  ) {
    ref.read(authProvider.notifier).login(context, language, phone, password);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);
    final isLoading = ref.watch(loaderProvider);

    String getHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Please login';
        case AppLanguage.bangla:
          return 'লগইন করুন';
      }
    }

    // String getEnterMobileText() {
    //   switch (languageProvider) {
    //     case AppLanguage.english:
    //       return 'Mobile number';
    //     case AppLanguage.bangla:
    //       return 'মোবাইল নাম্বার';
    //   }
    // }

    String getEnterPasswordText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Password';
        case AppLanguage.bangla:
          return 'পাসওয়ার্ড';
      }
    }

    String getDidForgetPasswordText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Forgot password?';
        case AppLanguage.bangla:
          return 'পাসওয়ার্ড ভুলে গেছেন?';
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
                    PhoneNumberInput(phoneController: phoneController),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: getEnterPasswordText(),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        navigate(
                            context, const PhoneNumberScreen(isSignup: false));
                      },
                      child: Text(
                        getDidForgetPasswordText(),
                        style: const TextStyle(
                          color: AppPalette.green,
                        ),
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
                  onTap: () {
                    login(
                        ref,
                        languageProvider,
                        phoneController.value!.international
                            .replaceAll('+88', ''),
                        passwordController.text.trim());
                  },
                ),
        ),
      ),
    );
  }
}
