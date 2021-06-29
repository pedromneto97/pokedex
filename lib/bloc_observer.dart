import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class PokedexBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log(
      event.toString(),
      name: 'BLOC',
      time: DateTime.now(),
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(
      transition.toString(),
      name: 'BLOC',
      time: DateTime.now(),
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log(
      error.toString(),
      name: 'BLOC',
      time: DateTime.now(),
    );
    super.onError(bloc, error, stackTrace);
  }
}
