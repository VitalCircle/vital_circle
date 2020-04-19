import 'package:flutter/material.dart';

import '../../themes/theme.dart';
import '../shared.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard(
      {@required this.icon,
      @required this.title,
      this.subtitle,
      this.routeName});

  final IconData icon;
  final String title;
  final String subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: AppTypography.bodyBold),
                  const SizedBox(height: 4),
                  if (subtitle != null) WrappedText(child: Text(subtitle)),
                ],
              ),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      ),
      onTap: routeName == null
          ? null
          : () {
              Navigator.of(context).pushNamed(routeName);
            },
    );
  }
}
