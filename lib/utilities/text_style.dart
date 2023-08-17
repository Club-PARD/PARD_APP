import 'package:flutter/material.dart';
import 'package:pard_app/utilities/color_style.dart';

class TextStyles {
  static const hintTextStyle = TextStyle(fontStyle: FontStyle.italic);
  static const noteTextStyle = TextStyle(fontSize: 12, color: Colors.black54);
  static const memoTextStyle = TextStyle(
      fontSize: 12, color: Colors.black45, fontStyle: FontStyle.italic);

  static const appBarTitleStyle =
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700);
  static const sectionTitleStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600);
  static const partStyle =
      TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w700);
  static const scheduleTitleStyle =
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w700);
  static const dueDateStyle =
      TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600);
  static const scheduleDescriptionStyle =
      TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500);

  static const pastPartStyle = TextStyle(
      fontSize: 14,
      color: ColorStyles.pastSchedule,
      fontWeight: FontWeight.w700);
  static const pastScheduleTitleStyle = TextStyle(
      fontSize: 16,
      color: ColorStyles.pastSchedule,
      fontWeight: FontWeight.w700);
  static const pastDueDateStyle = TextStyle(
      fontSize: 12,
      color: ColorStyles.pastSchedule,
      fontWeight: FontWeight.w600);
  static const pastScheduleDescriptionStyle = TextStyle(
      fontSize: 14,
      color: ColorStyles.pastSchedule,
      fontWeight: FontWeight.w500);
  // ...
}
