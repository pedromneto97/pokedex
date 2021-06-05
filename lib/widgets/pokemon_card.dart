import 'package:flutter/material.dart';
import 'package:pokedex/utils/pokemon.dart';

import '../models/Pokemon.dart';
import '../screens/pokemon/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = getColorFromType(pokemon.types.first);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: color,
        ),
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
          child: Container(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: TextStyle(
                        fontSize: 8,
                        height: 1.5,
                        color: color,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: Key("${pokemon.name}-Image"),
                    child: Image.network(
                      pokemon.image,
                      height: 72,
                      width: 72,
                    ),
                  ),
                ),
                Container(
                  color: color,
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    pokemon.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
