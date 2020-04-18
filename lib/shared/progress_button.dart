import 'package:flutter/material.dart';
import 'package:vital_circle/themes/theme.dart';

enum ProgressButtonType {
  Raised,
  Flat,
  Outline,
}

class ProgressButton extends StatelessWidget {
  const ProgressButton({
    this.height = BUTTON_HEIGHT,
    @required this.type,
    @required this.label,
    this.isFullWidth = false,
    this.isProcessing = false,
    @required this.onPressed,
  });

  final double height;
  final String label;
  final bool isFullWidth;
  final bool isProcessing;
  final VoidCallback onPressed;
  final ProgressButtonType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildButton(context),
      height: height,
      width: isFullWidth ? double.infinity : null,
    );
  }

  Widget _buildButton(BuildContext context) {
    final color = onPressed == null ? AppColors.buttonDisabled : AppColors.button;

    switch (type) {
      case ProgressButtonType.Raised:
        return RaisedButton(
          color: color,
          child: _buildContent(context),
          onPressed: isProcessing
              ? null
              : () {
                  onPressed();
                },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS)),
        );
      case ProgressButtonType.Flat:
        return FlatButton(
          child: _buildContent(context),
          onPressed: isProcessing
              ? null
              : () {
                  onPressed();
                },
        );
      case ProgressButtonType.Outline:
        return OutlineButton(
          child: _buildContent(context),
          onPressed: isProcessing
              ? null
              : () {
                  onPressed();
                },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BUTTON_BORDER_RADIUS),
            side: BorderSide(color: color),
          ),
        );
      default:
        throw Exception('Invalid button type: $type');
    }
  }

  Widget _buildContent(BuildContext context) {
    return isProcessing ? _buildProgressIndicator() : _buildLabel(context);
  }

  Widget _buildProgressIndicator() {
    final color = type == ProgressButtonType.Raised ? AppColors.textLight : AppColors.primary;
    return CircularProgressIndicator(backgroundColor: color);
  }

  Widget _buildLabel(BuildContext context) {
    final color = type == ProgressButtonType.Raised ? AppColors.textLight : AppColors.primary;
    return Text(label, style: Theme.of(context).textTheme.button.copyWith(color: color));
  }
}
