import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageService {
  Future<String> uploadImageToFirebase(File image, String postID) async {
    firebase_storage.Reference storageReference;
    String storagePath = 'posts/$postID';

    storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(storagePath);

    await storageReference.putFile(image);
    String returnURL;
    await storageReference.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });
    return returnURL;
  }

  Future uploadVideoToFirebase(File video, String postID) async {
    firebase_storage.Reference storageRef;
    String storagePath = 'posts/videos/$postID';

    storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(storagePath);

    await storageRef.putFile(video);
    String returnURL;
    await storageRef.getDownloadURL().then((fileURL) {
      returnURL = fileURL;
    });

    return returnURL;
  }
}
