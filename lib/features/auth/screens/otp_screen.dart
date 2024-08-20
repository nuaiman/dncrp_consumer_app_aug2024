import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/notifiers/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/palette.dart';
import '../../../core/constants/pngs.dart';
import '../../../core/notifiers/loader_notifier.dart';
import '../../../core/widgets/rounded_elevated_button.dart';
import '../notifiers/auth_notifier.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final bool isSignup;
  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.isSignup,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);
    final isLoading = ref.watch(loaderProvider);

    String getFirstHeaderText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Enter OTP number';
        case AppLanguage.bangla:
          return 'ও.টি.পি প্রদান করুন';
      }
    }

    String getErrorPinText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Pin is incorrect';
        case AppLanguage.bangla:
          return 'পিনটি ভুল';
      }
    }

    String getResendOtpText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'resend OTP';
        case AppLanguage.bangla:
          return 'ওটিপি আবার পাঠান';
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

    void reSendOTP(
        BuildContext context, AppLanguage language, String phoneNumber) {
      ref.read(authProvider.notifier).reSendOTP(context, language, phoneNumber);
      setState(() {
        otpController.clear();
      });
    }

    void verifySignupOTP(BuildContext context, AppLanguage language,
        String phoneNumber, int otp) {
      ref
          .read(authProvider.notifier)
          .verifySignupOTP(context, language, phoneNumber, otp);
      setState(() {
        otpController.clear();
      });
    }

    void verifyPasswordResetOTP(BuildContext context, AppLanguage language,
        String phoneNumber, int otp) {
      ref
          .read(authProvider.notifier)
          .verifyPasswordResetOTP(context, language, phoneNumber, otp);
      setState(() {
        otpController.clear();
      });
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
                  getFirstHeaderText(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 56,
                        height: 56,
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: AppPalette.black,
                            fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppPalette.black),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      preFilledWidget: const Text(
                        '✶',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                      ),
                      controller: otpController,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (value) {
                        widget.isSignup
                            ? verifySignupOTP(
                                context,
                                languageProvider,
                                widget.phoneNumber,
                                int.parse(otpController.text))
                            : verifyPasswordResetOTP(
                                context,
                                languageProvider,
                                widget.phoneNumber,
                                int.parse(otpController.text));
                      },
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const SizedBox.shrink()
                        : OtpTimerButton(
                            height: 60,
                            onPressed: () {
                              reSendOTP(context, languageProvider,
                                  widget.phoneNumber);
                            },
                            text: Text(
                              getResendOtpText(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            buttonType: ButtonType.text_button,
                            backgroundColor: const Color(0xFF212121),
                            duration: 120,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          // final isLoading = ref.watch(loaderProvider);
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppPalette.green,
                  ),
                )
              : RoundedElevatedButton(
                  label: getNextText(),
                  onTap: () {
                    widget.isSignup
                        ? verifySignupOTP(context, languageProvider,
                            widget.phoneNumber, int.parse(otpController.text))
                        : verifyPasswordResetOTP(context, languageProvider,
                            widget.phoneNumber, int.parse(otpController.text));
                  },
                ),
        ),
      ),
    );
  }
}
