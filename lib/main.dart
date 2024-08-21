import 'package:dncrp_consumer_app/core/notifiers/language_notifier.dart';
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
    final languageProvider = ref.watch(appLanguageProvider);
    return FutureBuilder<bool>(
      future: authNotifier.checkLoginStatus(
        context,
        languageProvider,
      ),
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


// ---------------
// http://192.168.0.113:7041/ath/cmplnr/info
// {
//   "data": {
//     "userInfo": {
//       "_id": "66bd496d6ff593466b4575de",
//       "email": null,
//       "username": "01886887169",
//       "firstName": "",
//       "lastName": "",
//       "register": null,
//       "profilePicture": "",
//       "invitationResponseDate": "",
//       "creator": "",
//       "pendingInvitation": false,
//       "updateHistoryList": [],
//       "userType": "complainer",
//       "userTypeCode": 3,
//       "hasProfile": true,
//       "isInvitation": false,
//       "otpLogin": false,
//       "isComplete": false,
//       "activationDate": "",
//       "updateDate": "2024-08-20T07:28:22.398Z",
//       "creationDate": "2024-08-14T19:35:01.644Z",
//       "status": false,
//       "active": false,
//       "delete": false,
//       "deleteDate": "",
//       "deletedById": "",
//       "roleCode": null,
//       "role": null,
//       "updated": true
//     },
//     "complainerInfo": {
//       "_id": "66c0887a4833560043124712",
//       "userId": "66bd496d6ff593466b4575de",
//       "name": "Nuaiman Ashiq",
//       "fatherName": "MD. Abc Def Ghi",
//       "motherName": "Mrs. Jkl Mno Pqrst",
//       "email": "ashiqnuaiman@gmail.com",
//       "address": "007 Bond Street",
//       "gender": "male",
//       "identificationType": "National ID",
//       "identificationNo": "11111111111111111",
//       "division": "Dhaka",
//       "divisionId": "3",
//       "district": "Narayanganj",
//       "districtId": "11",
//       "postalCode": 1400,
//       "profession": "Software Eng",
//       "birthDate": "2024-07-17T00:00:00.000",
//       "updateDate": "",
//       "month": 7,
//       "year": 2024,
//       "creator": "",
//       "creationDate": "2024-08-17T11:24:42.779Z",
//       "status": true,
//       "active": true,
//       "delete": false,
//       "deleteDate": "",
//       "deletedById": "",
//       "username": "01886887169",
//       "profilePicture": "6274_1723893882482.jpg"
//     },
//     "userId": "66bd496d6ff593466b4575de"
//   },
//   "message": "Complainer Info Found",
//   "error": false,
//   "status": 200
// }



// ---------------
// http://192.168.0.113:7041/cmplnr/66c0887a4833560043124712
// {
//   "data": {
//     "_id": "66c0887a4833560043124712",
//     "userId": "66bd496d6ff593466b4575de",
//     "name": "Nuaiman Ashiq",
//     "fatherName": "MD. Abc Def Ghi",
//     "motherName": "Mrs. Jkl Mno Pqrst",
//     "email": "ashiqnuaiman@gmail.com",
//     "address": "007 Bond Street",
//     "gender": "male",
//     "identificationType": "National ID",
//     "identificationNo": "11111111111111111",
//     "division": "Dhaka",
//     "divisionId": "3",
//     "district": "Narayanganj",
//     "districtId": "11",
//     "postalCode": 1400,
//     "profession": "Software Eng",
//     "birthDate": "2024-07-17T00:00:00.000",
//     "updateDate": "",
//     "month": 7,
//     "year": 2024,
//     "creator": "",
//     "creationDate": "2024-08-17T11:24:42.779Z",
//     "status": true,
//     "active": true,
//     "delete": false,
//     "deleteDate": "",
//     "deletedById": "",
//     "username": "01886887169",
//     "profilePicture": "6274_1723893882482.jpg"
//   },
//   "error": false,
//   "message": "consumer data found",
//   "status": 200
// }