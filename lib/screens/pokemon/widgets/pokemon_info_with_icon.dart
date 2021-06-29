import 'package:flutter/material.dart';

import '../../../design_system/colors.dart';

class PokemonInfo extends StatelessWidget {
  final Widget widget;
  final String label;

  const PokemonInfo({
    Key? key,
    required this.widget,
    required this.label,
  }) : super(key: key);

  PokemonInfo.withIcon({
    Key? key,
    required String value,
    required IconData icon,
    required this.label,
  })  : widget = Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: darkGray,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                style: const TextStyle(
                  height: 1.6,
                  fontSize: 10,
                  color: darkGray,
                ),
              ),
            ),
          ],
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget,
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: mediumGray,
              height: 1.5,
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }
}
