import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/common_widgets/common_raised_button.dart';

class FormSubmitButton extends CustomRaisedButton {
  FormSubmitButton({
    required String text,
    VoidCallback? onPressed,
  }) : super(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          height: 44,
          color: Colors.indigo,
          borderRadius: 4,
          onPressed: onPressed,
        );
}
