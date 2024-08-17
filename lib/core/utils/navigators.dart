import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndReplace(BuildContext context, Widget widget) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndRemoveUntil(BuildContext context, Widget widget) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (_) => false,
  );
}

// void navigateAndRemoveUntil(BuildContext context, Route route) {
//   Navigator.of(context).pushAndRemoveUntil(route, (_) => false);
// }
