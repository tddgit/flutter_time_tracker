import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/sign_in/validators.dart';
import 'package:flutter_time_tracker/common_widgets/form_submit_button.dart';
import 'package:flutter_time_tracker/services/auth.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidators {
  final AuthBase auth;

  EmailSignInForm({required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AuthBase>('auth', auth));
  }
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _submitted = false;
  bool _isLoading = false;

  String email = '';

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  Future<void> _submit() async {
    // print('submit called');
    setState(() {
      _submitted = true;
    });
    try {
      // await Future.delayed(
      //   Duration(seconds: 3),
      // );
      if (_formType == EmailSignInFormType.signIn) {
        widget.auth.signInWithEmailAndPassword(
          _email,
          _password,
        );
      } else {
        widget.auth.createUserWithEmailAndPassword(
          _email,
          _password,
        );
        Navigator.of(context).pop();
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      // print(e.toString());
      Platform.isIOS
          // ? showCupertinoDialog(
          //     context: context,
          // ignore: avoid_catches_without_on_clauses
          //     builder: () {},
          //   )
          ? Container()
          : showDialog<AlertDialog>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Sign in failed'),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK'),
                      )
                    ]);
              },
            );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _emailEditingComplete() {
    final FocusNode newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
      _emailController.clear();
      _passwordController.clear();
    });
  }

  List<Widget> _buildChildren() {
    final String primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign in'
        : 'Create an account';
    final String secondaryText = _formType == EmailSignInFormType.register
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    final bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return <Widget>[
      _buildEmailTextField(),
      const SizedBox(height: 8),
      _buildPasswordTextField(),
      const SizedBox(height: 8),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      const SizedBox(height: 8),
      FlatButton(
        onPressed: !_isLoading ? _toggleFormType : null,
        child: Text(secondaryText),
      )
    ];
  }

  TextField _buildPasswordTextField() {
    final bool showErrorText =
        _submitted && widget.passwordValidator.isValid(_password);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      autocorrect: false,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
      onChanged: (String password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    final bool showErrorText =
        _submitted && widget.emailValidator.isValid(_email);
    return TextField(
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      controller: _emailController,
      focusNode: _emailFocusNode,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (String email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _updateState() {
    setState(
      () {},
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('email', email));
  }
}
