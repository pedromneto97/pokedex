import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../models/pokemon.dart';
import '../../../repositories/pokemon_repository.dart';
import '../../../utils/pokemon.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  PokedexBloc({
    required this.pokemonRepository,
  }) : super(const InitialPokedexState());

  final PokemonRepository pokemonRepository;

  @override
  Stream<PokedexState> mapEventToState(PokedexEvent event) async* {
    if (event is PokedexEventGet) {
      final data = await pokemonRepository.getPokemons(
        page: 1,
        withCount: true,
      );

      final result = await compute(mapPokemon, data);

      yield PokedexStateSuccess(
        pokemons: result['pokemons'],
        totalPages: (result['count'] / pokemonRepository.pageSize).ceil(),
      );
    }
    if (event is PokedexEventGetNextPage) {
      yield (state as PokedexStateSuccess).mergeWith(isLoadingMore: true);

      final data = await pokemonRepository.getPokemons(page: event.page);

      final result = await compute(mapPokemon, data);

      yield (state as PokedexStateSuccess).mergeWith(
        pokemons: result['pokemons'],
        isLoadingMore: false,
        page: event.page,
      );
    }
  }
}
