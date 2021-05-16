import 'PokemonColor.dart';
import 'PokemonStat.dart';

class Pokemon {
  final String name;
  final List<String> abilities;
  final int baseExperience;
  final int height;
  final String image;
  final List<String> types;
  final int weight;
  final PokemonColor color;
  final List<Stat> stats;

  const Pokemon({
    required this.name,
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.image,
    required this.types,
    required this.color,
    required this.stats,
  });
}
