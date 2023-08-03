import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/bottom_bar.dart';
import './chat_screen.dart';
import './home_screen.dart';
import './auth.dart';
import 'dart:math';

class UserPage extends StatefulWidget {
  static const routeName = '/user-page';

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final String websiteURL =
      "https://minepay.framer.ai/"; // Replace with your website URL

  int _selectedIndex = 2;
  late User _user;
  Map<String, dynamic>? _userData; // Use nullable type for _userData
  String? _username; // Use nullable type for _username

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
    _fetchUserData();
  }

  void _fetchUserData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user.uid)
        .get();
    if (snapshot.exists) {
      _userData = snapshot.data() as Map<String, dynamic>;
      _username = _userData!['username'];
      setState(() {});
    } else {
      // The document does not exist in Firestore. Handle this case accordingly.
      print('User document does not exist in Firestore.');
    }
  }

  // Function to open the website URL in the device's default browser
  // ...

  void _openWebsite() async {
    final Uri url = Uri.parse("https://minepay.framer.ai/");

    if (!await canLaunch(url.toString())) {
      throw Exception('Could not launch $url');
    }
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          navigateToHomeScreen();
          break;
        case 1:
          navigateToChatScreen();
          break;
        case 2:
          // Already on the UserPage, no need to navigate
          break;
        // Add more cases for additional screens if needed
      }
    }
  }

  void navigateToHomeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName,
      (route) => false,
    );
  }

  void navigateToChatScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      ChatScreen.routeName,
      (route) => false,
    );
  }

  // Function for handling logout
  void _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AnimatedLoginPage.routeName,
        (route) => false,
      );
    } catch (e) {
      print("Error while logging out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text("Account"),
          ),
          backgroundColor: Color.fromARGB(255, 10, 15, 29),
        ),
      ),
      body: _userData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Color.fromARGB(255, 10, 15, 29),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // User's image...
                  CircleAvatar(
                    radius: 80,
                    backgroundImage:
                        NetworkImage(_userData!['image_url'] ?? ''),
                  ),
                  SizedBox(height: 30),
                  // User's name...
                  Text(
                    _username ?? 'Username not found',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 100),
                  // Content here...
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Content here...
                        ],
                      ),
                    ),
                  ),
                  // Four "Visit Website" buttons in separate rows
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: navigateToHomeScreen,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 10, 15,
                                  29), // Change the background color here
                              textStyle: TextStyle(
                                  fontSize: 20), // Change the font size here
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10), // Change the button size here
                            ),
                            child: Row(
                              // Use Row widget to display icon and text in a row
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: navigateToChatScreen,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 10, 15,
                                  29), // Change the background color here
                              textStyle: TextStyle(
                                  fontSize: 20), // Change the font size here
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10), // Change the button size here
                            ),
                            child: Row(
                              // Use Row widget to display icon and text in a row
                              children: [
                                Icon(
                                  Icons.mark_chat_unread_sharp,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Support",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: _openWebsite,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 10, 15,
                                  29), // Change the background color here
                              textStyle: TextStyle(
                                  fontSize: 20), // Change the font size here
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10), // Change the button size here
                            ),
                            child: Row(
                              // Use Row widget to display icon and text in a row
                              children: [
                                Icon(
                                  Icons.web_stories,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "View Website",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: _logout,
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 10, 15,
                                  29), // Change the background color here
                              textStyle: TextStyle(
                                  fontSize: 20), // Change the font size here
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30,
                                  vertical: 10), // Change the button size here
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("LogOut",
                                  style: TextStyle(color: Colors.redAccent)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
