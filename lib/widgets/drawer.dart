import 'package:callout/models/user.dart';
import 'package:callout/pages/login_page.dart';
import 'package:callout/pages/main_page.dart';
import 'package:callout/services/auth.dart';
import 'package:callout/services/database.dart';
import 'package:callout/styling/color_palettes.dart';
import 'package:callout/styling/custom_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final AuthService _auth = AuthService();

  String _displayName = 'User';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CalloutUser>(context);

    return StreamBuilder<CalloutUser>(
        stream: DatabaseService(uid: user.uid).userByUid,
        builder: (context, snapshot) {
          if (snapshot.data != null) _displayName = snapshot.data.displayName;

          return Drawer(
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
                      style:
                          ButtonStyle(animationDuration: Duration(seconds: 2)),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                      child: TextButton(
                        onPressed: () {
                          //Navigate to Starred Posts
                        },
                        child: Text('Welcome $_displayName',
                            style: buildRobotoDrawerTextStyle(
                                20, Colors.white, FontWeight.bold)),
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                      child: TextButton(
                        onPressed: () {
                          //Navigate to Starred Posts
                        },
                        child: Text('STARRED POSTS',
                            style: buildRobotoDrawerTextStyle(
                                20, Colors.white, FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
                      child: TextButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text('LOGOUT',
                            style: buildRobotoDrawerTextStyle(
                                20, Colors.white, FontWeight.bold)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
