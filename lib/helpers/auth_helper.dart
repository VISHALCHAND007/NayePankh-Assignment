import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<Map<String, dynamic>> getUserCredentials() async {
    try {
      // _auth.signOut();
      final userData = await _firestore.collection('users')
          .doc(_auth.currentUser?.uid)
          .get();
      return {
        'isAdmin': userData.data()?['isAdmin'] ?? 'false',
        'username': userData.data()?['username']
      };
    } catch(e) {
      print('${e}');
      throw Exception('Error:: $e');
    }
  }
}