import 'package:equatable/equatable.dart';

enum Sort {
  asc,
  desc,
}

enum Field {
  id,
  name,
}

abstract class PokedexSort extends Equatable {
  final Sort _sort;
  final Field _field;

  const PokedexSort(this._sort, this._field);

  Sort get sort => _sort;

  Field get field => _field;

  @override
  List<Object?> get props => [_sort, _field];
}

class SortByName extends PokedexSort {
  const SortByName.asc() : super(Sort.asc, Field.name);

  const SortByName.desc() : super(Sort.desc, Field.name);
}

class SortById extends PokedexSort {
  const SortById.asc() : super(Sort.asc, Field.id);

  const SortById.desc() : super(Sort.desc, Field.id);
}
