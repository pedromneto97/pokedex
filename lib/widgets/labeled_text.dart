import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final String label;
  final String text;

  const LabeledText({
    Key? key,
    required this.label,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: Text(label),
        ),
        Expanded(
          flex: 3,
          child: Text(
            text,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
