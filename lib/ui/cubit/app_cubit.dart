import 'package:equatable/equatable.dart';
import 'package:fitmess/data/five_letter_words.dart';
import 'package:fitmess/data/guess.dart';
import 'package:fitmess/data/six_letter_words.dart';
import 'package:fitmess/ui/tile/tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.numberLetters}) : super(const AppState());

  final int numberLetters;

  addLetter(String letter) {
    if (state.guess[state.guessCounter].length < numberLetters) {
      var guessCopy = [...state.guess];
      guessCopy[state.guessCounter] = [
        ...guessCopy[state.guessCounter],
        Guess(letter: letter.toLowerCase()),
      ];
      emit(state.copyWith(guess: guessCopy));
    }
  }

  setUpBoard() {
    List<String> wordsList = numberLetters == 5 ? fiveLetterWords : sixLetterWords;

    int index = DateTime.now().millisecond % wordsList.length;
    emit(AppState(word: wordsList[index].toLowerCase()));
  }

  deleteLetter() {
    if (state.guess[state.guessCounter].isNotEmpty) {
      var guessCopy = [...state.guess];
      guessCopy[state.guessCounter] = [
        ...guessCopy[state.guessCounter].take(guessCopy[state.guessCounter].length - 1),
      ];

      emit(state.copyWith(guess: guessCopy));
    }
  }

  submitGuess() {
    if (state.guess[state.guessCounter].length == numberLetters) {
      var guessesCopy = [...state.guess];

      guessesCopy[state.guessCounter] = guessesCopy[state.guessCounter].asMap().entries.map<Guess>((keyValue) {
        String letter = keyValue.value.letter;
        List<Guess> guesses = guessesCopy[state.guessCounter];
        Result result = Result.wrong;

        if (state.word[keyValue.key] == letter) {
          result = Result.correct;
          _addLetterToList(letter, Result.correct);
        } else if (state.word.contains(letter)) {
          if (guesses.where((g) => g.letter == letter).length <= state.word.split('').where((l) => l == letter).length) {
            result = Result.partial;

            _addLetterToList(letter, Result.partial);
          }

          var existingOnes = guesses.asMap().entries.where((g) => g.value.letter == letter && (state.word.split('')[g.key] == letter || keyValue.key > g.key)).length;
          if (existingOnes < state.word.split('').where((l) => l == letter).length) {
            result = Result.partial;

            _addLetterToList(letter, Result.partial);
          }
        }

        if (result == Result.wrong) {
          _addLetterToList(letter, Result.wrong);
        }

        return keyValue.value.copyWith(result: result);
      }).toList();

      if (guessesCopy[state.guessCounter].map((e) => e.letter).join() == state.word) {
        emit(state.copyWith(solved: true));
      } else if (state.guess.length == 6) {
        print('FAILURE');
      } else {
        guessesCopy.add([]);
      }
      emit(state.copyWith(guess: guessesCopy, guessCounter: state.guessCounter + 1));
    }
  }

  _addLetterToList(String letter, Result result) {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (result == Result.correct && !state.correctLetters.contains(letter)) {
        emit(state.copyWith(correctLetters: [...state.correctLetters, letter]));
      } else if (result == Result.partial && !state.partialLetters.contains(letter)) {
        emit(state.copyWith(partialLetters: [...state.partialLetters, letter]));
      } else if (result == Result.wrong && !state.wrongLetters.contains(letter)) {
        emit(state.copyWith(wrongLetters: [...state.wrongLetters, letter]));
      }
    });
  }
}
