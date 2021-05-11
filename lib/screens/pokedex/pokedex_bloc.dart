import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

import '../../models/Pokemon.dart';
import '../../models/PokemonColor.dart';
import '../../utils/graphql.dart';
import '../../utils/pokemon.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc() : super(InitialPokedexState());

  final GraphQLClient client = GraphQl().client;

  @override
  Stream<PokedexState> mapEventToState(PokedexEvent event) async* {
    if (event is PokedexEventGet) {
      final data = await client
          .query(
        QueryOptions(
          document: gql(r'''
            query samplePokeAPIquery {
              colors: pokemon_v2_pokemoncolor {
                name
                pokemons: pokemon_v2_pokemonspecies {
                  name
                }
              }
              pokemons: pokemon_v2_pokemon(limit: 10) {
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
                weight
              }
              pokemons_data: pokemon_v2_pokemon_aggregate {
                info: aggregate {
                  count
                }
              }
          }
      '''),
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

      final result = await compute(mapPokemon, data);

      yield PokedexStateSuccess(
        pokemons: result['pokemons'],
        totalPages: (result['count'] / 20).ceil(),
        colors: result['colors'],
      );
    }
  }
}
