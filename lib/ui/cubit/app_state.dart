part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.word = '',
    this.guess = const [[]],
    this.wrongLetters = const [],
    this.partialLetters = const [],
    this.correctLetters = const [],
    this.guessCounter = 0,
    this.solved = false,
  });

  final List<List<Guess>> guess;
  final int guessCounter;
  final String word;
  final bool solved;
  final List<String> wrongLetters;
  final List<String> partialLetters;
  final List<String> correctLetters;

  AppState copyWith({
    List<List<Guess>>? guess,
    String? word,
    int? guessCounter,
    List<String>? wrongLetters,
    List<String>? partialLetters,
    List<String>? correctLetters,
    bool? solved,
  }) {
    return AppState(
      guess: guess ?? this.guess,
      guessCounter: guessCounter ?? this.guessCounter,
      word: word ?? this.word,
      correctLetters: correctLetters ?? this.correctLetters,
      partialLetters: partialLetters ?? this.partialLetters,
      wrongLetters: wrongLetters ?? this.wrongLetters,
      solved: solved ?? this.solved,
    );
  }

  @override
  List<Object?> get props => [
        guess,
        guessCounter,
        word,
        correctLetters,
        wrongLetters,
        partialLetters,
        solved,
      ];
}
