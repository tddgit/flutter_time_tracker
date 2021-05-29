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
}

class _EmailSignInFormState

extend s
State<EmailSignInForm> {

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

void _submit() async {
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
    }
  } catch (e) {
    print(e.toString());
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

void _passwordEditingComplete() {
  // FocusScope.of(context).requestFocus(_passwordFocusNode);
}

void _emailEditingComplete() {
  print('password editing complete');
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
  final primaryText = _formType == EmailSignInFormType.signIn
      ? 'Sign in'
      : 'Create an account';
  final secondaryText = _formType == EmailSignInFormType.register
      ? 'Need an accout? Register'
      : 'Have an account? Sign in';

  bool submitEnabled = widget.emailValidator.isValid(_email) &&
      widget.passwordValidator.isValid(_password) &&
      !_isLoading;

  return [
    _buildEmailTextField(),
    SizedBox(height: 8.0),
    _buildPasswordTextField(),
    SizedBox(height: 8.0),
    FormSubmitButton(
      text: primaryText,
      onPressed: submitEnabled ? _submit : null,
    ),
    SizedBox(height: 8.0),
    FlatButton(
      child: Text(secondaryText),
      onPressed: !_isLoading ? _toggleFormType : null,
    )
  ];
}

TextField _buildPasswordTextField() {
  bool showErrorText =
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
    onEditingComplete: _passwordEditingComplete,
    onChanged: (password) => _updateState(),
  );
}

TextField _buildEmailTextField() {
  bool showErrorText = _submitted && widget.emailValidator.isValid(_email);
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
    onChanged: (email) => _updateState(),
  );
}

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
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
}}
