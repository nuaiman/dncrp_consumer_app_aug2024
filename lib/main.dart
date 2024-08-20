import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/palette.dart';
import 'features/auth/notifiers/auth_notifier.dart';
import 'features/auth/screens/landing_language_selection_screen.dart';
import 'features/dashboard/screens/dashboard_init_screen.dart';

void main() {
  runApp(const ProviderScope(child: DncrpConsumerApp()));
}

class DncrpConsumerApp extends StatelessWidget {
  const DncrpConsumerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DNCRP Consumer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.green),
        useMaterial3: true,
      ),
      // home: const LandingLanguageSelectionScreen(),
      // home: const DashboardScreen(),
      home: const AuthChecker(),
    );
  }
}

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider.notifier);

    return FutureBuilder<bool>(
      future: authNotifier.checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred'));
        } else if (snapshot.hasData) {
          final isLoggedIn = snapshot.data ?? false;
          return isLoggedIn
              ? const DashboardInit()
              : const LandingLanguageSelectionScreen();
        } else {
          // Handle the case where there's no data
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}


// class AuthChecker extends ConsumerWidget {
//   const AuthChecker({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authNotifier = ref.watch(authProvider.notifier);

//     return FutureBuilder(
//       future: authNotifier.checkLoginStatus(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return const Center(child: Text('An error occurred'));
//         } else {
//           final isLoggedIn = snapshot.data ?? false;
//           return isLoggedIn
//               ? const DashboardInit()
//               : const LandingLanguageSelectionScreen();
//         }
//       },
//     );
//   }
// }
