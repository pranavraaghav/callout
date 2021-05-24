import 'package:callout/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(String displayName, GeoPoint location) async {
    return await usersCollection.doc(uid).set({
      'displayName': displayName,
      'location': location,
    });
  }

  Future createPost(String title, String description, String authorID, GeoPoint location, String authorName, String imageUrl) async {
    
    print("Create Post : ");
    print(title + description + authorID+ location.toString() + authorName+ imageUrl);
    
    //TODO: Remove hard coded value

    return await postsCollection.add({
      'title': title,
      'description' : description,
      'location': location,
      'authorID': authorID,
      'authorName': authorName,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
      'userProfileUrl': "https://firebasestorage.googleapis.com/v0/b/callout-314015.appspot.com/o/nav_prof.png?alt=media&token=88ad1e8b-9dfe-459e-84b9-9591c862ea4d",
      'starCount': 1,
    });
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
        title: doc.get('title') ?? '',
        authorID: doc.get('authorID') ?? '',
        createdAt: doc.get('createdAt') ?? Timestamp.now(),
        location: doc.get('location') ?? GeoPoint(20.5937, 78.9629),
        description: doc.get('description') ?? '',
        userProfileUrl: doc.get('userProfileUrl') ?? '',
        imageUrl: doc.get('imageUrl') ?? '',
        authorName: doc.get('authorName') ?? '',
        starCount: doc.get('starCount') ?? 0, 
      );
    }).toList();
  }

  //Streams are basically a database listener, when the database is updated anything connected to the stream gets updated too
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  //Set up a stream for the posts collection and formats then according to our post model
  Stream<List<Post>> get posts {
    return postsCollection.orderBy("createdAt", descending: true).snapshots().map(_postListFromSnapshot);
  }
}
