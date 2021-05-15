import 'package:flutter/material.dart';

import '../models/Pokemon.dart';
import '../models/PokemonColor.dart';

List<PokemonColor> mapColors(List<dynamic> value) {
  final List<PokemonColor> colors = [];
  value.forEach((element) {
    colors.add(
      PokemonColor(
        name: element['name'],
        pokemonNames: (element['pokemons'] as List<dynamic>)
            .map((e) => e['name'] as String)
            .toList(),
      ),
    );
  });
  return colors;
}

Map<String, dynamic> mapPokemon(Map<String, dynamic> data) {
  late final List<PokemonColor> colors;
  final List<Pokemon> pokemons = [];
  int? count;

  if (data['colors'] is List<PokemonColor>) {
    colors = data['colors'];
  } else {
    colors = mapColors(data['colors']);
  }

  if (data.containsKey('pokemons_data')) {
    count = data['pokemons_data']['info']['count'];
  }

  (data['pokemons'] as List<dynamic>).forEach((element) {
    final name = element['name'];
    final abilities = (element['abilities'] as List<dynamic>)
        .map(
          (e) => e['ability']['name'] as String,
        )
        .toList();
    final types = (element['types'] as List<dynamic>)
        .map(
          (e) => e['type']['name'] as String,
        )
        .toList();
    final color = colors
        .firstWhere(
          (element) => element.pokemonNames.contains(name),
        )
        .name;
    pokemons.add(
      Pokemon(
        name: name,
        abilities: abilities,
        baseExperience: element['base_experience'],
        height: element['height'],
        weight: element['weight'],
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element['id']}.png',
        types: types,
        color: color,
      ),
    );
  });

  return {
    'pokemons': pokemons,
    'colors': colors,
    'count': count,
  };
}

const PokemonColors = {
  'black': Colors.black,
  'blue': Colors.blue,
  'brown': Colors.brown,
  'gray': Colors.grey,
  'green': Colors.green,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'red': Colors.red,
  'white': Colors.white,
  'yellow': Colors.amber,
};

final pokemonColorsSecondary = {
  'black': Colors.black12,
  'blue': Colors.blue[300],
  'brown': Colors.brown[300],
  'gray': Colors.grey[300],
  'green': Colors.green[300],
  'pink': Colors.pink[300],
  'purple': Colors.purple[300],
  'red': Colors.red[300],
  'white': Colors.white38,
  'yellow': Colors.amber[400],
};

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
