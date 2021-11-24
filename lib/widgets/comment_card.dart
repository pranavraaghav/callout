import 'package:callout/models/comment.dart';
import 'package:callout/models/user.dart';
import 'package:callout/services/database.dart';
import 'package:callout/styling/custom_text_styles.dart';
import 'package:callout/styling/responsive_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/pages/full_post_page.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;

  CommentCard({this.comment});
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  //Static variables
  String _userProfileImage =
      'https://firebasestorage.googleapis.com/v0/b/callout-314015.appspot.com/o/nav_prof.png?alt=media&token=88ad1e8b-9dfe-459e-84b9-9591c862ea4d';
  String _userName = 'User';
  String _commentedAt = '4h';
  String _userLocation = 'Location';
  String _commentDesc = 'Comment';

  //For Created at
  int _currentTimeDiff;

  String _getCurrentTimeDiff() {
    //Check if at least a day has passed
    _currentTimeDiff = Timestamp.now()
        .toDate()
        .difference(widget.comment.createdAt.toDate())
        .inHours;
    if (_currentTimeDiff > 24) {
      return (Timestamp.now()
              .toDate()
              .difference(widget.comment.createdAt.toDate())
              .inDays
              .toString() +
          'd');
    } else if (Timestamp.now()
            .toDate()
            .difference(widget.comment.createdAt.toDate())
            .inMinutes >
        60) {
      return Timestamp.now()
              .toDate()
              .difference(widget.comment.createdAt.toDate())
              .inHours
              .toString() +
          'h';
    } else {
      return Timestamp.now()
              .toDate()
              .difference(widget.comment.createdAt.toDate())
              .inMinutes
              .toString() +
          'min';
    }
  }

  @override
  Widget build(BuildContext context) {
    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);

    return StreamBuilder<CalloutUser>(
        stream: DatabaseService(uid: widget.comment.authorID).userByUid,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            _userProfileImage = snapshot.data.photoURL;
            _userName = snapshot.data.displayName;
            _commentedAt = _getCurrentTimeDiff();
            _commentDesc = widget.comment.comment;
          }

          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: SizeConfig.screenWidth * 0.8,
              height: SizeConfig.screenHeight * 0.15,
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
                              backgroundImage: NetworkImage(_userProfileImage),
                              radius: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(_userName,
                                          style: buildBoldRobotoText(
                                              18, textColor)),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Color(0xffAAB1BB),
                                        ),
                                      ),
                                      Text(_commentedAt,
                                          style:
                                              buildRobotoTextStyle(18, neutral))
                                    ],
                                  ),
                                  // Text(
                                  //   _userLocation,
                                  //   style: TextStyle(
                                  //     fontSize: 14,
                                  //     color: neutral,
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // PopupMenuButton(
                        //     icon: Icon(
                        //       Icons.more_horiz,
                        //       color: neutral,
                        //     ),
                        //     onSelected: (choice) {
                        //       print("Toggleing");
                        //     },
                        //     itemBuilder: (BuildContext context) {
                        //       return [
                        //         PopupMenuItem(
                        //             child: Row(
                        //           children: [
                        //             Icon(Icons.flag_outlined),
                        //             Text('Report'),
                        //           ],
                        //         )),
                        //         PopupMenuItem(
                        //             child: Row(
                        //           children: [
                        //             Icon(Icons.subject),
                        //             Text('Details'),
                        //           ],
                        //         ))
                        //       ];
                        //     })
                      ],
                    ),
                    Text(_commentDesc,
                        style: buildRobotoTextStyle(16, textColor)),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
