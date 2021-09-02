import 'package:flutter/material.dart';
import '../utilities/export.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> showXorO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: kTextStyle,
                        ),
                        Text(
                          xScore.toString(),
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: kTextStyle,
                        ),
                        Text(
                          oScore.toString(),
                          style: kTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                    if (oTurn && showXorO[index] == '') {
                      showXorO[index] = 'O';
                      filledBoxes++;
                      oTurn = !oTurn;
                    } else if (!oTurn && showXorO[index] == '') {
                      showXorO[index] = 'X';
                      filledBoxes++;
                      oTurn = !oTurn;
                    }

                    _checkIfWinner();
                  }),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        showXorO[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
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
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner WON'),
          actions: [
            TextButton(
              onPressed: () {
                _playAgain();
                Navigator.of(context).pop();
              },
              child: Text(
                'Play Again!',
              ),
            )
          ],
        );
      },
    );

    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('DRAW'),
          actions: [
            TextButton(
              onPressed: () {
                _playAgain();
                Navigator.of(context).pop();
              },
              child: Text(
                'Play Again!',
              ),
            )
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
