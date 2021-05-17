import 'package:callout/styling/color_palettes.dart';
import 'package:callout/styling/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  File _image;
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
  }

  @override
  Widget build(BuildContext context) {
    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);

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
                  onPressed: () {},
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
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TextField(
                    maxLength: 20,
                    decoration: InputDecoration(
                      fillColor: whiteTint,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Here',
                    ),
                  ),
                ),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: TextField(
                    maxLength: 140,
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: whiteTint,
                      border: OutlineInputBorder(),
                      labelText: 'Enter Here',
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.01,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: neutral),
                      borderRadius: BorderRadius.all(Radius.circular(16))),
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
                        icon: Icon(Icons.location_on_outlined),
                        onPressed: () {},
                        iconSize: 30,
                        color: neutral,
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: neutral,
                      ),
                      IconButton(
                        icon: Icon(Icons.subject_outlined),
                        onPressed: () {},
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
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    alignment: Alignment.center,
                    child: _image == null
                        ? Text('No Image Selected')
                        : Image.file(_image))
              ],
            ),
          ),
        ));
  }
}
