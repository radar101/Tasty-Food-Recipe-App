import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard(
      {Key? key, required this.srNo, required this.instruction})
      : super(key: key);
  final String srNo;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 15, start: 8, end: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black38,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            children: [
              Text(
                srNo,
                style: const TextStyle(color: Color(0xFFE7F6F2)),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Text(
                  instruction,
                  style: const TextStyle(height: 1.5, color: Color(0xFFE7F6F2), letterSpacing: 2.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
