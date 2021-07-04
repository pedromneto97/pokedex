import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../assets/pokemon_icons.dart';
import '../../../design_system/colors.dart';
import '../bloc/pokedex_bloc.dart';
import 'pokedex_sort_widget.dart';

class PokedexAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PokedexAppBar({Key? key}) : super(key: key);

  @override
  _PokedexAppBarState createState() => _PokedexAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(88);
}

class _PokedexAppBarState extends State<PokedexAppBar> {
  Timer? debounce;

  _onSearchChanged(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<PokedexBloc>(context).add(PokedexEventGet(name: text));
    });
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    PokemonIcons.pokeball,
                    color: darkGray,
                    size: 24,
                  ),
                ),
                const Expanded(
                  child: Text(
                    'Pokédex',
                    style: TextStyle(
                      color: darkGray,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      height: 1.33,
                    ),
                  ),
                ),
                BlocBuilder<PokedexBloc, PokedexState>(
                  builder: (context, state) => PokedexSortWidget(
                    sort: state.pokedexSort,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              height: 24,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: lightGray,
                      width: 1,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 16,
                    color: mediumGray,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: darkGray,
                      width: 1,
                    ),
                  ),
                  labelText: 'Find',
                  labelStyle: const TextStyle(
                    color: mediumGray,
                    height: 1.6,
                    fontSize: 10,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                style: const TextStyle(
                  height: 1.6,
                  fontSize: 10,
                  color: darkGray,
                ),
                cursorHeight: 16,
                cursorColor: darkGray,
                onChanged: _onSearchChanged,
              ),
            )
          ],
        ),
      ),
    );
  }
}
