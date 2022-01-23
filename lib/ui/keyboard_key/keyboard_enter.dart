import 'package:fitmess/ui/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardEnter extends StatelessWidget {
  const KeyboardEnter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 72,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => context.read<AppCubit>().submitGuess(),
        child: const Center(
          child: Text(
            'Enter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
