import 'package:flutter/material.dart';

import 'package:vital_circle/themes/theme.dart';

class SelectionCard extends StatelessWidget {
  const SelectionCard({@required this.title, this.selected = false});

  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: AppTypography.bodyRegular1),
                const SizedBox(height: 4),
                // if (subtitle != null) WrappedText(child: Text(subtitle)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          selected ? Icon(Icons.check_circle) : Icon(Icons.panorama_fish_eye, color: AppColors.cardBorder),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    );
  }
}

class SelectionCardSmall extends StatelessWidget {
  const SelectionCardSmall({@required this.title, @required this.icon, this.selected = false});

  final String title;
  final bool selected;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .35,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ImageIcon(
              icon.image,
              color: selected ? null : AppColors.iconDisabled,
            ),
            Flexible(
              child: Text(
                title,
                style: AppTypography.bodyRegular1,
                textAlign: TextAlign.center,
              ),
            ),
            selected
                ? Icon(Icons.check_circle)
                : Icon(
                    Icons.panorama_fish_eye,
                    color: AppColors.cardBorder,
                  ),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    );
  }
}
