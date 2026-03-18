import 'package:flutter/services.dart';
import 'package:scavenge/utils/validator.dart';

class NigerianPhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // 1. If user deletes everything, let it be empty
    if (text.isEmpty) return newValue;

    // 2. Use your existing logic to format the string
    final formatted = Validators.formatNigerianPhoneNumber(text);

    // 3. Return the new value and place the cursor at the end
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
