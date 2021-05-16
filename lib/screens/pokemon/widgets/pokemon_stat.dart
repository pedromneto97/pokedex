import 'package:flutter/material.dart';

import '../../../models/PokemonStat.dart';

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
        Expanded(
          child: Text(
            stat.name,
            style: TextStyle(
              color: color,
              height: 1.25,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            stat.value.toString().padLeft(3, '0'),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 14,
              height: 1.25,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
              backgroundColor: backgroundColor,
              value: stat.value / 255,
              minHeight: 8,
            ),
          ),
        ),
      ],
    );
  }
}
