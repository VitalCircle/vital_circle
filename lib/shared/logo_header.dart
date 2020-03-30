import 'package:flutter/material.dart';
import 'package:teamtemp/constants/images.dart';
import 'package:teamtemp/themes/theme.dart';

const LOGO_FONT_SIZE = 48.0;

class LogoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 150, child: Image(image: AssetImage(Images.LOGO), fit: BoxFit.contain)),
            const SizedBox(width: Spacers.lg),
            Column(
              children: <Widget>[
                Text('Vital',
                    style: Theme.of(context)
                        .textTheme
                        .display3
                        .copyWith(fontSize: LOGO_FONT_SIZE, color: AppColors.brandPrimary)),
                Container(
                  child: Text(
                    'Circle',
                    style: Theme.of(context)
                        .textTheme
                        .display3
                        .copyWith(fontSize: LOGO_FONT_SIZE, color: AppColors.brandSecondary),
                  ),
                  margin: const EdgeInsets.only(left: Spacers.xl),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
            )
          ],
        )
      ],
    );
  }
}
