import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/utils/pokemon.dart';
import 'package:pokedex/widgets/pokemon_type.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                pokemon.name.capitalize(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
                          child: PokemonType(
                            pokemonType: e.value,
                            color:
                                pokemonColorsSecondary[pokemon.color] as Color,
                          ),
                        );
                      }
                      return PokemonType(
                        key: ObjectKey(e),
                        pokemonType: e.value,
                        color: pokemonColorsSecondary[pokemon.color] as Color,
                      );
                    }).toList(),
                  ),
                ),
                Flexible(
                  child: Image.network(pokemon.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
