import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  bool isAdmin = false;
  late SharedPreferences prefs;

  void loadPrefsData() async {
    try {
      prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username') ?? 'Unknown';
        isAdmin = prefs.getBool('isAdmin') ?? false;
      });
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    loadPrefsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Text(
              'Logged in',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            Text(
              'isAdmin: $isAdmin',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            Text(
              'username: $username',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                prefs.remove('username');
                prefs.remove('isAdmin');
                FirebaseAuth.instance.signOut();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
