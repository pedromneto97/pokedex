import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/models/PokemonColor.dart';
import 'package:pokedex/utils/pokemon.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc() : super(InitialPokedexState());

  @override
  Stream<PokedexState> mapEventToState(PokedexEvent event) async* {
    if (event is PokedexEventGet) {
      final colorResults =
          await get(Uri.https('pokeapi.co', 'api/v2/pokemon-color')).then(
        (value) => jsonDecode(value.body)['results'] as List<dynamic>,
      );

      final colors = await Future.wait(
        colorResults.map((color) async {
          final data = await get(Uri.parse(color['url'])).then(
            (value) => jsonDecode(value.body),
          );
          final pokemons = (data['pokemon_species'] as List<dynamic>)
              .map((pokemon) => pokemon['name'] as String)
              .toList();
          return PokemonColor(
            name: data['name'],
            pokemonNames: pokemons,
          );
        }).toList(),
      );

      final body = await get(Uri.https(
        'pokeapi.co',
        'api/v2/pokemon',
        {
          'limit': '50',
        },
      )).then((value) => jsonDecode(value.body));
      final List<dynamic> results = body['results'];
      final pokemons = await Future.wait(
        results.map((pokemon) async {
          final data = await get(Uri.parse(pokemon['url'])).then(
            (value) => value.body,
          );

          return compute(mapPokemon, {
            "body": data,
            "colors": colors,
          });
        }).toList(),
      );

      yield PokedexStateSuccess(
        pokemons: pokemons,
        totalPages: ((body['count'] / 20) as double).ceil(),
        colors: colors,
      );
    }
  }
}
