import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'bloc_observer.dart';
import 'design_system/design_system.dart';
import 'screens/screens.dart';

Future<void> main() async {
  await initHiveForFlutter();
  if (kDebugMode) Bloc.observer = PokedexBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      initialRoute: Pokedex.screenName,
      theme: theme,
      routes: {
        Pokedex.screenName: (context) => const Pokedex(),
      },
    );
  }
}
