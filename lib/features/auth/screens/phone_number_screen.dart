import 'package:dncrp_consumer_app/core/constants/palette.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/widgets/phone_number_input.dart';
import '../../../core/widgets/rounded_elevated_button.dart';

class PhoneNumberScreen extends ConsumerStatefulWidget {
  final bool isSignup;
  const PhoneNumberScreen({super.key, required this.isSignup});

  @override
  ConsumerState<PhoneNumberScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<PhoneNumberScreen> {
  final PhoneController phoneController = PhoneController(
    const PhoneNumber(isoCode: IsoCode.BD, nsn: ''),
  );

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);
    final isLoading = ref.watch(loaderProvider);

    String getHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Enter Phone Number';
        case AppLanguage.bangla:
          return 'ফোন নম্বর লিখুন';
        default:
          return 'Enter Phone Number';
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

    void getSignupOTP(
        BuildContext context, AppLanguage language, String phoneNumber) {
      ref
          .read(authProvider.notifier)
          .getSignupOTP(context, language, phoneNumber);
    }

    void getPasswordResetOTP(
        BuildContext context, AppLanguage language, String phoneNumber) {
      ref
          .read(authProvider.notifier)
          .getPasswordResetOTP(context, language, phoneNumber);
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
                          final phoneNumber = phoneController
                              .value!.international
                              .replaceAll('+88', '');
                          getSignupOTP(context, languageProvider, phoneNumber);
                        }
                      : () {
                          final phoneNumber = phoneController
                              .value!.international
                              .replaceAll('+88', '');
                          getPasswordResetOTP(
                              context, languageProvider, phoneNumber);
                        },
                ),
        ),
      ),
    );
  }
}
