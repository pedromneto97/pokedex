import 'package:flutter/material.dart';

import 'pokemon_stat.dart';

@immutable
class Pokemon {
  final int id;
  final String name;
  final List<String> abilities;
  final int baseExperience;
  final int height;
  final String image;
  final List<String> types;
  final int weight;
  final List<Stat> stats;

  const Pokemon({
    required this.id,
    required this.name,
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.image,
    required this.types,
    required this.stats,
  });

  String get idHash => '#${id.toString().padLeft(3, '0')}';
}
