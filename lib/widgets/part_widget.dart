import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:pard_app/utilities/text_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PartWidget extends StatelessWidget {
  final String part;

  const PartWidget(this.part, {super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAllParts = part == '전체';

    return Container(
      width: 55,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        gradient: part == '천체'
            ? const LinearGradient(
                colors: [
                  ColorStyles.gradientColor1,
                  ColorStyles.gradientColor2
                ],
              )
            : null,
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [
            ColorStyles.gradientColor1,
            ColorStyles.gradientColor2,
          ]),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GradientText(
        part,
        style: TextStyles.partStyle,
        colors: part == '천체'
            ? [Colors.white, Colors.white]
            : [ColorStyles.gradientColor1, ColorStyles.gradientColor2],
      ),
    );
  }
}
