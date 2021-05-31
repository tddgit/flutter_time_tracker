import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/email_sign_in_form.dart';
import 'package:flutter_time_tracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  const EmailSignInPage({required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Tracker'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(child: EmailSignInForm(auth: auth)),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AuthBase>('auth', auth));
  }
}
