import 'package:cloud_firestore/cloud_firestore.dart';

//When you want to change these fields
//1. Make sure firestore matches up perfectly
//2. Go to /services/database.dart and under _postListFromSnapshot make sure the fields match up
//3. Obviously check in /widgets/post_card.dart to make sure it gets used right

class Post {
  final String postID;
  final String title;
  final Timestamp createdAt;
  final GeoPoint location;
  final String imageUrl;
  final String userProfileUrl;
  final String description;
  final String authorID;
  final String authorName;
  final int starCount;
  Post(
      {this.postID,
      this.title,
      this.createdAt,
      this.location,
      this.imageUrl,
      this.userProfileUrl,
      this.description,
      this.authorID,
      this.authorName,
      this.starCount});
}
