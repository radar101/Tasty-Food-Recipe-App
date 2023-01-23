import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

class TextWithFontAwesome extends StatelessWidget {
  const TextWithFontAwesome(
      {Key? key,
      required this.iconName,
      required this.colorIcon,
      required this.text})
      : super(key: key);
  final IconData iconName;
  final Color colorIcon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          iconName,
          color: colorIcon,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: kSubHeading,
        ),
      ],
    );
  }
}
