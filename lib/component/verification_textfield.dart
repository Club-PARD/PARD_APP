import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pard_app/controllers/phone_verification_controller.dart';

Widget verificationTextField(PhoneVerificationController controller,
    PhoneNumberFormatter? formatter, String hint, double width, double height) {
  return Container(
    width: width * 211,
    height: height * 48,
    child: TextFormField(
      onChanged: (value) {
        formatter != null
            ? controller.phoneTextFormField.value = value
            : controller.codeTextFormField.value = value;
      },
      keyboardType: TextInputType.number,
      inputFormatters: formatter != null ? [formatter] : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Color.fromRGBO(42, 42, 42, 1),
        contentPadding:
            EdgeInsets.fromLTRB(width * 15, height * 15, 0, height * 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Color.fromRGBO(228, 228, 228, 1), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Color.fromRGBO(228, 228, 228, 1), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Color.fromRGBO(82, 98, 245, 1), width: 1),
        ),
        hintStyle:
            TextStyle(color: Color.fromRGBO(228, 228, 228, 1)), // 힌트 텍스트 색상
      ),
      style: TextStyle(color: Colors.white),
    ),
  );
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit characters from the text
    final cleanedText = text.replaceAll(RegExp(r'\D'), '');

    // Apply formatting: xxx-xxxx-xxxx
    final formattedText = StringBuffer();
    for (var i = 0; i < cleanedText.length; i++) {
      if (i == 3 || i == 7) {
        formattedText.write('-');
      }
      formattedText.write(cleanedText[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
