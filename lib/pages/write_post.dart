import 'package:callout/models/user.dart';
import 'package:callout/services/auth.dart';
import 'package:callout/services/storage.dart';
import 'package:callout/services/database.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/styling/custom_text_styles.dart';
import 'package:callout/styling/responsive_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mime/mime.dart';

import 'package:provider/provider.dart';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  //For location
  bool _gotLocation = false;
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        location = GeoPoint(position.latitude, position.longitude);
        _gotLocation = true;
      });
      print(location.latitude);
    }).catchError((e) {
      print(e);
    });
  }

  //For the image picker
  File _image;
  File _video;
  final imagePicker = ImagePicker();

  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
    print(lookupMimeType(_image.path));
  }

  Future getVideo() async {
    final pickedFile = await imagePicker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
      } else {
        print('No Video selected');
      }
    });
  }

  //For the form itself
  final _formkey = GlobalKey<FormState>();
  bool error = false;

  String title = '';
  String description = '';
  String uid;
  String authorName = 'User Unknown';
  GeoPoint location = GeoPoint(20.5937, 78.9629);

  TextEditingController titleTextController = new TextEditingController();
  TextEditingController descriptionTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CalloutUser>(context);
    uid = user.uid;

    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);

    return StreamBuilder<CalloutUser>(
        stream: DatabaseService(uid: user.uid).userByUid,
        builder: (context, snapshot) {
          if (snapshot.data != null) authorName = snapshot.data.displayName;
          return Scaffold(
              backgroundColor: mainBG,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: textColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: mainBG,
                actions: [
                  Container(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextButton(
                        onPressed: () {
                          newPost(title, description);
                        },
                        child: Text('Post',
                            style: TextStyle(
                                backgroundColor: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: whiteTint))),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTitleTextField(
                            context, 'Title', titleTextController),
                        buildDescriptionTextField(
                            context, 'Description', descriptionTextController),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: neutral),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: Icon(Icons.photo_outlined),
                                onPressed: () {
                                  getImage();
                                },
                                iconSize: 30,
                                color: neutral,
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: neutral,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  color: _gotLocation ? primary : null,
                                ),
                                onPressed: () {
                                  _getCurrentLocation();
                                },
                                iconSize: 30,
                                color: neutral,
                              ),
                              Container(
                                width: 1,
                                height: 40,
                                color: neutral,
                              ),
                              IconButton(
                                icon: Icon(Icons.video_call),
                                onPressed: () {
                                  getVideo();
                                },
                                iconSize: 30,
                                color: neutral,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: neutral),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            alignment: Alignment.center,
                            child: _image == null
                                ? Text('No Image Selected')
                                : Image.file(_image)),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.01,
                        ),
                        //   Container(
                        //       decoration: BoxDecoration(
                        //           border: Border.all(color: neutral),
                        //           borderRadius:
                        //               BorderRadius.all(Radius.circular(16))),
                        //       padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        //       alignment: Alignment.center,
                        //       child: _video == null
                        //           ? Text('No Video Selected')
                        //           : Text(_video.path))
                      ],
                    ),
                  ),
                ),
              ));
        });
  }

  Future<String> _uploadImage() async {
    return StorageService().uploadImageToFirebase(_image, uid + '-' + title);
  }

  Widget buildTitleTextField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: buildRobotoDrawerTextStyle(24, textColor, FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: TextFormField(
            maxLength: 20,
            controller: controller,
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid title';
              }
              return null;
            },
            showCursor: true,
            decoration: InputDecoration(
              fillColor: whiteTint,
              border: OutlineInputBorder(),
              labelText: 'Enter Here',
            ),
          ),
        ),
      ],
    );
  }

  newPost(String title, String description) async {
    String imageUrl = await _uploadImage();

    await DatabaseService()
        .createPost(title, description, uid, location, authorName, imageUrl);
    Navigator.pop(context);
  }

  Widget buildDescriptionTextField(
      BuildContext context, String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: buildRobotoDrawerTextStyle(24, textColor, FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: TextFormField(
            maxLength: 140,
            controller: controller,
            onChanged: (value) {
              setState(() {
                description = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a valid description';
              }
              return null;
            },
            showCursor: true,
            decoration: InputDecoration(
              fillColor: whiteTint,
              border: OutlineInputBorder(),
              labelText: 'Enter Here',
            ),
          ),
        ),
      ],
    );
  }
}
