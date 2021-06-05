import 'package:cloud_firestore/cloud_firestore.dart';

class CalloutUser {
  String uid;
  String displayName;
  String email;
  String photoURL;

  CalloutUser.fromSnapshot(DocumentSnapshot snapshot) {
    displayName = snapshot['displayName'];
    email = snapshot['email'];
    photoURL = snapshot['photoURL'];
  }

  CalloutUser({this.uid, this.displayName, this.email, this.photoURL});
}
