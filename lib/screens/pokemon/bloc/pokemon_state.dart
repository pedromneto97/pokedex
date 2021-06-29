part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonState extends Equatable {
  const PokemonState();
}

class InitialPokemonState extends PokemonState {
  const InitialPokemonState();

  @override
  List<Object?> get props => const [];
}

class SuccessPokemonState extends PokemonState {
  final DetailedPokemon pokemon;

  const SuccessPokemonState({
    required this.pokemon,
  });

  @override
  List<Object?> get props => [pokemon];
}
