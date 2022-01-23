import 'package:fitmess/ui/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeyboardBackspace extends StatelessWidget {
  const KeyboardBackspace({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 48,
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () => context.read<AppCubit>().deleteLetter(),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(
              Icons.backspace_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
