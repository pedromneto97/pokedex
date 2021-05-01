import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/models/PokemonColor.dart';

Pokemon mapPokemon(Map<String, dynamic> params) {
  final data = jsonDecode(params['body']);

  final abilities = (data['abilities'] as List<dynamic>)
      .map((ability) => ability['ability']['name'] as String)
      .toList();

  final types = (data['types'] as List<dynamic>)
      .map((type) => type['type']['name'] as String)
      .toList();

  final color = (params['colors'] as List<PokemonColor>)
      .firstWhere(
        (element) => element.pokemonNames.contains(data["name"]),
      )
      .name;

  return Pokemon(
    name: data['name'],
    abilities: abilities,
    baseExperience: data['base_experience'] as int,
    height: data['height'] as int,
    weight: data['weight'] as int,
    image: data['sprites']['other']['official-artwork']['front_default'],
    types: types,
    color: color,
  );
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
