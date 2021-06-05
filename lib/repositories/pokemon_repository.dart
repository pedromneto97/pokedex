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

  Future<Map<String, dynamic>> getPokemons({
    required int page,
    bool withCount = false,
  }) async {
    var countQuery = '';

    if (withCount) {
      countQuery = '''
         pokemons_data: pokemon_v2_pokemon_aggregate {
            info: aggregate {
              count
            }
         }
      ''';
    }

    final data = await client
        .query(
      QueryOptions(
        document: gql('''
            query QueryPokemons(\$page: Int!, \$pageSize: Int!) {
              pokemons: pokemon_v2_pokemon(limit: \$pageSize, offset: \$page) {
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
