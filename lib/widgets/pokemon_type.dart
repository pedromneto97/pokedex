import 'package:flutter/material.dart';

import '../utils/pokemon.dart';

class PokemonType extends StatelessWidget {
  final String pokemonType;

  const PokemonType({
    Key? key,
    required this.pokemonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getColorFromType(pokemonType);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 8,
      ),
      child: Text(
        pokemonType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          height: 1.6,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
