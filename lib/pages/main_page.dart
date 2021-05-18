import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:callout/pages/write_post.dart';
import 'package:callout/pages/full_map_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //For choicechips
  int _selectedChoiceChip = 2;

  Widget _buildChip(label, id) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedChoiceChip = id;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        color: _selectedChoiceChip == id ? primary : cardGray,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //For scroll to top
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
  }
  //

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
      drawer: Drawer(
        child: Container(
          color: primary,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 60,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(animationDuration: Duration(seconds: 2)),
                ),
                Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
                  child: TextButton(
                    onPressed: () {
                      //Navigate to Starred Posts
                    },
                    child: Text(
                      'STARRED POSTS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 16, 0, 16),
                  child: TextButton(
                    onPressed: () {
                      //Navigate back to Login
                    },
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
                    _scrollToTop();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.location_on_rounded,
                    size: 30,
                    color: textColor,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FullMap()));
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
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildChip('New', 1),
                  _buildChip('Trending', 2),
                  _buildChip('Following', 3)
                ],
              ),
              Column(
                children: [
                  PostCard(),
                  PostCard(),
                  PostCard(),
                  PostCard(),
                  PostCard()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
