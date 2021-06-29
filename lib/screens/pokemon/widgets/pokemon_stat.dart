import 'package:flutter/material.dart';
import 'package:pokedex/design_system/colors.dart';

import '../../../models/pokemon_stat.dart';

class PokemonStat extends StatelessWidget {
  final Stat stat;
  final Color color;
  final Color backgroundColor;

  const PokemonStat({
    Key? key,
    required this.stat,
    required this.color,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 32,
          child: Text(
            stat.name,
            style: TextStyle(
              color: color,
              height: 1.6,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Container(
          height: 16,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const VerticalDivider(
            color: lightGray,
            width: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            stat.value.toString().padLeft(3, '0'),
            style: const TextStyle(
              fontSize: 10,
              height: 1.6,
              color: darkGray,
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
              backgroundColor: backgroundColor,
              value: stat.value / 255,
              minHeight: 4,
            ),
          ),
        ),
      ],
    );
  }
}
