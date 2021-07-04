import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../design_system/colors.dart';
import '../../repositories/pokemon_repository.dart';
import '../../widgets/pokemon_card.dart';
import 'bloc/pokedex_bloc.dart';
import 'widgets/pokedex_app_bar.dart';

class Pokedex extends StatelessWidget {
  static const screenName = '/';

  const Pokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokedexBloc(
        pokemonRepository: RepositoryProvider.of<PokemonRepository>(context),
      ),
      lazy: false,
      child: Scaffold(
        appBar: const PokedexAppBar(),
        backgroundColor: background,
        body: Builder(builder: (context) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              final PokedexState state =
                  BlocProvider.of<PokedexBloc>(context).state;
              if (notification.metrics.extentAfter < 40 &&
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
                if (state is LoadingPokedexState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: darkGray,
                    ),
                  );
                }
                if (state is PokedexStateSuccess) {
                  return CustomScrollView(
                    key: const Key('CustomScrollView'),
                    slivers: [
                      SliverPadding(
                        key: const Key('SliverPadding'),
                        padding: const EdgeInsets.all(8),
                        sliver: SliverGrid(
                          key: const Key('SliverGrid'),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            childAspectRatio: 0.928571429,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return PokemonCard(
                                key: ObjectKey(state.pokemons[index]),
                                pokemon: state.pokemons[index],
                              );
                            },
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
                              child: CircularProgressIndicator(
                                color: darkGray,
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          );
        }),
      ),
    );
  }
}
