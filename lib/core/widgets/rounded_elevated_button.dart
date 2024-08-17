import 'package:flutter/material.dart';

import '../constants/palette.dart';

class RoundedElevatedButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Function onTap;
  const RoundedElevatedButton({
    super.key,
    required this.label,
    this.bgColor = AppPalette.green,
    this.textColor = AppPalette.white,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ElevatedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(bgColor),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
