import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pard_app/utilities/color_style.dart';

<<<<<<< Updated upstream
Widget verificationTextField(BuildContext context, controller,
    PhoneNumberFormatter? formatter, String hint) {
  return SizedBox(
    width: 211.w,
    height: 48.h,
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
        fillColor: const Color(0xff2A2A2A),
        contentPadding: EdgeInsets.fromLTRB(15.w, 15.h, 0, 15.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.surface, width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.surface, width: 1.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onSecondary, width: 1.w),
        ),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          height: 18.h / 14.h,
          color: grayScale[30],
        ), // 힌트 텍스트 색상
      ),
      style: Theme.of(context).textTheme.headlineSmall,
    ),
  );
=======
class VerificationTextField extends StatelessWidget {
  final FocusNode textFocus;
  final dynamic controller;
  final String hint;
  final PhoneNumberFormatter? formatter;
  VerificationTextField(
    this.textFocus,
    this.controller,
    this.hint, {
    this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 211.w,
      height: 48.h,
      child: TextFormField(
        focusNode: textFocus,
        onChanged: (value) {
          formatter != null
              ? controller.phoneTextFormField.value = value
              : controller.codeTextFormField.value = value;
        },
        keyboardType: TextInputType.number,
        inputFormatters: formatter != null ? [formatter!] : null,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xff2A2A2A),
          contentPadding: EdgeInsets.fromLTRB(15.w, 15.h, 0, 15.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w), // 테두리 radius 설정
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary, width: 1.w),
          ),
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 18.h / 14.h,
            color: grayScale[30],
          ), // 힌트 텍스트 색상
        ),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
>>>>>>> Stashed changes
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
