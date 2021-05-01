part of 'pokedex_bloc.dart';

@immutable
abstract class PokedexEvent {
  const PokedexEvent();
}

class PokedexEventGet extends PokedexEvent {
  const PokedexEventGet();
}
