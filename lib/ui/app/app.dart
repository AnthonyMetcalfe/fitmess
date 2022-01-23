import 'package:fitmess/ui/board/board.dart';
import 'package:fitmess/ui/cubit/app_cubit.dart';
import 'package:fitmess/ui/keyboard_key/keyboard_backspace.dart';
import 'package:fitmess/ui/keyboard_key/keyboard_enter.dart';
import 'package:fitmess/ui/keyboard_key/keyboard_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final numberLetters = 6;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: BlocProvider(
            create: (context) => AppCubit(numberLetters: numberLetters),
            child: Column(
              children: [
                Board(
                  numberLetters: numberLetters,
                ),
                Expanded(
                  child: Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    KeyboardLetter(letter: 'Q'),
                    KeyboardLetter(letter: 'W'),
                    KeyboardLetter(letter: 'E'),
                    KeyboardLetter(letter: 'R'),
                    KeyboardLetter(letter: 'T'),
                    KeyboardLetter(letter: 'Y'),
                    KeyboardLetter(letter: 'U'),
                    KeyboardLetter(letter: 'I'),
                    KeyboardLetter(letter: 'O'),
                    KeyboardLetter(letter: 'P'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    KeyboardLetter(letter: 'A'),
                    KeyboardLetter(letter: 'S'),
                    KeyboardLetter(letter: 'D'),
                    KeyboardLetter(letter: 'F'),
                    KeyboardLetter(letter: 'G'),
                    KeyboardLetter(letter: 'H'),
                    KeyboardLetter(letter: 'J'),
                    KeyboardLetter(letter: 'K'),
                    KeyboardLetter(letter: 'L'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    KeyboardEnter(),
                    KeyboardLetter(letter: 'Z'),
                    KeyboardLetter(letter: 'X'),
                    KeyboardLetter(letter: 'C'),
                    KeyboardLetter(letter: 'V'),
                    KeyboardLetter(letter: 'B'),
                    KeyboardLetter(letter: 'N'),
                    KeyboardLetter(letter: 'M'),
                    KeyboardBackspace(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
