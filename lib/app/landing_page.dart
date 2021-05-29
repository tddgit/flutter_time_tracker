import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_page.dart';
import 'package:flutter_time_tracker/services/auth.dart';

import 'home_page.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  LandingPage({required this.auth});

  @override
  Widget build(BuildContext context) {
    // Stream<CustomUser?> customUserStream =
    //     StreamController<CustomUser?>().stream;
    // widget.auth.onAuthStateChanged.then((stream) => customUserStream = stream);

    return StreamBuilder<CustomUser?>(
      stream: auth.onAuthStateChanged,
      // initialData: null,
      builder: (context, snapshot) {
        print('StreamBuilder:');
        print(snapshot.connectionState);

        if (snapshot.connectionState == ConnectionState.active) {
          CustomUser? user = snapshot.data;
          print('snapshot.hasData:');
          if (user == null) {
            return SignInPage(
              auth: auth,
              // onSignIn: _updateUser,
            );
          }

          return HomePage(
            auth: auth,
            // onSignOut: () => _updateUser(null),
          );
        } else {
          // return SignInPage(
          //   auth: auth,
          //   // onSignIn: _updateUser,
          // );
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
// Stream<CustomUser?> customUserStream = StreamController<CustomUser?>().stream;
//
// Future<void> _checkCurrentUser() async {
//   try {
//     CustomUser? user = await widget.auth.currentUser();
//     _updateUser(user);
//   } catch (err) {
//     print(err);
//   }
// }

//
// Future<void> _checkOnAuthStateChanged() async {
//   customUserStream = await widget.auth.onAuthStateChanged;
//   await _checkCurrentUser();
// }

//
// @override
// void initState() {
//   print('initState()');
//   _checkOnAuthStateChanged();
//
//   // customUserStream.listen((user) {
//   //   print('customUserStream: Status changed: user ${user?.uid}');
//   // });
//   super.initState();
// }
//
// void _updateUser(CustomUser? user) {
//   setState(() {
//     _user = user;
//   });
// }
}
