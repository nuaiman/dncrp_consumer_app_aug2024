import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/palette.dart';
import 'features/auth/screens/landing_language_selection_screen.dart';

void main() {
  runApp(const ProviderScope(child: BhoktaOdhikarConsumerApp()));
}

class BhoktaOdhikarConsumerApp extends StatelessWidget {
  const BhoktaOdhikarConsumerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNCRP Consumer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.green),
        useMaterial3: true,
      ),
      home: const LandingLanguageSelectionScreen(),
      // home: const DashboardScreen(),
    );
  }
}

// evidences-akajsdfljasdfoewruower93427
