import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_page.dart';

import 'home_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  Future<void> _checkCurrentUser() async {
    try {
      Firebase.initializeApp().whenComplete(() async {
        User? user = await FirebaseAuth.instance.currentUser;
        _updateUser(user);
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    _checkCurrentUser();
    super.initState();
  }

  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return SignInPage(onSignIn: _updateUser);
    }

    return HomePage(
      onSignOut: () => _updateUser(null),
    );
  }
}
