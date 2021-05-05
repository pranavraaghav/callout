import 'package:flutter/material.dart';
import 'package:callout/widgets/post_card.dart';

// NOTE
// Nav made this as background to help
// working on post_card.dart
// This may or may not be deleted afterward

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Color(0xEAF0F8),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              PostCard(
                username: 'Pranav',
                location: 'South India',
                title: 'Too many northies here',
                content:
                    'BJP gay, Stalin thaan vararu nallatchi thara poraru. DMK ftw. Thamizhenda ennaalum.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
