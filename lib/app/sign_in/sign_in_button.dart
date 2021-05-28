import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/common_widgets/common_raised_button.dart';

class SignInButton extends CommonRaisedButton {
  SignInButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
            ),
          ),
          color: color,
          onPressed: onPressed,
        );
}
