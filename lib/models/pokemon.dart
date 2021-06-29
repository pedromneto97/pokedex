import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'pokemon_stat.dart';

@immutable
class Pokemon extends Equatable {
  final int id;
  final String name;
  final String image;
  final List<String> types;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.types,
  });

  String get idHash => '#${id.toString().padLeft(3, '0')}';

  @override
  List<Object?> get props => [id, name, image, types];
}

@immutable
class DetailedPokemon extends Pokemon {
  final int weight;
  final List<Stat> stats;
  final int baseExperience;
  final int height;
  final List<String> abilities;
  final String about;

  DetailedPokemon.fromPokemon({
    required Pokemon pokemon,
    required this.weight,
    required this.stats,
    required this.baseExperience,
    required this.height,
    required this.abilities,
    required this.about,
  }) : super(
          id: pokemon.id,
          name: pokemon.name,
          image: pokemon.image,
          types: pokemon.types,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        weight,
        stats,
        baseExperience,
        height,
        about,
        about,
      ];
}
