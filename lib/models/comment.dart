import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String commentID;
  final String authorID;
  final String comment;
  final Timestamp createdAt;

  Comment({this.commentID, this.authorID, this.comment, this.createdAt});
}
