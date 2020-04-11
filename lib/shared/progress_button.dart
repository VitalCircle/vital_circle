import 'package:flutter/material.dart';

enum ProgressButtonType {
  Raised,
  Flat,
  Outline,
}

class ProgressButton extends StatelessWidget {
  const ProgressButton(
      {this.height = 40,
      @required this.type,
      @required this.label,
      @required this.isProcessing,
      @required this.onPressed,
      this.color});

  final Color color;
  final double height;
  final Widget label;
  final bool isProcessing;
  final Future<dynamic> Function() onPressed;
  final ProgressButtonType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildButton(context),
      height: height,
    );
  }

  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ProgressButtonType.Raised:
        return RaisedButton(
          color: color,
          child: _buildContent(),
          onPressed: isProcessing
              ? null
              : () async {
                  await onPressed();
                },
        );
      case ProgressButtonType.Flat:
        return FlatButton(
          color: color,
          child: _buildContent(),
          onPressed: isProcessing
              ? null
              : () async {
                  await onPressed();
                },
        );
      case ProgressButtonType.Outline:
        return OutlineButton(
          color: color,
          child: _buildContent(),
          onPressed: isProcessing
              ? null
              : () async {
                  await onPressed();
                },
        );
      default:
        throw Exception('Invalid button type: $type');
    }
  }

  Widget _buildContent() {
    return isProcessing ? const CircularProgressIndicator() : label;
  }
}
