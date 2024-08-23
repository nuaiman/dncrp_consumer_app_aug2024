import 'package:flutter/material.dart';

import '../constants/palette.dart';

class RoundedElevatedButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color textColor;
  final Function onTap;
  final double padding;
  const RoundedElevatedButton({
    super.key,
    required this.label,
    this.bgColor = AppPalette.green,
    this.textColor = AppPalette.white,
    this.padding = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
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
