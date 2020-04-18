import 'package:flutter/material.dart';
import 'package:vital_circle/routes.dart';
import 'package:vital_circle/shared/shared.dart';
import 'package:vital_circle/themes/theme.dart';

import 'dashboard.vm.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<DashboardViewModel>(
      model: DashboardViewModel.of(context),
      onModelReady: (model) {
        model.onInit();
      },
      builder: (context, model, child) {
        return Scaffold(
          appBar: SharedAppBar(
            title: const Text('Vital Circle'),
          ),
          body: Builder(builder: (BuildContext context) {
            return _buildScreen(context, model);
          }),
          drawer: DrawerWidget(),
        );
      },
    );
  }

  Widget _buildScreen(BuildContext context, DashboardViewModel model) {
    if (!model.isReady) {
      return _buildLoading();
    }
    return _buildDashboard(context, model);
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildDashboard(BuildContext context, DashboardViewModel model) {
    return Container(
      child: Column(
        children: [
          _buildGreeting(),
          const SizedBox(height: Spacers.lg),
          model.hasCheckedInToday
              ? _buildCard(context, Icons.check_circle, 'Thank you for checking in today!')
              : _buildCard(
                  context,
                  Icons.check_circle_outline,
                  'Check-in',
                  'Log your symptoms and temperature.',
                  RouteName.Checkin,
                ),
          const SizedBox(height: Spacers.md),
          _buildCard(
            context,
            Icons.calendar_today,
            'History',
            'Look at your previous symptoms and edit records.',
            RouteName.CheckinHistory,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      padding: const EdgeInsets.all(24),
    );
  }

  Widget _buildGreeting() {
    return Text(
      'Good day, Human',
      style: AppTypography.h1,
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, [String subtitle, String routeName]) {
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
