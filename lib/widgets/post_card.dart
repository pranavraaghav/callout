import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/styling/responsive_size.dart';
import 'package:callout/pages/full_post_page.dart';

class PostCard extends StatefulWidget {
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  //Static Variables
  String _userProfileImage = 'assets/images/nav_prof.png';
  String _userName = 'User';
  String _postedAt = '9h'; //Funky maths to calculate
  String _postLocation = 'Location';
  String _postTitle = 'Title';
  String _postDesc =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis tincidunt felis nisl, eget blandit magna euismod quis. Suspendisse porta mauris sit amet facilisis interdum. Vestibulum sem erat, dictum ac aliquam eget, efficitur nec mauris.';

  int _stars = 15;
  int _comments = 2;
  int _isStarred = 0;
  _onStarred(int index) {
    setState(() {
      _isStarred = (index + 1) % 2;
      if (_isStarred == 0) {
        _stars++;
      } else {
        _stars--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FullPostPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.3,
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
                          backgroundImage: AssetImage(
                              _userProfileImage), //Must be Netwrok image for online urls
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
                                    _userName,
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
                                    _postedAt,
                                    style:
                                        TextStyle(fontSize: 18, color: neutral),
                                  )
                                ],
                              ),
                              Text(
                                _postLocation,
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
                        })
                  ],
                ),
                Text(
                  _postTitle,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  _postDesc,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                            color:
                                _isStarred == 0 ? accentYellow : Colors.black,
                          ),
                          Text(
                            _stars.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _comments.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: textColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              size: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
