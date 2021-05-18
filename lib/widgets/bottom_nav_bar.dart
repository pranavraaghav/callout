import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/pages/full_map_page.dart';
import 'package:callout/pages/write_post.dart';
import 'package:callout/pages/main_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //For scroll to top
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(seconds: 2), curve: Curves.fastLinearToSlowEaseIn);
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
