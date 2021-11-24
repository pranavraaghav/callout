import 'package:callout/models/user.dart';
import 'package:callout/pages/loading_page.dart';
import 'package:callout/services/auth.dart';
import 'package:callout/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:callout/pages/main_page.dart';
import 'package:callout/pages/authenticate/authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // apparently this only works on android ? https://tinyurl.com/dylpcq85
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<CalloutUser>.value(
      initialData: CalloutUser(
          uid: null, displayName: null, email: null, photoURL: null),
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
