import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Stat extends Equatable {
  final String name;
  final int value;

  const Stat({
    required this.name,
    required this.value,
  });

  @override
  List<Object?> get props => [name, value];
}
