import 'package:flutter/material.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/widgets/post_card.dart';
import 'package:callout/pages/write_post.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBG,
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WritePost()));
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
          )
          // BottomNavigationBar(
          //   elevation: 10,
          //   iconSize: 30,
          //   backgroundColor: whiteTint,
          //   selectedItemColor: textColor,
          //   unselectedItemColor: textColor,
          //   items: [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.home),
          //       label: '',
          //     ),
          //     BottomNavigationBarItem(
          //         icon: Icon(Icons.location_on_rounded), label: ''),
          //     BottomNavigationBarItem(icon: Icon(Icons.edit), label: ''),
          //   ],
          // ),
          ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeCards(
                  label: 'New',
                ),
                HomeCards(
                  label: 'Nearby',
                ),
                HomeCards(
                  label: 'Following',
                )
              ],
            ),
            Column(
              children: [PostCard()],
            )
          ],
        ),
      ),
    );
  }
}

class HomeCards extends StatelessWidget {
  String label;
  HomeCards({label}) {
    this.label = label;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: cardGray,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
