import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:pard_app/utilities/color_style.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
//import 'package:simple_gradient_text/simple_gradient_text.dart';

class PartComponent extends StatelessWidget {
  final String part;

  const PartComponent(this.part, {super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String displayPart = part.replaceAll('파트', '');
    final bool isAllParts = displayPart == '전체';

    return Container(
      width: 60,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: displayPart == '전체'
            ? const LinearGradient(
                colors: [primaryBlue, primaryPurple],
              )
            : null,
        border: const GradientBoxBorder(
          gradient: LinearGradient(colors: [primaryBlue, primaryPurple]),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: GradientText(
        displayPart,
        style: Theme.of(context).textTheme.headlineSmall,
        colors: displayPart == '전체'
            ? [Colors.white, Colors.white]
            : [primaryBlue, primaryPurple],
      ),
    );
  }
}
