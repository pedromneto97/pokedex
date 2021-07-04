import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../design_system/colors.dart';
import '../../../repositories/pokedex_sort.dart';
import '../bloc/pokedex_bloc.dart';

class PokedexSortWidget extends StatelessWidget {
  final PokedexSort sort;

  const PokedexSortWidget({
    Key? key,
    required this.sort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPress(context),
      child: Row(
        children: [
          _getText(),
          _getIcon(),
        ],
      ),
    );
  }

  void onPress(BuildContext context) {
    final nextSortOrder = {
      const SortByName.asc().toString(): const SortByName.desc(),
      const SortByName.desc().toString(): const SortById.asc(),
      const SortById.asc().toString(): const SortById.desc(),
      const SortById.desc().toString(): const SortByName.asc(),
    };

    final bloc = BlocProvider.of<PokedexBloc>(context);
    final state = bloc.state;
    bloc.add(
      PokedexEventGet(
        name: state is PokedexStateSuccess ? state.filterName : null,
        sort: nextSortOrder[sort.toString()]!,
      ),
    );
  }

  Text _getText() {
    if (sort.field == Field.id) {
      return const Text(
        '#',
        style: TextStyle(
          color: darkGray,
          fontSize: 10,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return const Text(
      'A\nZ',
      style: TextStyle(
        color: darkGray,
        fontSize: 8,
        height: 1,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Icon _getIcon() {
    if (sort.sort == Sort.asc) {
      return const Icon(
        Icons.arrow_downward_rounded,
        color: darkGray,
      );
    }
    return const Icon(
      Icons.arrow_upward_rounded,
      color: darkGray,
    );
  }
}
