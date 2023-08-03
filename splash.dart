import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int blockCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          blockCount++;
          _animationController.forward(from: 0.0);
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  width: 160.0, // Adjust the width here
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '#',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '#',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        '#',
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                      SizedBox(width: 8.0),
                      ScaleTransition(
                        scale: _animationController,
                        child: Text(
                          '#',
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Block Count: $blockCount',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
