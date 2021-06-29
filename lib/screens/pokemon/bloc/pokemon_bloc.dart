import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../../../models/pokemon.dart';
import '../../../repositories/pokemon_repository.dart';
import '../../../utils/pokemon.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  PokemonBloc({
    required this.pokemonRepository,
  }) : super(const InitialPokemonState());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is GetDetailedPokemonFromPokemonEvent) {
      final response = await pokemonRepository.findPokemon(
        id: event.pokemon.id,
      );

      final detailedPokemon = mapPokemonToDetailedPokemon({
        'pokemon': event.pokemon,
        'details': response['pokemon'],
      });

      yield SuccessPokemonState(pokemon: detailedPokemon);
    }
  }
}
