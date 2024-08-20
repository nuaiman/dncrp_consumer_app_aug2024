import 'package:flutter/material.dart';
import 'package:phone_input/phone_input_package.dart';

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({
    super.key,
    required this.phoneController,
  });

  final PhoneController phoneController;

  @override
  Widget build(BuildContext context) {
    return PhoneInput(
      controller: phoneController,
      showArrow: false,
      showFlagInInput: false,
      isCountrySelectionEnabled: false,
      shouldFormat: true,
      validator: PhoneValidator.compose([
        PhoneValidator.required(),
        PhoneValidator.valid(),
      ]),
      decoration: const InputDecoration(
        // isDense: true,
        // contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(),
      ),
      countrySelectorNavigator:
          const CountrySelectorNavigator.draggableBottomSheet(),
    );
  }
}
