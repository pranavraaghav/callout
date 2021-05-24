import 'package:callout/models/post.dart';
import 'package:callout/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/pages/write_post.dart';
import 'package:callout/pages/main_page.dart';
import 'package:callout/widgets/full_post_card.dart';
import 'package:callout/widgets/comment_card.dart';

class FullPostPage extends StatefulWidget {
  final Post post;
  FullPostPage({this.post});
  @override
  _FullPostPageState createState() => _FullPostPageState();
}

class _FullPostPageState extends State<FullPostPage> {
  //For the search bar
  final TextEditingController _searchFilter = new TextEditingController();
  String _searchBarText;
  List searchTerms;
  List filteredSearchTerms;

  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.white,
  );

  Widget _appBarField = Container();
  void _getNames() {
    setState(() {
      searchTerms = [
        'Issue 1',
        'Issue 2',
        'Problem 3',
        'Topic 4',
      ];
      filteredSearchTerms = searchTerms;
    });
  }

  //Converts the search icon to close icon
  //Place a TextField to type stuff in
  void _searchIconPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarField = SizedBox(
          width: 200,
          child: new TextField(
            style: TextStyle(color: whiteTint),
            controller: _searchFilter,
            decoration: InputDecoration(
              hintText: 'Type here',
            ),
          ),
        );
      } else {
        this._searchIcon = Icon(
          Icons.search,
          color: Colors.white,
        );
        this._appBarField = Container();
        filteredSearchTerms = searchTerms;
        _searchFilter.clear();
      }
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        actions: [
          _appBarField,
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: IconButton(
                onPressed: () {
                  _getNames();
                  _searchIconPressed();
                },
                icon: _searchIcon),
          )
        ],
        backgroundColor: primary,
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: Container(
          color: whiteTint,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: textColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainPage()));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.location_on_rounded,
                    size: 30,
                    color: textColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WritePost()));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    size: 30,
                    color: textColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WritePost()));
                  })
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                FullPostCard(
                  post: widget.post,
                ),
                CommentCard(),
                CommentCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
