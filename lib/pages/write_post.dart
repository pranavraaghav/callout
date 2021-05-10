import 'package:callout/styling/color_palettes.dart';
import 'package:flutter/material.dart';

class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {
  @override
  Widget build(BuildContext context) {
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
        body: Padding(
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
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: whiteTint,
                    border: OutlineInputBorder(),
                    labelText: 'Enter Here',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
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
              )
            ],
          ),
        ));
  }
}
