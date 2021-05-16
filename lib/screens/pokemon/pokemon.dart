import 'package:flutter/material.dart';

import '../../models/Pokemon.dart';
import '../../widgets/labeled_text.dart';
import '../../widgets/pokemon_type.dart';
import 'widgets/pokemon_stat.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            iconSize: 24,
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [
            0.05,
            1,
          ],
          colors: [
            pokemon.color.primaryColor,
            pokemon.color.secondaryColor,
          ],
        )),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 16),
              child: Column(
                children: [
                  Hero(
                    tag: Key("${pokemon.name}-Name"),
                    child: Text(
                      pokemon.name,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        height: 1.25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: pokemon.types.asMap().entries.map<Widget>((e) {
                      if (e.key == 0) {
                        return Padding(
                          key: ObjectKey(e),
                          padding: const EdgeInsets.only(right: 8.0),
                          child: PokemonType(
                            pokemonType: e.value,
                            color: pokemon.color.primaryColor,
                          ),
                        );
                      }
                      return Hero(
                        tag: Key("${pokemon.name}-${e.value}"),
                        child: PokemonType(
                          key: ObjectKey(e),
                          pokemonType: e.value,
                          color: pokemon.color.primaryColor,
                        ),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: LabeledText(
                      label: "Height",
                      text: "${pokemon.height / 10} m",
                    ),
                  ),
                  LabeledText(
                    label: "Weight",
                    text: "${pokemon.weight / 100} m",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: LabeledText(
                      label: "Abilities",
                      text: pokemon.abilities.join(", "),
                    ),
                  ),
                  DefaultTabController(
                    length: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          child: TabBar(
                            labelColor: pokemon.color.primaryColor,
                            indicatorColor: pokemon.color.primaryColor,
                            tabs: [
                              Tab(
                                text: "Stats",
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          child: TabBarView(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: pokemon.stats
                                      .map(
                                        (e) => PokemonStat(
                                          stat: e,
                                          color: pokemon.color.primaryColor,
                                          backgroundColor:
                                              pokemon.color.secondaryColor,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
