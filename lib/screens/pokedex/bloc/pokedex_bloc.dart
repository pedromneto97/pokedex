import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../models/pokemon.dart';
import '../../../repositories/pokemon_repository.dart';
import '../../../utils/pokemon.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc() : super(const InitialPokedexState());

  final PokemonRepository _pokemonRepository = PokemonRepository();

  @override
  Stream<PokedexState> mapEventToState(PokedexEvent event) async* {
    if (event is PokedexEventGet) {
      final data = await _pokemonRepository.getPokemons(
        page: 1,
        withCount: true,
      );

      final result = await compute(mapPokemon, data);

      yield PokedexStateSuccess(
        pokemons: result['pokemons'],
        totalPages: (result['count'] / _pokemonRepository.pageSize).ceil(),
      );
    }
    if (event is PokedexEventGetNextPage) {
      yield (state as PokedexStateSuccess).mergeWith(isLoadingMore: true);

      final data = await _pokemonRepository.getPokemons(page: event.page);

      final result = await compute(mapPokemon, data);

      yield (state as PokedexStateSuccess).mergeWith(
        pokemons: result['pokemons'],
        isLoadingMore: false,
        page: event.page,
      );
    }
  }
}
