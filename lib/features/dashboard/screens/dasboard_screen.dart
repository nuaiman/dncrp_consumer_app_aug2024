import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/palette.dart';
import '../../../core/notifiers/language_notifier.dart';
import '../widgets/bottom_nav_bar_icon_widget.dart';
import 'add_complain_screen.dart';
import 'notifications_screen.dart';
import 'overview_screen.dart';
import 'settings_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  final screens = const [
    OverviewScreen(),
    AddComplainScreen(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = ref.watch(appLanguageProvider);

    String getOverViewText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Overview';
        case AppLanguage.bangla:
          return 'তালিকা';
      }
    }

    String getAddText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Add';
        case AppLanguage.bangla:
          return 'অভিযোগ';
      }
    }

    String getNotificationsText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Notifications';
        case AppLanguage.bangla:
          return 'বিজ্ঞপ্তি';
      }
    }

    String getSettingsText() {
      switch (languageProvider) {
        case AppLanguage.english:
          return 'Settings';
        case AppLanguage.bangla:
          return 'সেটিংস';
      }
    }

    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        height: 90,
        backgroundColor: AppPalette.green.withOpacity(0.1),
        currentIndex: currentIndex,
        onTap: onTap,
        activeColor: AppPalette.green,
        inactiveColor: AppPalette.white,
        items: [
          BottomNavigationBarItem(
            icon: NavigationBarItemWidget(
              icon: Icons.list_alt_outlined,
              label: getOverViewText(),
              isSelected: currentIndex == 0 ? true : false,
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationBarItemWidget(
              icon: Icons.add,
              label: getAddText(),
              isSelected: currentIndex == 1 ? true : false,
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationBarItemWidget(
              icon: Icons.notifications_outlined,
              label: getNotificationsText(),
              isSelected: currentIndex == 2 ? true : false,
            ),
          ),
          BottomNavigationBarItem(
            icon: NavigationBarItemWidget(
              icon: Icons.settings_outlined,
              label: getSettingsText(),
              isSelected: currentIndex == 3 ? true : false,
            ),
          ),
        ],
      ),
    );
  }
}
