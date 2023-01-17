import 'package:flutter/material.dart';

class InstructionCard extends StatelessWidget {
  const InstructionCard(
      {Key? key, required this.srNo, required this.instruction})
      : super(key: key);
  final String srNo;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 15, start: 8, end: 8)  ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black38,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
        child: Row(
          children: [
            Text(
              srNo,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                instruction,
                style: const TextStyle(height: 1.5, color: Colors.white, letterSpacing: 2, ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
