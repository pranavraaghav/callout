import 'package:callout/models/post.dart';
import 'package:flutter/material.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:provider/provider.dart';

class PostCardList extends StatefulWidget {
  @override
  _PostCardListState createState() => _PostCardListState();
}

class _PostCardListState extends State<PostCardList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context);

    // posts.forEach((post) {
    //   print(post.title);
    //   print(post.createdAt.toDate());
    // });

    return ListView.builder(
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: posts[index]);
        });
  }
}
