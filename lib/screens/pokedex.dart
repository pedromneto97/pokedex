import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/screens/pokedex/pokedex_bloc.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: BlocBuilder<PokedexBloc, PokedexState>(
            builder: (context, state) {
              if (state is InitialPokedexState) {
                BlocProvider.of<PokedexBloc>(context).add(PokedexEventGet());
              }
              if (state is PokedexStateSuccess) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return PokemonCard(
                      pokemon: state.pokemons[index],
                    );
                  },
                  itemCount: state.pokemons.length,
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
