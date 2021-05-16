import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/graphql.dart';

class PokemonRepository {
  PokemonRepository._();
  static PokemonRepository? _instance;
  final int pageSize = 20;

  factory PokemonRepository() {
    _instance ??= PokemonRepository._();
    return _instance as PokemonRepository;
  }

  final GraphQLClient client = GraphQl().client;

  Future<Map<String, dynamic>> getPokemons(
      {required int page,
      bool withColors = false,
      bool withCount = false}) async {
    String colorsQuery = "";
    String countQuery = "";

    if (withColors) {
      colorsQuery = r"""
        colors: pokemon_v2_pokemoncolor {
          name
          pokemons: pokemon_v2_pokemonspecies {
            name
          }
          }
      """;
    }
    if (withCount) {
      countQuery = """
         pokemons_data: pokemon_v2_pokemon_aggregate {
            info: aggregate {
              count
            }
         }
      """;
    }

    final data = await client
        .query(
      QueryOptions(
        document: gql('''
            query samplePokeAPIquery(\$page: Int!, \$pageSize: Int!) {
              $colorsQuery
              pokemons: pokemon_v2_pokemon(limit: \$pageSize, offset: \$page) {
                id
                name
                height
                base_experience
                types: pokemon_v2_pokemontypes {
                  type: pokemon_v2_type {
                    name
                  }
                }
                abilities: pokemon_v2_pokemonabilities {
                  ability: pokemon_v2_ability {
                    name
                  }
                }
                stats: pokemon_v2_pokemonstats {
                  base_stat
                  stat: pokemon_v2_stat {
                    name
                  }
                }
                weight
              }
              $countQuery
          }
      '''),
        variables: {
          'page': (page - 1) * pageSize,
          'pageSize': pageSize,
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
