import 'package:callout/models/comment.dart';
import 'package:callout/models/post.dart';
import 'package:callout/widgets/comment_card.dart';
import 'package:flutter/material.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:provider/provider.dart';

class CommentCardList extends StatefulWidget {
  List<Comment> comments;

  CommentCardList({this.comments});
  @override
  _CommentCardListState createState() => _CommentCardListState();
}

class _CommentCardListState extends State<CommentCardList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.comments.length,
        itemBuilder: (context, index) {
          return CommentCard(
            comment: widget.comments[index],
          );
          // children: widget.comments.map<CommentCard>((comment) {
          //   return CommentCard(
          //     comment: comment,
          //   );
          // }).toList(),
        });
  }
}
