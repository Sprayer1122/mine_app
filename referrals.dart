import 'package:flutter/material.dart';

class ReferralsSection extends StatelessWidget {
  final double coin;

  ReferralsSection({required this.coin});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Your action when the floating action button is pressed
            },
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.account_box, // Replace with your desired icon
              size: 24,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Referral: $coin',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
