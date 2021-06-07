import 'package:callout/models/post.dart';
import 'package:callout/services/auth.dart';
import 'package:callout/styling/custom_text_styles.dart';
import 'package:callout/widgets/drawer.dart';
import 'package:callout/widgets/post_card_list.dart';
import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:callout/pages/write_post.dart';
import 'package:callout/pages/full_map_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:callout/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geodesy/geodesy.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //For User Location
  Position _currentPositon;
  bool _locationLoaded = false;
  _goToFullMap() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FullMap(
                  currentPosition: _currentPositon,
                )));
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPositon = position;
        _locationLoaded = true;
        // print("Getting Location:");
        // print(_currentPositon);
      });
      _goToFullMap();
    }).catchError((e) {
      print(e);
    });
  }

  //For Auth stuffs
  final AuthService _auth = AuthService();

  //For ordering posts
  Stream<List<Post>> streamValue = DatabaseService().posts;

  //For choicechips
  int _selectedChoiceChip = 1;

  Widget _buildChip(String label, int id, Stream<List<Post>> stream) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedChoiceChip = id;
          streamValue = stream;
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
    // _getCurrentLocation();
    // Geodesy geodesy = Geodesy();
    // num distance = geodesy.distanceBetweenTwoGeoPoints(
    //     LatLng(_currentPositon.latitude, _currentPositon.longitude),
    //     LatLng(20.59, 78.96));
    // print(distance);
    return StreamProvider<List<Post>>.value(
      initialData: [],
      value: streamValue,
      child: Scaffold(
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
                      _scrollToTop();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.location_on_rounded,
                      size: 30,
                      color: textColor,
                    ),
                    onPressed: () async {
                      _getCurrentLocation();
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
                    _buildChip('New', 1, DatabaseService().posts),
                    _buildChip('Trending', 2, DatabaseService().postsByStars),
                    _buildChip('Location', 3, DatabaseService().postsByLocation)
                  ],
                ),
                PostCardList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
