import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:avatar_glow/avatar_glow.dart';

import '../widgets/mining_button.dart';
import '../widgets/counter_card.dart';
import '../widgets/referrals.dart';
import '../widgets/bottom_bar.dart';
import './chat_screen.dart';
import './user.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;
  Timer? _timer;
  String buttonText = 'Start Mining';
  int elapsedTime = 0;
  double ref = 2;
  double coin = 1; // Initialize coin to 0

  late double incrementValue;

  @override
  void initState() {
    super.initState();
    // Initialize coin inside the initState method
    coin += ref * 1;

    // Initialize incrementValue in the initState method
    incrementValue = coin * 2;
    // You can change the value of incrementValue to any other number as needed
    // For example, to increment by 2.0, you can set incrementValue = 2.0;
    // To increment by 0.5, you can set incrementValue = 0.5;

    // Retrieve the last stored counter value from SharedPreferences
    _loadCounter();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _saveCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter);
  }

  void startCounting() {
    if (_timer != null && _timer!.isActive) {
      // The timer is already running, so reset the elapsed time and continue
      elapsedTime = 0;
      return;
    }

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        elapsedTime++;
        buttonText = 'Mining Speed = $incrementValue';
        counter = (counter + incrementValue).toInt();
      });

      if (elapsedTime >= 10) {
        stopCounting();
      }
    });
  }

  void stopCounting() {
    _timer?.cancel();
    setState(() {
      buttonText = 'Start Mining';
    });
    elapsedTime = 0; // Reset elapsed time to 0
    // Save the counter value to SharedPreferences when the timer is stopped
    _saveCounter();
  }

  int _selectedIndex = 0;

  // Function to handle bottom navigation bar item taps
  void _onItemTapped(int index) {
    // Navigate to the corresponding screen based on the selected index
    switch (index) {
      case 0:
        // No need to navigate if the user taps the same item again
        if (_selectedIndex != 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
        break;
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil(
          ChatScreen.routeName,
          (route) => false,
        );
        break;
      case 2:
        Navigator.of(context).pushNamedAndRemoveUntil(
          UserPage.routeName,
          (route) => false,
        );
        break;
      // Add more cases for additional screens if needed
    }

    // Update the selected index after navigation
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minepay',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 10, 15, 29),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    '$counter Verse Coin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ReferralsSection(
                coin: coin,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MiningButton(
                    onStart: startCounting,
                    onStop: stopCounting,
                    buttonText: buttonText,
                  ),
                ],
              ),
              SizedBox(height: 80),
              CounterCard(
                counter: counter,
                incrementValue: incrementValue,
                coin: coin,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
