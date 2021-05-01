import 'package:flutter/material.dart';

class PokemonType extends StatelessWidget {
  final String pokemonType;
  final Color color;

  const PokemonType({
    Key? key,
    required this.pokemonType,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 16,
      ),
      child: Text(
        pokemonType,
        style: TextStyle(
          color: this.color == Colors.white ? Colors.black : Colors.white,
          fontSize: 12,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
