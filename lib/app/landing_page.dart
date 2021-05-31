import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/home_page.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_page.dart';
import 'package:flutter_time_tracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  const LandingPage({required this.auth});

  @override
  Widget build(BuildContext context) {
    // Stream<CustomUser?> customUserStream =
    //     StreamController<CustomUser?>().stream;
    // widget.auth.onAuthStateChanged.then((stream) => customUserStream = stream);

    return StreamBuilder<CustomUser?>(
      stream: auth.onAuthStateChanged,
      // initialData: null,
      builder: (BuildContext context, AsyncSnapshot<CustomUser?> snapshot) {
        print('StreamBuilder:');
        print(snapshot.connectionState);

        if (snapshot.connectionState == ConnectionState.active) {
          final CustomUser? user = snapshot.data;
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AuthBase>('auth', auth));
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
