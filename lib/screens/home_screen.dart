import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/auth_helper.dart';
import 'package:nayepankh_app/helpers/shared_preferences.dart';
import 'package:nayepankh_app/screens/admin_screen.dart';
import 'package:nayepankh_app/screens/user_screen.dart';
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
  SharedPreferences prefs = CustomSharedPreferences.instance;
  late final theme = Theme.of(context);
  var tabItems = [];

  void navigate() {
    isAdmin
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => const AdminScreen()),
          )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (ctx) => const UserScreen()),
          );
  }

  void loadUserData() async {
    try {
      final userMap = await AuthHelper.getUserCredentials();
      username = userMap['username'];
      isAdmin = userMap['isAdmin'];

      navigate();
    } catch (e) {
      if (kDebugMode) print('$e');
    }
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
