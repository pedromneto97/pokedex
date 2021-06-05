import 'package:flutter/material.dart';

@immutable
class Stat {
  final String name;
  final int value;

  const Stat({
    required this.name,
    required this.value,
  });
}