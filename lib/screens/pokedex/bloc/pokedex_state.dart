part of './pokedex_bloc.dart';

@immutable
abstract class PokedexState extends Equatable {
  const PokedexState();
}

class InitialPokedexState extends PokedexState {
  const InitialPokedexState();

  @override
  List<Object?> get props => const [];
}

class PokedexStateSuccess extends PokedexState {
  final List<Pokemon> pokemons;
  final int page;
  final int totalPages;
  final bool isLoadingMore;

  const PokedexStateSuccess({
    required this.pokemons,
    this.page = 1,
    required this.totalPages,
    this.isLoadingMore = false,
  });

  PokedexStateSuccess mergeWith({
    List<Pokemon>? pokemons,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
  }) =>
      PokedexStateSuccess(
        pokemons:
            pokemons != null ? [...this.pokemons, ...pokemons] : this.pokemons,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      );

  @override
  List<Object?> get props => [pokemons, page, totalPages, isLoadingMore];
}
