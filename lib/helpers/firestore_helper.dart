import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/firestore_collections.dart';
import 'package:nayepankh_app/models/admin/post_model.dart';
import 'package:nayepankh_app/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class FirestoreHelper {
  static final _firestore = FirebaseFirestore.instance;
  static final auth = FirebaseAuth.instance;

  static Future<Map<String, dynamic>> getUserCredentials() async {
    try {
      // _auth.signOut();
      final userData = await _firestore
          .collection(FirestoreCollections.users)
          .doc(auth.currentUser?.uid)
          .get();
      return {
        'isAdmin': userData.data()?['isAdmin'] ?? 'false',
        'username': userData.data()?['username'],
      };
    } catch (e) {
      if (kDebugMode) print('$e');
      throw Exception('Error:: $e');
    }
  }

  static Future<void> postStory(PostModel postmodel) async {
    try {
      await _firestore
          .collection(FirestoreCollections.posts)
          .doc()
          .set(postmodel.toJson());
      return;
    } catch (e) {
      if (kDebugMode) print(e);
      throw Exception('Error:: $e');
    }
  }

  static Stream<List<PostModel>> getAllPosts() {
    return _firestore
        .collection(FirestoreCollections.posts)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => PostModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  static Future<void> toggleLike(String postId, List<String> likes) async {
    try {
      final uid = auth.currentUser?.uid;

      final postRef = _firestore
          .collection(FirestoreCollections.posts)
          .doc(postId);

      if (likes.contains(uid)) {
        await postRef.update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await postRef.update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      if (kDebugMode) print(e);
      throw Exception('Error:: $e');
    }
  }

  static Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const AuthScreen()),
        (route) => false,
      );
    } catch (e) {
      if (kDebugMode) print(e);
      throw Exception('Error:: $e');
    }
  }

  static Future<void> addComment(String postId, String comment) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final username = prefs.getString('username');

      await _firestore
          .collection(FirestoreCollections.posts)
          .doc(postId)
          .update({
            'comments': FieldValue.arrayUnion([
              {'text': comment, 'username': username},
            ]),
          });
      return;
    } catch (e) {
      throw Exception('Error:: $e');
    }
  }

  static Stream<PostModel> getPost(String postId) {
    print('postid:: ');
    print(postId);
    return _firestore
        .collection(FirestoreCollections.posts)
        .doc(postId)
        .snapshots()
        .map((snapshot) => PostModel.fromJson(snapshot.data()!, snapshot.id));
  }
}
