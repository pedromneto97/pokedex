import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQl {
  GraphQl._();

  final GraphQLClient client = GraphQLClient(
    link: HttpLink('https://beta.pokeapi.co/graphql/v1beta', defaultHeaders: {
      "X-Method-Used": "graphiql",
    }),
    // The default store is the InMemoryStore, which does NOT persist to disk
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );

  static GraphQl? _instance;

  factory GraphQl() {
    _instance ??= GraphQl._();
    return _instance as GraphQl;
  }
}
