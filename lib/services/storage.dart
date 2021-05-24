import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future uploadImageToFirebase(BuildContext context, File imageFile) async {
    String fileName = imageFile.path;
    Reference storageRef = FirebaseStorage.instance.ref('/posts/$fileName');
    UploadTask uploadTask = storageRef.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.snapshot;
    taskSnapshot.ref
        .getDownloadURL()
        .then((value) => print("Upload Done : $value"));
  }
}
