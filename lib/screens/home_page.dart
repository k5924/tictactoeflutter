import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => setState(() {
              oTurn ? showXorO[index] = 'O' : showXorO[index] = 'X';
              oTurn = !oTurn;
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
    );
  }

  void _checkIfWinner() {
    // checks 1st row
    if (showXorO[0] == showXorO[1] &&
        showXorO[0] == showXorO[2] &&
        showXorO[0] != '') {
      _showWinScreen(showXorO[0]);
    }

    // checks 2nd row
    if (showXorO[3] == showXorO[4] &&
        showXorO[3] == showXorO[5] &&
        showXorO[3] != '') {
      _showWinScreen(showXorO[3]);
    }

    // checks 3rd row
    if (showXorO[6] == showXorO[7] &&
        showXorO[6] == showXorO[8] &&
        showXorO[6] != '') {
      _showWinScreen(showXorO[6]);
    }

    // checks 1st column
    if (showXorO[0] == showXorO[3] &&
        showXorO[0] == showXorO[6] &&
        showXorO[0] != '') {
      _showWinScreen(showXorO[0]);
    }

    // checks 2nd column
    if (showXorO[1] == showXorO[4] &&
        showXorO[1] == showXorO[7] &&
        showXorO[1] != '') {
      _showWinScreen(showXorO[1]);
    }

    // checks 3rd column
    if (showXorO[2] == showXorO[5] &&
        showXorO[2] == showXorO[8] &&
        showXorO[2] != '') {
      _showWinScreen(showXorO[2]);
    }

    // checks diagonal
    if (showXorO[6] == showXorO[4] &&
        showXorO[6] == showXorO[2] &&
        showXorO[6] != '') {
      _showWinScreen(showXorO[6]);
    }

    // checks diagonal
    if (showXorO[0] == showXorO[4] &&
        showXorO[0] == showXorO[8] &&
        showXorO[0] != '') {
      _showWinScreen(showXorO[0]);
    }
  }

  void _showWinScreen(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner WON'),
        );
      },
    );
  }
}
