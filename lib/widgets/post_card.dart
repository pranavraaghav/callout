import 'package:flutter/material.dart';
import '../styling/color_palettes.dart';

// TODO
// Use colors from color_palettes.dart
// Comment Functionality
// Star Functionality and Animation
// Add Options menu
// Profile Image in production environment
// Uploaded Image in production environment
// Time since posted
// lower opacity of neutralGrey ONLY for boxShadows
// Dynamic text size for content?

class PostCard extends StatefulWidget {
  final String username;
  final String location;
  final String title;
  final String content;

  const PostCard({
    Key key,
    @required this.username,
    @required this.location,
    @required this.title,
    @required this.content,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: neutralGrey,
            offset: Offset(0, 2),
            blurRadius: 3,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.username),
                      Transform.scale(
                        child: Icon(
                          Icons.circle,
                          color: neutralGrey,
                        ),
                        scale: 0.4,
                      ),
                      Text(
                        '8h',
                        style: TextStyle(color: neutralGrey),
                      ),
                    ],
                  ),
                  Text(
                    widget.location,
                    style: TextStyle(
                      color: neutralGrey,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            widget.content,
            style: TextStyle(
              fontSize: 14,
              color: textColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 1.2,
                child: IconButton(
                  icon: Icon(Icons.star_outline),
                  onPressed: () => print('STARRED'),
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () => print('COMMENTED'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
