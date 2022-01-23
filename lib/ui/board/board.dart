import 'package:fitmess/ui/cubit/app_cubit.dart';
import 'package:fitmess/ui/tile/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Board extends StatefulWidget {
  const Board({required this.numberLetters, Key? key}) : super(key: key);

  final int numberLetters;

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  void initState() {
    context.read<AppCubit>().setUpBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Column(
        children: [
          ...state.guess.asMap().entries.map(
                (row) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...row.value.asMap().entries.map((guess) {
                      return Tile(
                        letter: guess.value.letter,
                        numberLetters: widget.numberLetters,
                        index: guess.key,
                        result: guess.value.result,
                        flipCard: (state.guessCounter - 1) == row.key,
                      );
                    }).toList(),
                    for (int i = 0; i < widget.numberLetters - row.value.length; i++)
                      Tile(
                        letter: '',
                        numberLetters: widget.numberLetters,
                      ),
                  ],
                ),
              ),
          for (int i = 0; i < (widget.numberLetters == 5 ? 6 : 8) - state.guess.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.numberLetters; i++)
                  Tile(
                    letter: '',
                    numberLetters: widget.numberLetters,
                  ),
              ],
            ),
          state.solved ? TextButton(onPressed: () => context.read<AppCubit>().setUpBoard(), child: Text('Reset', style: TextStyle(color: Colors.white))) : Container(),
        ],
      );
    });
  }
}
