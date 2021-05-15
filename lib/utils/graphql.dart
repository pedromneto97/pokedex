import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQl {
  GraphQl._();

  final GraphQLClient client = GraphQLClient(
    link: HttpLink(
      'https://beta.pokeapi.co/graphql/v1beta',
      defaultHeaders: const {
        "X-Method-Used": "graphiql",
      },
    ),
    cache: GraphQLCache(
      store: HiveStore(),
    ),
    defaultPolicies: DefaultPolicies(
      query: Policies(
        fetch: FetchPolicy.cacheFirst,
      ),
    ),
  );

  static GraphQl? _instance;

  factory GraphQl() {
    _instance ??= GraphQl._();
    return _instance as GraphQl;
  }
}
