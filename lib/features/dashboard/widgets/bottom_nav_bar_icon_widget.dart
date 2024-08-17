import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class NavigationBarItemWidget extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  const NavigationBarItemWidget({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 3,
                color: isSelected
                    ? AppPalette.green
                    : AppPalette.green.withOpacity(0)),
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isSelected
                    ? AppPalette.green
                    : Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: isSelected ? AppPalette.white : AppPalette.green,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: AppPalette.green),
            ),
          ],
        ),
      ),
    );
  }
}
