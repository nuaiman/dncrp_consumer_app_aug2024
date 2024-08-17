import 'package:dncrp_consumer_app/core/constants/palette.dart';
import 'package:dncrp_consumer_app/core/notifiers/loader_notifier.dart';
import 'package:dncrp_consumer_app/features/auth/notifiers/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_input/phone_input_package.dart';

import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/widgets/rounded_elevated_button.dart';

class PhoneNumberScreen extends ConsumerStatefulWidget {
  const PhoneNumberScreen({super.key});

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
          return 'Registration';
        case AppLanguage.bangla:
          return 'রেজিস্ট্রেশন করুন';
        default:
          return 'Registration';
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

    void getOTP(
        BuildContext context, AppLanguage language, String phoneNumber) {
      ref.read(authProvider.notifier).getOTP(context, language, phoneNumber);
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
                    PhoneInput(
                      controller: phoneController,
                      showArrow: false,
                      showFlagInInput: false,
                      isCountrySelectionEnabled: false,
                      shouldFormat: true,
                      validator: PhoneValidator.compose([
                        PhoneValidator.required(),
                        PhoneValidator.valid(),
                      ]),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(12),
                        border: OutlineInputBorder(),
                      ),
                      countrySelectorNavigator:
                          const CountrySelectorNavigator.draggableBottomSheet(),
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
                    final phoneNumber = phoneController.value!.international
                        .replaceAll('+88', '');
                    getOTP(context, languageProvider, phoneNumber);
                  },
                ),
        ),
      ),
    );
  }
}
