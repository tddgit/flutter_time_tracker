import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;

  // final VoidCallback onSignOut;

  const HomePage({
    required this.auth,
  });

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      // onSignOut();
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            onPressed: _signOut,
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
