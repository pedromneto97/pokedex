import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../assets/pokemon_icons.dart';
import '../../design_system/colors.dart';
import '../../utils/pokemon.dart';
import '../../widgets/pokemon_type.dart';
import 'bloc/pokemon_bloc.dart';
import 'widgets/pokemon_info_with_icon.dart';
import 'widgets/pokemon_stat.dart';

class PokemonScreen extends StatelessWidget {
  final PokemonBloc pokemonBloc;

  const PokemonScreen({
    Key? key,
    required this.pokemonBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pokemonBloc,
      lazy: false,
      child: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is SuccessPokemonState) {
            final color = getColorFromType(state.pokemon.types.first);
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(),
                title: Hero(
                  tag: Key(state.pokemon.name),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      state.pokemon.name,
                      style: const TextStyle(
                        fontSize: 24,
                        height: 1.333333333,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Center(
                      child: Hero(
                        tag: Key('${state.pokemon.name}-id'),
                        child: Text(
                          state.pokemon.idHash,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 2.666666667,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              body: Container(
                color: color,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      margin: const EdgeInsets.only(
                        top: 224,
                        left: 4,
                        right: 4,
                        bottom: 4,
                      ),
                      padding: const EdgeInsets.only(
                        top: 56,
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: state.pokemon.types
                                .asMap()
                                .entries
                                .map<Widget>((e) {
                              if (e.key == 0) {
                                return PokemonType(
                                  key: ObjectKey(e),
                                  pokemonType: e.value,
                                );
                              }
                              return Padding(
                                key: ObjectKey(e),
                                padding: const EdgeInsets.only(left: 16.0),
                                child: PokemonType(
                                  pokemonType: e.value,
                                ),
                              );
                            }).toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'About',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.142857143,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            height: 48,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PokemonInfo.withIcon(
                                  value: '${state.pokemon.weight / 10} kg',
                                  icon: PokemonIcons.weight,
                                  label: 'Weight',
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                  ),
                                ),
                                PokemonInfo.withIcon(
                                  value: '${state.pokemon.height / 10} m',
                                  icon: PokemonIcons.rule,
                                  label: 'Height',
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: VerticalDivider(
                                    width: 1,
                                    thickness: 1,
                                  ),
                                ),
                                PokemonInfo(
                                  widget: Text(
                                    state.pokemon.abilities.join('\n'),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      height: 1.6,
                                      color: darkGray,
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                  label: 'Moves',
                                ),
                              ],
                            ),
                          ),
                          Text(
                            state.pokemon.about,
                            style: const TextStyle(
                              fontSize: 10,
                              height: 1.6,
                              color: darkGray,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Base Stats',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.142857143,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Column(
                            children: state.pokemon.stats
                                .map(
                                  (e) => PokemonStat(
                                    stat: e,
                                    color: color,
                                    backgroundColor: color.withOpacity(0.2),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Icon(
                        PokemonIcons.pokeball,
                        size: 208,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Hero(
                          tag: Key('${state.pokemon.name}-Image'),
                          child: Image.network(
                            state.pokemon.image,
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: lightGray,
              elevation: 0,
              leading: const BackButton(),
            ),
            body: const Center(
              child: CircularProgressIndicator(
                color: lightGray,
              ),
            ),
          );
        },
      ),
    );
  }
}
