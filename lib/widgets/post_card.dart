import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/widgets/post_card_choices.dart';

class PostCard extends StatefulWidget {
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _isStarred = 0;
  _onStarred(int index) {
    setState(() {
      _isStarred = (index + 1) % 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 320,
        height: 224,
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
                        backgroundImage:
                            AssetImage('assets/images/nav_prof.png'),
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
                                    fontSize: 18,
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
                                      TextStyle(fontSize: 18, color: neutral),
                                )
                              ],
                            ),
                            Text(
                              'Location',
                              style: TextStyle(
                                fontSize: 14,
                                color: neutral,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  PopupMenuButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: neutral,
                      ),
                      onSelected: (choice) {
                        print("Toggleing");
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                              child: Row(
                            children: [
                              Icon(Icons.flag_outlined),
                              Text('Report'),
                            ],
                          )),
                          PopupMenuItem(
                              child: Row(
                            children: [
                              Icon(Icons.subject),
                              Text('Details'),
                            ],
                          ))
                        ];
                        //spacebar
                        //   return postCardChoices
                        //       .map((choice) => new PopupMenuItem(
                        //           value: choice,
                        //           child: Row(
                        //             children: [
                        //               Icon(Icons.flag_outlined),
                        //               Text(choice.choiceName)
                        //             ],
                        //           )))
                        //       .toList();
                        // })
                        // Icon(
                        //   Icons.more_horiz,
                        //   color: neutral,
                        // )
                      })
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
                  fontSize: 11,
                  color: textColor,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: _isStarred == 0
                          ? Icon(
                              Icons.star,
                              size: 24,
                            )
                          : Icon(
                              Icons.star_border,
                              size: 24,
                            ),
                      onPressed: () {
                        _onStarred(_isStarred);
                      },
                      color: _isStarred == 0 ? accentYellow : Colors.black,
                    ),
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 22,
                      color: Colors.black,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
