import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/common_widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  final String title;
  final String content;
  final String defaultActionText;

  PlatformAlertDialog({
    required this.title,
    required this.content,
    required this.defaultActionText,
  })  : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  Future<bool?> show(BuildContext context) async {
    return showDialog<bool?>(
      context: context,
      builder: (BuildContext context) => this,
    );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    //TODO:
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(defaultActionText),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    //TODO:
    return AlertDialog(
      title: Text(
        title,
      ),
      content: Text(defaultActionText),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('defaultActionText', defaultActionText))
      ..add(StringProperty('content', content))
      ..properties.add(StringProperty('title', title));
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  PlatformAlertDialogAction({required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(onPressed: onPressed, child: child);
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(onPressed: onPressed, child: child);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed));
  }
}
