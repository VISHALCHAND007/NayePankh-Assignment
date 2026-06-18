import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nayepankh_app/firebase_options.dart';
import 'package:nayepankh_app/helpers/firestore_helper.dart';
import 'package:nayepankh_app/helpers/shared_preferences.dart';
import 'package:nayepankh_app/screens/auth_screen.dart';
import 'package:nayepankh_app/screens/home_screen.dart';
import 'package:nayepankh_app/widgets/auth_wrapper.dart';

final kColorScheme = ColorScheme.fromSeed(seedColor: Colors.lightBlue);

final themeData = ThemeData().copyWith(
  colorScheme: kColorScheme,
);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await CustomSharedPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: themeData,
      darkTheme: themeData,
      home: const AuthWrapper(),
    );
  }
}
