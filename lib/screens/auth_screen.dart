import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nayepankh_app/widgets/auth_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  late final scaffoldMessenger = ScaffoldMessenger.of(context);
  late final theme = Theme.of(context);
  var _isLoading = false;

  void _onFormSubmit({
    required String email,
    required String password,
    String? username,
    required bool isLogin,
    required BuildContext context,
  }) async {
    UserCredential userCredential;
    final prefs = await SharedPreferences.getInstance();

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        //get and save the username
        final userData = await _fireStore
            .collection('users')
            .doc(userCredential.user?.uid)
            .get();

        await prefs.setString('username', userData.data()?['username']);
        await prefs.setBool('isAdmin', userData.data()?['isAdmin']);
        // print('username: ${userData.data()!['username']}, isAdmin:: ${userData.data()!['isAdmin']}');
      } else {
        //signup
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //saving username
        await prefs.setString('username', username!);
        await prefs.setBool('isAdmin', false);

        //create new entry in users collection of the user
        await _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
          'isAdmin': false
        });
      }
      if(!mounted) return;

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (error) {
      setState(() {
        _isLoading = false;
      });
      var message = 'An error occurred, please try again later!';
      if (error.message != null) message = error.message!;

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(message),
          showCloseIcon: true,
          backgroundColor: theme.colorScheme.onErrorContainer,
        ),
      );
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      if (kDebugMode) {
        print('Error:: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthForm(isLoading: _isLoading, onSubmit: _onFormSubmit),
    );
  }
}
