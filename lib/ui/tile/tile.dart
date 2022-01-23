import 'dart:math';

import 'package:flutter/material.dart';

enum Result { correct, partial, wrong }

class Tile extends StatefulWidget {
  const Tile({required this.letter, required this.numberLetters, this.index, this.flipCard, this.result, Key? key}) : super(key: key);

  final String letter;
  final int? index;
  final Result? result;
  final bool? flipCard;
  final int numberLetters;

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  bool _showFrontSide = true;

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showFrontSide) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  @override
  void initState() {
    print('INIT STATE');
    print(widget.flipCard);
    if (widget.flipCard == true && _showFrontSide == true) {
      print('LKSDJFLKJSKLDJFLJSDLFKJLDSKFJ ${widget.letter}');
      setState(() {
        _showFrontSide = false;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.flipCard == true && _showFrontSide == true && widget.index != null) {
      Future.delayed(Duration(milliseconds: 400 * widget.index!), () async {
        setState(() {
          _showFrontSide = false;
        });
      });
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 4,
      ),
      constraints: BoxConstraints.tight(
        Size.square(
          ((MediaQuery.of(context).size.width - 52) / widget.numberLetters),
        ),
      ),
      child: GestureDetector(
        onTap: () => setState(() {
          _showFrontSide = !_showFrontSide;
        }),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 800),
          transitionBuilder: __transitionBuilder,
          layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
          child: _showFrontSide
              ? TileLayout(
                  key: const ValueKey(true),
                  backgroundColor: Colors.grey.shade800,
                  numberLetter: widget.numberLetters,
                  textColor: Colors.white,
                  letter: widget.letter.toUpperCase(),
                )
              : TileLayout(
                  key: const ValueKey(false),
                  backgroundColor: widget.result == Result.correct
                      ? Colors.green.shade700
                      : widget.result == Result.partial
                          ? Colors.yellow.shade700
                          : Colors.grey.shade800,
                  letter: widget.letter.toUpperCase(),
                  textColor: widget.result == Result.wrong ? Colors.white : Colors.black,
                  numberLetter: widget.numberLetters,
                ),
          switchInCurve: Curves.easeInBack,
          switchOutCurve: Curves.easeInBack.flipped,
        ),
      ),
    );
  }
}

class TileLayout extends StatelessWidget {
  const TileLayout({required this.letter, required this.backgroundColor, required this.numberLetter, this.textColor = Colors.black, Key? key}) : super(key: key);

  final String letter;
  final int numberLetter;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
        color: backgroundColor,
      ),
      child: Center(
        child: Text(
          letter,
          style: TextStyle(
            fontSize: numberLetter == 5 ? 50 : 40,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
