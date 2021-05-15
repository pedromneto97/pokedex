part of 'pokedex_bloc.dart';

@immutable
abstract class PokedexEvent {
  const PokedexEvent();
}

class PokedexEventGet extends PokedexEvent {
  const PokedexEventGet();
}

class PokedexEventGetNextPage extends PokedexEvent {
  final page;
  const PokedexEventGetNextPage({
    required this.page,
  });
}
