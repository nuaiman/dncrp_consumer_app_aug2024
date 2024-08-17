import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language enums
enum AppLanguage { english, bangla }

class AppLanguageNotifier extends StateNotifier<AppLanguage> {
  AppLanguageNotifier() : super(AppLanguage.bangla) {
    loadLanguage();
  }

  static const _key = 'language';

  // Language loader
  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(_key)) {
      final int languageIndex = prefs.getInt(_key)!;
      state = AppLanguage.values[languageIndex];
    } else {
      state = AppLanguage.bangla;
    }
  }

  // Change app's language
  Future<void> changeLanguage(AppLanguage language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, language.index);
    state = language;
  }

  // Convert English digits to Bangla digits
  String convertEnglishToBangla(String englishNumber) {
    final Map<String, String> banglaDigits = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
    };
    String banglaNumber = '';
    for (int i = 0; i < englishNumber.length; i++) {
      String digit = englishNumber[i];
      if (banglaDigits.containsKey(digit)) {
        banglaNumber += banglaDigits[digit]!;
      } else {
        banglaNumber += digit;
      }
    }
    return banglaNumber;
  }
}

// -----------------------------------------------------------------------------

final appLanguageProvider =
    StateNotifierProvider<AppLanguageNotifier, AppLanguage>((ref) {
  return AppLanguageNotifier();
});
