import 'package:armor_display/body_name_entry_screen.dart';
import 'package:armor_display/body_view.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int silverScore;
  final int blackScore;
  final int silverscore1, silverscore2, silverscore3;
  final int blackscore1, blackscore2, blackscore3;
  final String player1, player2;

  const ResultScreen(
      {Key? key,
      required this.silverScore,
      required this.blackScore,
      required this.silverscore1,
      required this.silverscore2,
      required this.silverscore3,
      required this.blackscore1,
      required this.blackscore2,
      required this.blackscore3,
      required this.player1,
      required this.player2})
      : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String determineWinner() {
    if (widget.silverScore > widget.blackScore) {
      return "${widget.player1.toUpperCase()} WON THE GAME!";
    } else if (widget.silverScore < widget.blackScore) {
      return "${widget.player2.toUpperCase()} WON THE GAME!";
    } else {
      return "IT IS A TIE!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        title: const Text(
          'Score Board',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.player1.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.player2.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Text(
              'SCORES ',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStrikeRow(widget.silverscore1, widget.blackscore1),
                _buildStrikeRow(widget.silverscore2, widget.blackscore2),
                _buildStrikeRow(widget.silverscore3, widget.blackscore3),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'TOTAL SCORE',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '${widget.silverScore}',
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  '${widget.blackScore}',
                  style: const TextStyle(fontSize: 25),
                ),
              ],
            ),

            const SizedBox(height: 40),

            Center(
              child: Text(
                determineWinner(),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 40),
            // Button to play again
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.blueGrey[900], // Change color as needed
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BodyView(
                        body1Name: widget.player1,
                        body2Name: widget.player2,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Play Again',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Colors.blueGrey[700], // Change color as needed
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BodyNameEntryScreen(),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'End Game',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStrikeRow(int silverScore, int blackScore) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          '$silverScore',
          style: const TextStyle(fontSize: 25),
        ),
        Text(
          '$blackScore',
          style: const TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
