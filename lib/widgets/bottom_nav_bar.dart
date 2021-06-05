import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/pages/full_map_page.dart';
import 'package:callout/pages/write_post.dart';
import 'package:callout/pages/main_page.dart';
import 'package:geolocator/geolocator.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

//NOTE : MainPage uses its own Bottom Nav Bar
//due to the fact that tapping home should only scroll to top rather than push anothe MainPage on top of it

class _BottomNavBarState extends State<BottomNavBar> {
  //For scroll to top
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
  }

  Position _currentPositon;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPositon = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  print(_currentPositon);
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
        ));
  }
}
