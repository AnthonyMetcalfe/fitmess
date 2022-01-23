import 'package:equatable/equatable.dart';
import 'package:fitmess/ui/tile/tile.dart';
import 'package:flutter/material.dart';

class Guess extends Equatable {
  const Guess({required this.letter, this.result, Key? key});

  final String letter;
  final Result? result;

  Guess copyWith({String? letter, Result? result}) {
    return Guess(
      letter: letter ?? this.letter,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [letter, result];
}
