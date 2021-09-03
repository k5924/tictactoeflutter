import 'dart:math';

import 'package:flutter/material.dart';

import '../main.dart';
import '../utilities/export.dart';
import '../widgets/export.dart';

class PVEPage extends StatefulWidget {
  const PVEPage({Key? key}) : super(key: key);

  @override
  _PVEPageState createState() => _PVEPageState();
}

class _PVEPageState extends State<PVEPage> {
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text: 'Player X',
                        style: kCustomFont,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextWidget(
                        text: xScore.toString(),
                        style: kCustomFont,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                        text: 'Player O',
                        style: kCustomFont,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextWidget(
                        text: oScore.toString(),
                        style: kCustomFont,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => setState(() {
                    if (showXorO[index] == '') {
                      showXorO[index] = 'O';
                      filledBoxes++;
                      filledBoxes++;
                    }

                    _checkIfWinner();
                    _bestMove();
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: CustomTextWidget(
                        text: showXorO[index],
                        style: kCustomFont.copyWith(
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  CustomTextWidget(
                    text: 'TIC TAC TOE',
                    style: kCustomFont,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _bestMove() {
    int i;
    int score;
    // AI to make its turn
    int bestScore = -100;
    int p = 0;
    for (i = 0; i < 9; i++) {
      // Is the spot available?
      if (showXorO[i] == '') {
        showXorO[i] = 'X';
        score = _miniMax(showXorO, 0, false);
        showXorO[i] = '';
        if (score > bestScore) {
          bestScore = score;
          p = i;
        }
      }
    }
    showXorO[p] = 'X';
    _checkIfWinner();
  }

  Map<String, int> scores = {'X': 1, 'O': -1, 'tie': 0};

  int _miniMax(board, depth, bool isMaximizing) {
    final result = _checkWinner();
    if (result == 'X') {
      return 1;
    } else if (result == 'O') {
      return -1;
    } else if (result == 'DRAW') {
      return 0;
    }

    if (isMaximizing) {
      int bestScore = -100;
      for (int i = 0; i < 9; i++) {
        // Is the spot available?
        if (showXorO[i] == '') {
          showXorO[i] = 'X';
          final int score = _miniMax(board, depth + 1, false);
          showXorO[i] = '';
          bestScore = max(score, bestScore);
        }
      }
      return bestScore;
    } else {
      int bestScore = 100;
      for (int i = 0; i < 9; i++) {
        // Is the spot available?
        if (showXorO[i] == '') {
          showXorO[i] = 'O';
          final int score = _miniMax(board, depth + 1, true);
          showXorO[i] = '';
          bestScore = min(score, bestScore);
        }
      }
      return bestScore;
    }
  }

  dynamic _checkWinner() {
    // checks 1st row
    if (filledBoxes != 9) {
      if (showXorO[0] == showXorO[1] &&
          showXorO[0] == showXorO[2] &&
          showXorO[0] != '') {
        return showXorO[0];
      }

      // checks 2nd row
      if (showXorO[3] == showXorO[4] &&
          showXorO[3] == showXorO[5] &&
          showXorO[3] != '') {
        return showXorO[3];
      }

      // checks 3rd row
      if (showXorO[6] == showXorO[7] &&
          showXorO[6] == showXorO[8] &&
          showXorO[6] != '') {
        return showXorO[6];
      }

      // checks 1st column
      if (showXorO[0] == showXorO[3] &&
          showXorO[0] == showXorO[6] &&
          showXorO[0] != '') {
        return showXorO[0];
      }

      // checks 2nd column
      if (showXorO[1] == showXorO[4] &&
          showXorO[1] == showXorO[7] &&
          showXorO[1] != '') {
        return showXorO[1];
      }

      // checks 3rd column
      if (showXorO[2] == showXorO[5] &&
          showXorO[2] == showXorO[8] &&
          showXorO[2] != '') {
        return showXorO[2];
      }

      // checks diagonal
      if (showXorO[6] == showXorO[4] &&
          showXorO[6] == showXorO[2] &&
          showXorO[6] != '') {
        return showXorO[6];
      }

      // checks diagonal
      if (showXorO[0] == showXorO[4] &&
          showXorO[0] == showXorO[8] &&
          showXorO[0] != '') {
        return showXorO[0];
      }
    } else {
      return 'DRAW';
    }
  }

  void _checkIfWinner() {
    // checks 1st row
    if (filledBoxes != 9) {
      if (showXorO[0] == showXorO[1] &&
          showXorO[0] == showXorO[2] &&
          showXorO[0] != '') {
        _showWinDialog(showXorO[0]);
      }

      // checks 2nd row
      if (showXorO[3] == showXorO[4] &&
          showXorO[3] == showXorO[5] &&
          showXorO[3] != '') {
        _showWinDialog(showXorO[3]);
      }

      // checks 3rd row
      if (showXorO[6] == showXorO[7] &&
          showXorO[6] == showXorO[8] &&
          showXorO[6] != '') {
        _showWinDialog(showXorO[6]);
      }

      // checks 1st column
      if (showXorO[0] == showXorO[3] &&
          showXorO[0] == showXorO[6] &&
          showXorO[0] != '') {
        _showWinDialog(showXorO[0]);
      }

      // checks 2nd column
      if (showXorO[1] == showXorO[4] &&
          showXorO[1] == showXorO[7] &&
          showXorO[1] != '') {
        _showWinDialog(showXorO[1]);
      }

      // checks 3rd column
      if (showXorO[2] == showXorO[5] &&
          showXorO[2] == showXorO[8] &&
          showXorO[2] != '') {
        _showWinDialog(showXorO[2]);
      }

      // checks diagonal
      if (showXorO[6] == showXorO[4] &&
          showXorO[6] == showXorO[2] &&
          showXorO[6] != '') {
        _showWinDialog(showXorO[6]);
      }

      // checks diagonal
      if (showXorO[0] == showXorO[4] &&
          showXorO[0] == showXorO[8] &&
          showXorO[0] != '') {
        _showWinDialog(showXorO[0]);
      }
    } else {
      _customDialog('DRAW');
    }
  }

  void _showWinDialog(String winner) {
    _customDialog('$winner WON');

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  Future<dynamic> _customDialog(String text) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                _playAgain();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Play Again!',
              ),
            ),
            TextButton(
              onPressed: () {
                _playAgain();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
              child: const Text(
                'Exit',
              ),
            ),
          ],
        );
      },
    );
  }

  void _playAgain() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        showXorO[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
