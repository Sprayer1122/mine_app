import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class CounterCard extends StatelessWidget {
  final int counter;
  final double incrementValue;
  final double coin;

  CounterCard({
    required this.counter,
    required this.incrementValue,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Card(
          // Customize the card as you like
          color: Color.fromARGB(255, 38, 82, 105),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Increment Value: $incrementValue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),

        SizedBox(height: 10), // Space between the button and the card
        Card(
          // Customize the card as you like
          color: Color.fromARGB(255, 38, 82, 105),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'UNI COIN: $coin',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
