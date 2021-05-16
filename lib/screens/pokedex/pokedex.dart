import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/pokemon_card.dart';
import 'bloc/pokedex_bloc.dart';

class Pokedex extends StatelessWidget {
  static const screenName = '/';

  const Pokedex();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Pokedex",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 24,
            height: 1.25,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => PokedexBloc(),
        lazy: false,
        child: Builder(builder: (context) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final PokedexState state =
                  BlocProvider.of<PokedexBloc>(context).state;
              if (notification.metrics.extentAfter < 20 &&
                  state is PokedexStateSuccess &&
                  !state.isLoadingMore &&
                  state.page < state.totalPages) {
                BlocProvider.of<PokedexBloc>(context).add(
                  PokedexEventGetNextPage(page: state.page + 1),
                );
              }
              return true;
            },
            child: BlocBuilder<PokedexBloc, PokedexState>(
              builder: (context, state) {
                if (state is InitialPokedexState) {
                  BlocProvider.of<PokedexBloc>(context).add(
                    const PokedexEventGet(),
                  );
                }
                if (state is PokedexStateSuccess) {
                  return CustomScrollView(
                    key: const Key("CustomScrollView"),
                    slivers: [
                      SliverPadding(
                        key: const Key("SliverPadding"),
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
                          key: const Key("SliverGrid"),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 1.25,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PokemonCard(
                                key: ObjectKey(state.pokemons[index]),
                                pokemon: state.pokemons[index],
                              );
                            },
                            addAutomaticKeepAlives: true,
                            childCount: state.pokemons.length,
                          ),
                        ),
                      ),
                      if (state.isLoadingMore)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        }),
      ),
    );
  }
}
