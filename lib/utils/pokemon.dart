import 'package:flutter/widgets.dart';

import '../models/pokemon.dart';
import '../models/pokemon_stat.dart';

Map<String, dynamic> mapPokemon(Map<String, dynamic> data) {
  final pokemons = <Pokemon>[];
  int? count;

  if (data.containsKey('pokemons_data')) {
    count = data['pokemons_data']['info']['count'];
  }

  for (var pokemon in data['pokemons']) {
    final String name = pokemon['name'];
    final types = (pokemon['types'] as List<dynamic>)
        .map(
          (e) => (e['type']['name'] as String).capitalize(),
        )
        .toList(growable: false);

    pokemons.add(
      Pokemon(
        id: pokemon['id'],
        name: name.capitalize(),
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon['id']}.png',
        types: types,
      ),
    );
  }

  return {
    'pokemons': pokemons,
    'count': count,
  };
}

DetailedPokemon mapPokemonToDetailedPokemon(Map<String, dynamic> data) {
  final pokemon = data['pokemon'] as Pokemon;
  final pokemonDetails = data['details'] as Map<String, dynamic>;

  final abilities = (pokemonDetails['abilities'] as List<dynamic>)
      .map((ability) => (ability['ability']['name'] as String).capitalize())
      .take(2)
      .toList(growable: false);

  final stats = (pokemonDetails['stats'] as List<dynamic>)
      .map(
        (stat) => Stat(
          name: mapStat(stat['stat']['name']),
          value: stat['base_stat'],
        ),
      )
      .toList(growable: false);

  return DetailedPokemon.fromPokemon(
    pokemon: pokemon,
    weight: pokemonDetails['weight'],
    stats: stats,
    baseExperience: pokemonDetails['base_experience'],
    height: pokemonDetails['height'],
    abilities: abilities,
    about: (pokemonDetails['specy']['flavor'][0]['flavor_text'] as String)
        .replaceAll('\n', ' ')
        .replaceAll('\f', ' '),
  );
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

String mapStat(String stat) {
  const pokemonStatName = {
    'hp': 'HP',
    'attack': 'ATK',
    'defense': 'DEF',
    'special-attack': 'SATK',
    'special-defense': 'SDEF',
    'speed': 'SPD',
  };

  return pokemonStatName[stat]!;
}

Color getColorFromType(String type) {
  const colors = {
    'rock': Color(0xFFB69E31),
    'ghost': Color(0xFF70559B),
    'steel': Color(0xFFB7B9D0),
    'water': Color(0xFF74CB48),
    'grass': Color(0xFF74CB48),
    'psychic': Color(0xFFFB5584),
    'ice': Color(0xFF9AD6DF),
    'dark': Color(0xFF75574C),
    'fairy': Color(0xFFE69EAC),
    'normal': Color(0xFFAAA67F),
    'fighting': Color(0xFFC12239),
    'flying': Color(0xFFA891EC),
    'poison': Color(0xFFA43E9E),
    'ground': Color(0xFFDEC16B),
    'bug': Color(0xFFA7B723),
    'fire': Color(0xFFF57D31),
    'electric': Color(0xFFF9CF30),
    'dragon': Color(0xFF7037FF),
  };
  return colors[type.toLowerCase()]!;
}
