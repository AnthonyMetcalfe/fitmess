import 'package:fitmess/ui/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardLetter extends StatelessWidget {
  const KeyboardLetter({
    required this.letter,
    Key? key,
  }) : super(key: key);

  final String letter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return Container(
        height: 42,
        width: 30,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: state.correctLetters.contains(letter.toLowerCase())
              ? Colors.green.shade700
              : state.partialLetters.contains(letter.toLowerCase())
                  ? Colors.yellow.shade700
                  : state.wrongLetters.contains(letter.toLowerCase())
                      ? Colors.grey.shade800
                      : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () => context.read<AppCubit>().addLetter(letter),
          child: Center(
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    });
  }
}
