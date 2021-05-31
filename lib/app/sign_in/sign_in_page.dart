import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_button.dart';
import 'package:flutter_time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_time_tracker/services/auth.dart';

import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  // final Function(CustomUser?) onSignIn;
  final AuthBase auth;

  const SignInPage({
    required this.auth,
  });

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
      // onSignIn(user);
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print(err);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.googleSignIn();
      // onSignIn(user);
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print(err.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (BuildContext context) => EmailSignInPage(auth: auth),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2,
      ),
      body: _buildContainer(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 48),
          SocialSignInButton(
            assetName: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: _signInWithGoogle,
          ),
          const SizedBox(height: 8),
          SocialSignInButton(
            assetName: 'assets/images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: const Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          const SizedBox(height: 8),
          SignInButton(
            color: Colors.teal[700]!,
            text: 'Sign in with email',
            textColor: Colors.black87,
            onPressed: () => _signInWithEmail(context),
          ),
          const SizedBox(height: 8),
          const Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          SignInButton(
            color: Colors.lime[300]!,
            text: 'Go anonymous',
            textColor: Colors.black87,
            onPressed: _signInAnonymously,
          ),

          // Image.asset('assets/images/google-logo.png'),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AuthBase>('auth', auth));
  }
}
