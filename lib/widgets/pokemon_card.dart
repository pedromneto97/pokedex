import 'package:flutter/material.dart';

import '../models/Pokemon.dart';
import '../screens/pokemon/pokemon.dart';
import '../utils/pokemon.dart';
import 'pokemon_type.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: PokemonColors[pokemon.color],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4.0,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PokemonScreen(
                pokemon: pokemon,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Hero(
                  tag: Key("${pokemon.name}-Name"),
                  child: Text(
                    pokemon.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pokemon.types.asMap().entries.map<Widget>((e) {
                        if (e.key == 0) {
                          return Padding(
                            key: ObjectKey(e),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Hero(
                              tag: Key("${pokemon.name}-${e.value}"),
                              child: PokemonType(
                                pokemonType: e.value,
                                color: pokemonColorsSecondary[pokemon.color]
                                    as Color,
                              ),
                            ),
                          );
                        }
                        return Hero(
                          tag: Key("${pokemon.name}-${e.value}"),
                          child: PokemonType(
                            key: ObjectKey(e),
                            pokemonType: e.value,
                            color:
                                pokemonColorsSecondary[pokemon.color] as Color,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Flexible(
                    child: Hero(
                      tag: Key("${pokemon.name}-Image"),
                      child: Image.network(
                        pokemon.image,
                        key: ObjectKey(pokemon.image),
                        cacheHeight: 168,
                        cacheWidth: 168,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
