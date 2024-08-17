import 'package:flutter/material.dart';

import '../../../core/constants/palette.dart';

class UserDetailsField extends StatelessWidget {
  final String label;
  final String value;
  const UserDetailsField({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: AppPalette.green),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
