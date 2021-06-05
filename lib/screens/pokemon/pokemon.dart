import 'package:flutter/material.dart';

import '../../assets/pokemon_icons.dart';
import '../../design_system/colors.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_stat.dart';
import '../../utils/pokemon.dart';
import '../../widgets/pokemon_type.dart';
import 'widgets/pokemon_stat.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final color = getColorFromType(pokemon.types.first);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          pokemon.name,
          style: const TextStyle(
            fontSize: 24,
            height: 1.333333333,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Center(
              child: Text(
                pokemon.idHash,
                style: const TextStyle(
                  fontSize: 12,
                  height: 2.666666667,
                  fontWeight: FontWeight.bold,
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
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 3,
                left: 4,
                right: 4,
                bottom: 4,
              ),
              padding: const EdgeInsets.only(
                top: 56,
                left: 16,
                right: 16,
                bottom: 44,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemon.types.asMap().entries.map<Widget>((e) {
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
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  PokemonIcons.weight,
                                  size: 16,
                                  color: darkGray,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '${69 / 100} kg',
                                    style: const TextStyle(
                                      height: 1.6,
                                      fontSize: 10,
                                      color: darkGray,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Weight',
                                style: TextStyle(
                                  color: mediumGray,
                                  height: 1.5,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'There is a plant seed on its back right from the day this '
                    'Pokémon is born. The seed slowly grows larger.',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.6,
                      color: darkGray,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                    children: [Stat(name: 'ATK', value: 50)]
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
              top: MediaQuery.of(context).size.height / 4 - 72,
              left: MediaQuery.of(context).size.width / 2 - 84,
              child: Center(
                child: Hero(
                  tag: Key("${pokemon.name}-Image"),
                  child: Image.network(
                    pokemon.image,
                    cacheWidth: 168,
                    cacheHeight: 168,
                    width: 168,
                    height: 168,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
