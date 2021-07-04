part of './pokedex_bloc.dart';

@immutable
abstract class PokedexEvent {
  const PokedexEvent();
}

class PokedexEventGet extends PokedexEvent {
  final PokedexSort? sort;
  final String? name;

  const PokedexEventGet({
    this.sort,
    this.name,
  });
}

class PokedexEventGetNextPage extends PokedexEvent {
  final int page;

  const PokedexEventGetNextPage({
    required this.page,
  });
}
