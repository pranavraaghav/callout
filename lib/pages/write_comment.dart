import 'package:callout/models/post.dart';
import 'package:callout/models/user.dart';
import 'package:callout/services/auth.dart';
import 'package:callout/services/database.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/styling/custom_text_styles.dart';
import 'package:callout/styling/responsive_size.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WriteComment extends StatefulWidget {
  final Post post;
  WriteComment({this.post});
  @override
  _WriteCommentState createState() => _WriteCommentState();
}

class _WriteCommentState extends State<WriteComment> {
  final _formkey = GlobalKey<FormState>();
  bool error = false;
  String uid;
  String comment = '';
  TextEditingController commentTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CalloutUser>(context);
    uid = user.uid;
    //Imports the responsive sizes of whatever screen
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                PostCard(
                  post: widget.post,
                ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.8,
                          height: SizeConfig.screenHeight * 0.25,
                          decoration: BoxDecoration(
                              color: whiteTint,
                              borderRadius: BorderRadius.circular(11)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: buildCommentTextField(context,
                                'Enter a comment', commentTextController),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCommentTextField(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: buildRobotoTextStyle(18, textColor),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: neutral,
              ),
              onPressed: () {
                newComment(widget.post.postID, uid, comment, widget.post.title);
              },
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFormField(
            maxLength: 140,
            controller: controller,
            onChanged: (value) {
              setState(() {
                comment = value;
              });
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a comment';
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
        )
      ],
    );
  }

  newComment(
      String postID, String authorID, String comment, String title) async {
    await DatabaseService().createComment(postID, authorID, comment, title);
    Navigator.pop(context);
  }
}
