import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CodeSnackBar extends StatelessWidget {
  final String text;

  const CodeSnackBar(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40.h,
        width: 343.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.secondary,
            ]),
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.w)),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(82, 98, 245, 0.1),
              Color.fromRGBO(123, 63, 239, 0.1),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: GradientText(
                text,
                style: headlineSmall,
                colors: const [
                  primaryBlue,
                  primaryPurple,
                ],
              ),
        ),
      );
  }
}

  