import '../models/Pokemon.dart';
import '../models/PokemonColor.dart';
import '../models/PokemonStat.dart';

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
    final String name = element['name'];
    final List<String> abilities = (element['abilities'] as List<dynamic>)
        .map(
          (e) => (e['ability']['name'] as String).capitalize(),
        )
        .toList();
    final List<String> types = (element['types'] as List<dynamic>)
        .map(
          (e) => (e['type']['name'] as String).capitalize(),
        )
        .toList();
    final PokemonColor color = colors.firstWhere(
      (element) => element.pokemonNames.contains(name),
    );

    const PokemonStatName = {
      'hp': 'HP',
      'attack': 'ATK',
      'defense': 'DEF',
      'special-attack': 'SATK',
      'special-defense': 'SDEF',
      'speed': 'SPD',
    };

    final List<Stat> stats = (element['stats'] as List<dynamic>)
        .map(
          (e) => Stat(
            name: PokemonStatName[e['stat']['name']] as String,
            value: e['base_stat'],
          ),
        )
        .toList();
    pokemons.add(
      Pokemon(
        name: name.capitalize(),
        abilities: abilities,
        baseExperience: element['base_experience'],
        height: element['height'],
        weight: element['weight'],
        image:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${element['id']}.png',
        types: types,
        color: color,
        stats: stats,
      ),
    );
  });

  return {
    'pokemons': pokemons,
    'colors': colors,
    'count': count,
  };
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
