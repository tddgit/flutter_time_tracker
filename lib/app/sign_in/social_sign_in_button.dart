import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/common_widgets/common_raised_button.dart';

class SocialSignInButton extends CommonRaisedButton {
  SocialSignInButton({
    required String assetName,
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(assetName),
              Text(text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15.0,
                  )),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
