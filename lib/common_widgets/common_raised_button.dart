import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final double borderRadius;
  final double height;
  final VoidCallback? onPressed;

  const CustomRaisedButton({
    required this.child,
    required this.color,
    required this.onPressed,
    this.borderRadius = 2,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      // ignore: deprecated_member_use
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        color: color,
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('color', color))
      ..add(DoubleProperty('borderRadius', borderRadius))
      ..add(DoubleProperty('height', height))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed));
  }
}
