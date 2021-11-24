import 'package:callout/models/comment.dart';
import 'package:callout/models/post.dart';
import 'package:callout/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference postsCollection =
      FirebaseFirestore.instance.collection('posts');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  Future<CalloutUser> getUserDoc() async {
    var userDoc = await usersCollection.doc(uid).get();
    return CalloutUser.fromSnapshot(userDoc);
  }

  Future<CalloutUser> getUserDocByUID({uid}) async {
    var userDoc = await usersCollection.doc(uid).get();
    return CalloutUser.fromSnapshot(userDoc);
  }

  Future<List<Comment>> getCommentsByPostID({uid}) async {
    List<Comment> comments;

    commentsCollection.doc(uid).get().then((value) {
      List.from(value.get('comments')).forEach((element) {
        //print(element);
        comments.add(element);
      });
    });

    return comments;
  }

  Future updateUserData(
      String email, String displayName, GeoPoint location) async {
    return await usersCollection.doc(uid).set({
      'displayName': displayName,
      'location': location,
      'email': email,
      'photoURL':
          "https://firebasestorage.googleapis.com/v0/b/callout-314015.appspot.com/o/nav_prof.png?alt=media&token=88ad1e8b-9dfe-459e-84b9-9591c862ea4d",
    });
  }

  Future createPost(String title, String description, String authorID,
      GeoPoint location, String authorName, String imageUrl) async {
    print("Create Post : ");
    print(title +
        description +
        authorID +
        location.toString() +
        authorName +
        imageUrl);

    //TODO: Remove hard coded value

    return await postsCollection.add({
      'title': title,
      'description': description,
      'location': location,
      'authorID': authorID,
      'authorName': authorName,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
      'userProfileUrl':
          "https://firebasestorage.googleapis.com/v0/b/callout-314015.appspot.com/o/nav_prof.png?alt=media&token=88ad1e8b-9dfe-459e-84b9-9591c862ea4d",
      'starCount': 1,
      'comments': [],
    });
  }

  Future addComment(
      String postID, String authorID, String comment, String title) async {
    //List<Comment> comments;
    var list = [
      {'authorID': authorID, 'comment': comment, 'createdAt': Timestamp.now()}
    ];
    return await postsCollection
        .doc(postID)
        .update({"comments": FieldValue.arrayUnion(list)});
  }

  CalloutUser _calloutUserFromSnapShot(DocumentSnapshot snapshot) {
    return CalloutUser(
      uid: uid,
      displayName: snapshot.get('displayName') ?? 'Username',
      email: snapshot.get('email') ?? 'Email Address',
      photoURL: snapshot.get('photoURL') ??
          "https://firebasestorage.googleapis.com/v0/b/callout-314015.appspot.com/o/nav_prof.png?alt=media&token=88ad1e8b-9dfe-459e-84b9-9591c862ea4d",
    );
  }

  Comment _commentFromSnapshot(DocumentSnapshot snapshot) {
    return Comment(
        authorID: snapshot.get('authorID') ?? null,
        comment: snapshot.get('comment') ?? '',
        createdAt: snapshot.get('createdAt') ?? Timestamp.now());
  }

  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<Comment> comments = [];
      List<dynamic> commentsMap = doc.get('comments');
      commentsMap.forEach((comment) {
        comments.add(new Comment(
            authorID: comment['authorID'],
            comment: comment['comment'],
            createdAt: comment['createdAt']));
      });

      return Post(
        postID: doc.id,
        title: doc.get('title') ?? '',
        authorID: doc.get('authorID') ?? '',
        createdAt: doc.get('createdAt') ?? Timestamp.now(),
        location: doc.get('location') ?? GeoPoint(20.5937, 78.9629),
        description: doc.get('description') ?? '',
        userProfileUrl: doc.get('userProfileUrl') ?? '',
        imageUrl: doc.get('imageUrl') ?? '',
        authorName: doc.get('authorName') ?? '',
        starCount: doc.get('starCount') ?? 0,
        comments: comments ?? [],
      );
    }).toList();
  }

  //Streams are basically a database listener, when the database is updated anything connected to the stream gets updated too
  Stream<QuerySnapshot> get users {
    return usersCollection.snapshots();
  }

  Stream<CalloutUser> get userByUid {
    //print(usersCollection.doc(uid).snapshots().map(_calloutUserFromSnapShot));
    return usersCollection.doc(uid).snapshots().map(_calloutUserFromSnapShot);
  }

  Stream<Comment> get commentByPostID {
    print(commentsCollection.doc(uid).get().then((value) {
      List.from(value.get('comments')).forEach((element) {
        print(element);
      });
    }));
    // return commentsCollection.doc(uid).snapshots().map(_commentFromSnapshot);
    return commentsCollection.doc(uid).snapshots().map(_commentFromSnapshot);
  }

  // CalloutUser getUserByUid {
  //   return usersCollection.doc(uid).get().then((value) => null);
  // }

  //Set up a stream for the posts collection and formats then according to our post model
  Stream<List<Post>> get posts {
    return postsCollection
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  Stream<List<Post>> get postsByStars {
    return postsCollection
        .orderBy("starCount", descending: true)
        .snapshots()
        .map(_postListFromSnapshot);
  }

  Stream<List<Post>> get postsByLocation {
    return postsCollection
        .orderBy("location", descending: true)
        .snapshots()
        .map(_postListFromSnapshot);
  }
}
