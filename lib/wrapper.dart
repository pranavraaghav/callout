import 'package:callout/models/user.dart';
import 'package:callout/pages/authenticate/authenticate.dart';
import 'package:callout/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CalloutUser>(context);
    //print(user.uid);
    if (user == null) {
      return Authenticate();
    } else {
      return MainPage();
    }
  }
}
