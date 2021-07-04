part of './pokedex_bloc.dart';

@immutable
abstract class PokedexState extends Equatable {
  final PokedexSort pokedexSort;

  const PokedexState({required this.pokedexSort});

  @override
  List<Object?> get props => [pokedexSort];
}

class InitialPokedexState extends PokedexState {
  const InitialPokedexState()
      : super(
          pokedexSort: const SortById.asc(),
        );
}

class LoadingPokedexState extends PokedexState {
  const LoadingPokedexState({
    required PokedexSort pokedexSort,
  }) : super(pokedexSort: pokedexSort);
}

class PokedexStateSuccess extends PokedexState {
  final List<Pokemon> pokemons;
  final int page;
  final int totalPages;
  final bool isLoadingMore;
  final String? filterName;

  const PokedexStateSuccess({
    required this.pokemons,
    this.page = 1,
    required this.totalPages,
    this.isLoadingMore = false,
    required PokedexSort pokedexSort,
    this.filterName,
  }) : super(pokedexSort: pokedexSort);

  PokedexStateSuccess mergeWith({
    List<Pokemon>? pokemons,
    int? page,
    int? totalPages,
    bool? isLoadingMore,
    PokedexSort? pokedexSort,
    String? filterName,
  }) =>
      PokedexStateSuccess(
        pokemons:
            pokemons != null ? [...this.pokemons, ...pokemons] : this.pokemons,
        page: page ?? this.page,
        totalPages: totalPages ?? this.totalPages,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        pokedexSort: pokedexSort ?? this.pokedexSort,
        filterName: filterName ?? this.filterName,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        pokemons,
        page,
        totalPages,
        isLoadingMore,
        pokedexSort,
        filterName,
      ];
}
