import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';

class PostCard extends StatefulWidget {
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 320,
        height: 212,
        decoration: BoxDecoration(
            color: whiteTint, borderRadius: BorderRadius.circular(11)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('images/nav_prof.png'),
                        radius: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'User',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.circle,
                                    size: 8,
                                    color: Color(0xffAAB1BB),
                                  ),
                                ),
                                Text(
                                  '8h',
                                  style:
                                      TextStyle(fontSize: 14, color: neutral),
                                )
                              ],
                            ),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 10,
                                color: neutral,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.more_horiz,
                    color: neutral,
                  )
                ],
              ),
              Text(
                'Title',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tincidunt felis nisl, eget blandit magna euismod quis. Suspendisse porta mauris sit amet facilisis interdum. Vestibulum sem erat, dictum ac aliquam eget, efficitur nec mauris.',
                style: TextStyle(
                  fontSize: 10,
                  color: textColor,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.star,
                    size: 24,
                    color: accentYellow,
                  ),
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 22,
                    color: Colors.black,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
