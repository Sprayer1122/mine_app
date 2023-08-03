import 'package:flutter/material.dart';
import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';

class MiningButton extends StatefulWidget {
  final VoidCallback onStart;
  final VoidCallback onStop;
  final String buttonText;

  MiningButton({
    required this.onStart,
    required this.onStop,
    required this.buttonText,
  });

  @override
  _MiningButtonState createState() => _MiningButtonState();
}

class _MiningButtonState extends State<MiningButton> {
  Timer? _timer;
  int elapsedTime = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCounting() {
    if (_timer != null && _timer!.isActive) {
      // The timer is already running, so reset the elapsed time and continue
      setState(() {
        elapsedTime = 0;
      });
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime++;
      });

      if (elapsedTime >= 10) {
        widget.onStop();
      }
    });
    widget.onStart();
  }

  void _stopCounting() {
    _timer?.cancel();
    widget.onStop();
    setState(() {
      elapsedTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      child: ElevatedButton(
        onPressed: () {
          if (_timer != null && _timer!.isActive) {
            _stopCounting();
          } else {
            _startCounting();
          }
        },
        child: Text(widget.buttonText),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(100, 120),
          backgroundColor: Color.fromARGB(255, 20, 164, 189),
        ),
      ),
      endRadius: 120,
      glowColor: Colors.white,
    );
  }
}
