import 'package:flutter/material.dart';

import '../constants/palette.dart';

class RoundedOutlinedButton extends StatelessWidget {
  final String label;
  final Color textColor;
  final Function onTap;
  const RoundedOutlinedButton({
    super.key,
    required this.label,
    this.textColor = AppPalette.green,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OutlinedButton(
          onPressed: () {
            onTap();
          },
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
