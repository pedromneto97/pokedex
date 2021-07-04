import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../models/pokemon.dart';
import '../../../repositories/pokedex_sort.dart';
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
      yield LoadingPokedexState(
        pokedexSort: event.sort ?? state.pokedexSort,
      );

      final data = await pokemonRepository.getPokemons(
        page: 1,
        withCount: true,
        pokedexSort: event.sort ?? state.pokedexSort,
        name: event.name,
      );

      final result = await compute(mapPokemon, data);

      yield PokedexStateSuccess(
        pokemons: result['pokemons'],
        totalPages: (result['count'] / pokemonRepository.pageSize).ceil(),
        pokedexSort: event.sort ?? state.pokedexSort,
        filterName: event.name,
      );
    }
    if (event is PokedexEventGetNextPage) {
      yield (state as PokedexStateSuccess).mergeWith(isLoadingMore: true);

      final data = await pokemonRepository.getPokemons(
        page: event.page,
        pokedexSort: (state as PokedexStateSuccess).pokedexSort,
        name: (state as PokedexStateSuccess).filterName,
      );

      final result = await compute(mapPokemon, data);

      yield (state as PokedexStateSuccess).mergeWith(
        pokemons: result['pokemons'],
        isLoadingMore: false,
        page: event.page,
      );
    }
  }
}
