import 'package:flutter/material.dart';
import 'package:pokedex/utils/pokemon.dart';
import 'package:pokedex/widgets/labeled_text.dart';
import 'package:pokedex/widgets/pokemon_type.dart';

import '../../models/Pokemon.dart';

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
            PokemonColors[pokemon.color] as Color,
            PokemonColors[pokemon.color] is MaterialColor
                ? ((PokemonColors[pokemon.color] as MaterialColor)[200]
                    as Color)
                : Colors.white,
          ],
        )),
        child: LayoutBuilder(
          builder: (context, contraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: contraints.maxHeight),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 168,
                        width: 168,
                        padding: EdgeInsets.symmetric(
                          vertical: 24,
                        ),
                        child: Hero(
                          tag: Key("${pokemon.name}-Image"),
                          child: Image.network(pokemon.image),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      width: contraints.maxWidth,
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 16),
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
                            children:
                                pokemon.types.asMap().entries.map<Widget>((e) {
                              if (e.key == 0) {
                                return Padding(
                                  key: ObjectKey(e),
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: PokemonType(
                                    pokemonType: e.value,
                                    color: pokemonColorsSecondary[pokemon.color]
                                        as Color,
                                  ),
                                );
                              }
                              return Hero(
                                tag: Key("${pokemon.name}-${e.value}"),
                                child: PokemonType(
                                  key: ObjectKey(e),
                                  pokemonType: e.value,
                                  color: pokemonColorsSecondary[pokemon.color]
                                      as Color,
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
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
