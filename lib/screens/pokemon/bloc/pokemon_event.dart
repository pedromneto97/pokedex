part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent extends Equatable {
  const PokemonEvent();
}

class GetDetailedPokemonFromPokemonEvent extends PokemonEvent {
  final Pokemon pokemon;

  const GetDetailedPokemonFromPokemonEvent({
    required this.pokemon,
  });

  @override
  List<Pokemon> get props => [pokemon];
}

class GetPokemonFromId extends PokemonEvent {
  final int id;

  const GetPokemonFromId({
    required this.id,
  });

  @override
  List<int> get props => [id];
}
