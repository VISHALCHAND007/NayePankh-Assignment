import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nayepankh_app/helpers/enums/category.dart';
import 'package:uuid/uuid.dart';

const uid = Uuid();

class PostModel {
  PostModel({
    String? id,
    DateTime? dateTime,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    List<String>? likes,
    List<dynamic>? comments,
  }) : id = id ?? uid.v4(),
       dateTime = dateTime ?? DateTime.now(),
       likes = likes ?? [],
       comments = comments ?? [];

  final String id;
  final DateTime dateTime;
  final String title;
  final Category category;
  final String description;
  final String imageUrl;
  final List<String> likes; //list of uid of the users who likes the post
  final List<dynamic>
  comments; //list of comments on the post initially both are blank

  factory PostModel.fromJson(Map<String, dynamic> json, String documentId) {
    final likes = (json['likes'] as List<dynamic>? ?? [])
        .map((likeObj) => likeObj.toString())
        .toList();
    return PostModel(
      id: documentId,
      title: json['title'],
      category: Category.values.firstWhere(
        (cat) => cat.name == json['category'],
      ),
      description: json['description'],
      imageUrl: json['imageUrl'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      likes: likes,
      comments: List<dynamic>.of(json['comments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category.name,
    'description': description,
    'imageUrl': imageUrl,
    'dateTime': dateTime,
    'likes': likes,
    'comments': comments,
  };
}
