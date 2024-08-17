import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../../../core/utils/navigators.dart';
import '../../../core/widgets/rounded_elevated_button.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageProvider = ref.watch(appLanguageProvider);

    String getWelcomeText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Welcome to the official application of National Directorate of Consumer Protection';
        case AppLanguage.bangla:
          return 'জাতীয় ভোক্তা অধিকার সংরক্ষন অধিদপ্তরে অফিসিয়াল এপ্লিকেশনে আপনাকে স্বাগতম';
      }
    }

    String getButtonText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Proceed';
        case AppLanguage.bangla:
          return 'শুরু করুন';
      }
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade600,
              Colors.green.shade900,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                getWelcomeText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(Pngs.logo),
              ),
              const Text(
                'CCMS',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: RoundedElevatedButton(
          label: getButtonText(),
          bgColor: AppPalette.white,
          textColor: AppPalette.black,
          onTap: () {
            navigate(
              context,
              const AuthScreen(),
            );
          },
        ),
      ),
    );
  }
}
