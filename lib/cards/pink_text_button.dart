import 'package:flutter/material.dart';

import '../constants.dart';

class PinkTextButton extends StatelessWidget {
  const PinkTextButton({Key? key, required this.category}) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(kButtonColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: Text(
          category,
          style: kSubHeading,
        ),
      ),
    );
  }
}
