import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/pokemon_card.dart';
import 'pokedex/pokedex_bloc.dart';

class Pokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0x80fafafa),
        centerTitle: true,
        title: Text(
          "Pokemon",
        ),
      ),
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
                  BlocProvider.of<PokedexBloc>(context).add(PokedexEventGet());
                }
                if (state is PokedexStateSuccess) {
                  return CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
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
                                pokemon: state.pokemons[index],
                              );
                            },
                            childCount: state.pokemons.length,
                          ),
                        ),
                      ),
                      if (state.isLoadingMore)
                        SliverToBoxAdapter(
                          child: const Padding(
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
