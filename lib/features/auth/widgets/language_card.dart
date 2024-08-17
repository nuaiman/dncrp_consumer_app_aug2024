import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/notifiers/language_notifier.dart';

class LanguageCard extends ConsumerWidget {
  final String label;
  final AppLanguage selectedLanguage;
  final VoidCallback onTap;
  const LanguageCard({
    super.key,
    required this.label,
    required this.selectedLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLanguage = ref.watch(appLanguageProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.48,
        decoration: BoxDecoration(
          border: Border.all(
              color: appLanguage == selectedLanguage
                  ? AppPalette.green
                  : AppPalette.black,
              width: appLanguage == selectedLanguage ? 3 : 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 28,
              color: appLanguage == selectedLanguage
                  ? AppPalette.green
                  : AppPalette.black,
              fontWeight: appLanguage == selectedLanguage
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
