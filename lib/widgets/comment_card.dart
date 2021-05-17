import 'package:callout/styling/responsive_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/pages/full_post_page.dart';

class CommentCard extends StatefulWidget {
  @override
  _CommentCardState createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  //Static variables
  String _userProfileImage = 'assets/images/ajay_prof.png';
  String _userName = 'User';
  String _commentedAt = '4h'; //Funky maths to calculate
  String _userLocation = 'Location';
  String _commentDesc =
      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium';

  @override
  Widget build(BuildContext context) {
    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                        backgroundImage: AssetImage(_userProfileImage),
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
                                  _commentedAt,
                                  style:
                                      TextStyle(fontSize: 18, color: neutral),
                                )
                              ],
                            ),
                            Text(
                              _userLocation,
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
                _commentDesc,
                style: TextStyle(
                  fontSize: 10,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
