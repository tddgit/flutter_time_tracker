import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/sign_in_button.dart';
import 'package:flutter_time_tracker/app/sign_in/social_sign_in_button.dart';
import 'package:flutter_time_tracker/services/auth.dart';

import 'email_sign_in_page.dart';

class SignInPage extends StatelessWidget {
  // final Function(CustomUser?) onSignIn;
  final AuthBase auth;

  SignInPage({
    required this.auth,
  });

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
      // onSignIn(user);
    } catch (err) {
      print(err);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.googleSignIn();
      // onSignIn(user);
    } catch (err) {
      print(err.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(auth: auth),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContainer(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 48),
          SocialSignInButton(
            assetName: 'assets/images/google-logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: _signInWithGoogle,
          ),
          SizedBox(height: 8),
          SocialSignInButton(
            assetName: 'assets/images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),
          SizedBox(height: 8),
          SignInButton(
            color: Colors.teal[700]!,
            text: 'Sign in with email',
            textColor: Colors.black87,
            onPressed: () => _signInWithEmail(context),
          ),
          SizedBox(height: 8),
          Text(
            'or',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
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
}
