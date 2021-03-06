import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/graphql.dart';
import 'pokedex_sort.dart';

class PokemonRepository {
  PokemonRepository._();

  static PokemonRepository? _instance;
  final int pageSize = 30;

  factory PokemonRepository() {
    _instance ??= PokemonRepository._();
    return _instance as PokemonRepository;
  }

  final GraphQLClient client = GraphQl().client;

  Future<Map<String, dynamic>> getPokemons({
    required int page,
    required PokedexSort pokedexSort,
    String? name,
    bool withCount = false,
  }) async {
    var countQuery = '';

    if (withCount) {
      countQuery = '''
         pokemons_data: pokemon_v2_pokemon_aggregate(where: {name: {_iregex: \$name}}) {
            info: aggregate {
              count
            }
         }
      ''';
    }

    final String field = pokedexSort.field == Field.id ? 'id' : 'name';
    final String orderBy = pokedexSort.sort == Sort.asc ? 'asc' : 'desc';

    final data = await client
        .query(
      QueryOptions(
        document: gql('''
            query QueryPokemons(\$page: Int!, \$pageSize: Int!, \$name: String!) {
              pokemons: pokemon_v2_pokemon(limit: \$pageSize, offset: \$page, where: {name: {_iregex: \$name}}, order_by: {$field: $orderBy}) {
                id
                name
                types: pokemon_v2_pokemontypes {
                  type: pokemon_v2_type {
                    name
                  }
                }
              }
              $countQuery
          }
      '''),
        variables: {
          'page': (page - 1) * pageSize,
          'pageSize': pageSize,
          'name': name ?? '',
        },
      ),
    )
        .then((value) {
      if (value.hasException) {
        throw value.exception as OperationException;
      }
      if (value.data == null) {
        throw Exception('Missing data');
      }
      return value.data as Map<String, dynamic>;
    });
    return data;
  }

  Future<Map<String, dynamic>> findPokemon({
    required int id,
  }) async {
    final data = await client
        .query(
      QueryOptions(
        document: gql('''
            query QueryPokemons(\$id: Int!) {
              pokemon: pokemon_v2_pokemon_by_pk(id: \$id) {
                height
                abilities: pokemon_v2_pokemonabilities {
                  ability: pokemon_v2_ability {
                    name
                  }
                }
                weight
                specy: pokemon_v2_pokemonspecy {
                  flavor: pokemon_v2_pokemonspeciesflavortexts(limit: 1) {
                    flavor_text
                  }
                }
                base_experience
                stats: pokemon_v2_pokemonstats {
                  base_stat
                  stat: pokemon_v2_stat {
                    name
                  }
                }
              }
          }
      '''),
        variables: {
          'id': id,
        },
      ),
    )
        .then((value) {
      if (value.hasException) {
        throw value.exception as OperationException;
      }
      if (value.data == null) {
        throw Exception('Missing data');
      }
      return value.data as Map<String, dynamic>;
    });
    return data;
  }
}
