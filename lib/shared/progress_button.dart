import 'package:flutter/material.dart';
import 'package:vital_circle/themes/theme.dart';

enum ProgressButtonType {
  Raised,
  Flat,
  Outline,
}

enum ProgressButtonFeel { Primary, Secondary }

class ProgressButton extends StatelessWidget {
  const ProgressButton({
    this.feel = ProgressButtonFeel.Primary,
    this.height = BUTTON_HEIGHT,
    @required this.type,
    @required this.label,
    this.isFullWidth = false,
    this.isHalfWidth = false,
    this.isProcessing = false,
    @required this.onPressed,
  });

  final ProgressButtonFeel feel;
  final double height;
  final String label;
  final bool isFullWidth;
  final bool isHalfWidth;
  final bool isProcessing;
  final VoidCallback onPressed;
  final ProgressButtonType type;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _buildButton(context),
      height: height,
      // First, check to see if full width is set (takes priority)
      width: isFullWidth
          ? double.infinity
          // then check to see if half width is enabled
          : isHalfWidth ? MediaQuery.of(context).size.width / 2 : null,
    );
  }

  Widget _buildButton(BuildContext context) {
    final color = onPressed == null ? AppColors.buttonDisabled : _getColor();

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
    final color = type == ProgressButtonType.Raised ? AppColors.textLight : _getColor();
    return CircularProgressIndicator(backgroundColor: color);
  }

  Widget _buildLabel(BuildContext context) {
    final color = type == ProgressButtonType.Raised ? AppColors.textLight : _getColor();
    return Text(label, style: Theme.of(context).textTheme.button.copyWith(color: color));
  }

  Color _getColor() {
    switch (feel) {
      case ProgressButtonFeel.Primary:
        return AppColors.primary;
      case ProgressButtonFeel.Secondary:
        return AppColors.secondary;
    }
    return AppColors.disabled;
  }
}
