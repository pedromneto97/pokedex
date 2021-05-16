import 'package:flutter/material.dart';

class PokemonColor {
  final String name;
  final List<String> pokemonNames;

  PokemonColor({
    required this.name,
    required this.pokemonNames,
  });

  Color get primaryColor {
    switch (name) {
      case 'black':
        return Colors.black;
      case 'blue':
        return Colors.blue;
      case 'brown':
        return Colors.brown;
      case 'gray':
        return Colors.grey;
      case 'green':
        return Colors.green;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      case 'white':
        return Colors.white;
      case 'yellow':
        return Colors.amber;
      default:
        throw Exception('Invalid color');
    }
  }

  Color get secondaryColor {
    switch (name) {
      case 'black':
        return Colors.black38;
      case 'blue':
        return Colors.blue[300] as Color;
      case 'brown':
        return Colors.brown[300] as Color;
      case 'gray':
        return Colors.grey[300] as Color;
      case 'green':
        return Colors.green[300] as Color;
      case 'pink':
        return Colors.pink[300] as Color;
      case 'purple':
        return Colors.purple[300] as Color;
      case 'red':
        return Colors.red[300] as Color;
      case 'white':
        return Colors.white30;
      case 'yellow':
        return Colors.amber[300] as Color;
      default:
        throw Exception('Invalid color');
    }
  }
}
